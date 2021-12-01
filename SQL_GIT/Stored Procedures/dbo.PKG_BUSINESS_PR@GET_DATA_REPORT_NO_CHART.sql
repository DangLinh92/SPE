SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_PR@GET_DATA_REPORT_NO_CHART](
@A_DEPARTMENT		NVARCHAR(50),
@A_PR_CODE			NVARCHAR(50),
@A_MRP_CODE         NVARCHAR(50),
@A_DATE             NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			SELECT 
			    ROW_NUMBER() OVER(ORDER BY SP.CODE ASC) AS STT,
				SP.GL_ACCOUNT, 
				SPD.COST_CTR,
				SP.CODE + ':' + SP.NAME_VI AS NAME_VI,
				SP.CODE + ':' +SP.NAME_KR AS NAME_KR,
				SP.IMAGE,
				CASE WHEN MRP.UNIT = SUNIT.UNIT_CODE_MIN THEN MRP.UNIT ELSE MRP.UNIT + CHAR(13)+CHAR(10) + ' (' + CAST(SUNIT.RATE AS NVARCHAR) + ' ' + SUNIT.UNIT_CODE_MIN + ')' END AS UNIT,
				(CASE WHEN INVTIME.QUANTITY_REAL = 0 OR INVTIME.QUANTITY_REAL IS NULL THEN [dbo].[CONVERT_UNIT](INVTIME.[UNIT],MRP.UNIT,SP.CODE,@A_DEPARTMENT) * ISNULL(INVTIME.QUANTITY,0)
				     ELSE [dbo].[CONVERT_UNIT](INVTIME.[UNIT],MRP.UNIT,SP.CODE,@A_DEPARTMENT) * ISNULL(INVTIME.QUANTITY_REAL,0)
				END) AS INVENTORY_LAST_MONTH,
				[dbo].[CONVERT_UNIT]('PACK',MRP.UNIT,SP.CODE,@A_DEPARTMENT) * ISNULL(SUB1.PO_LAST_M,0) AS QUANTITY_ORDERD,
				[dbo].[CONVERT_UNIT]('PACK',MRP.UNIT,SP.CODE,@A_DEPARTMENT) * ISNULL(SUB.QUANTITY_USE_CURRENT,0) AS QUANTITY_CURRENT_USE,
				[dbo].[CONVERT_UNIT](BOM_M.[UNIT],MRP.UNIT,SP.CODE,@A_DEPARTMENT) * ISNULL(BOM_M.[WORKING_A_MONTH],0) AS QUANTITY_NEXT_1_M_USE,
				[dbo].[CONVERT_UNIT](BOM_M.[UNIT],MRP.UNIT,SP.CODE,@A_DEPARTMENT) * ISNULL(BOM_M.[WORKING_A_MONTH],0) AS QUANTITY_NEXT_2_M_USE,
				[dbo].[CONVERT_UNIT](MINSTOCK.[UNIT_CODE],MRP.UNIT,SP.CODE,@A_DEPARTMENT)  * ISNULL(MINSTOCK.MIN_STOCK,0) AS MIN_STOCK,
				MRP.QUANTITY_NEED_BUY,
				(CASE WHEN PRD.[PRICE_VN] IS NULL OR PRD.[PRICE_VN] = 0 THEN price.PRICE_VN/[dbo].[CONVERT_UNIT](price.UNIT_CODE,MRP.UNIT,sp.CODE,@A_DEPARTMENT)
				     ELSE PRD.[PRICE_VN]/[dbo].[CONVERT_UNIT](PRD.UNIT,MRP.UNIT,sp.CODE,@A_DEPARTMENT)
				END) AS PRICE_VN,
				(CASE WHEN PRD.[PRICE_US] IS NULL OR PRD.[PRICE_US] = 0 THEN price.PRICE_US/[dbo].[CONVERT_UNIT](price.UNIT_CODE,MRP.UNIT,sp.CODE,@A_DEPARTMENT)
				     ELSE PRD.[PRICE_US]/[dbo].[CONVERT_UNIT](PRD.UNIT,MRP.UNIT,sp.CODE,@A_DEPARTMENT)
				END) AS PRICE_US,
				(CASE WHEN PRD.[TOTAL_MONEY_VN] IS NULL OR PRD.[TOTAL_MONEY_VN] = 0 THEN (price.PRICE_VN/[dbo].[CONVERT_UNIT](price.UNIT_CODE,MRP.UNIT,sp.CODE,@A_DEPARTMENT)) * ISNULL(MRP.QUANTITY_NEED_BUY,0)
				     ELSE PRD.[TOTAL_MONEY_VN]
				END) AS [TOTAL_MONEY_VN],
				(CASE WHEN PRD.[TOTAL_MONEY_US] IS NULL OR PRD.[TOTAL_MONEY_US] = 0 THEN (price.PRICE_US/[dbo].[CONVERT_UNIT](price.UNIT_CODE,MRP.UNIT,sp.CODE,@A_DEPARTMENT)) * ISNULL(MRP.QUANTITY_NEED_BUY,0)
				     ELSE PRD.[TOTAL_MONEY_US]
				END) AS [TOTAL_MONEY_US],
				(CASE WHEN PRD.[VENDOR_ID] IS NULL OR PRD.[VENDOR_ID] = '' THEN V.NAME
				    ELSE VD.NAME END) AS VENDOR_ID,
				MRP.DATE_NEED_FINISH,
				sp.SPECIFICATIONS,
				ROUND(sp.LEAD_TIME/7,2) AS LEAD_TIME
			FROM [dbo].[EWIP_MRP] MRP
			INNER JOIN [dbo].[EWIP_SPARE_PART] SP ON MRP.SPAREPART_CODE = SP.CODE AND SP.SP_DEPT_CODE = MRP.DEPT_CODE
			INNER JOIN [dbo].[EWIP_SPARE_PART_DEPT] SPD ON MRP.SPAREPART_CODE  = SPD.SPARE_PART_CODE AND MRP.DEPT_CODE = SPD.DEPT_CODE
			INNER JOIN  [dbo].[EWIP_PURCHASE_REQUEST_DETAIL] PRD ON MRP.MRP_CODE = PRD.[MRP_CODE] AND MRP.DEPT_CODE = PRD.[DEPT_CODE] AND MRP.SPAREPART_CODE = PRD.[SPAREPART_CODE] AND PRD.[PR_CODE] = @A_PR_CODE
			LEFT JOIN   (
							SELECT TOP 1 WITH TIES 
							[SPARE_PART_CODE],
							[PRICE_VN],
							[PRICE_US], 
							[UNIT_CODE]
							FROM [dbo].[EWIP_SPAREPART_PRICE]
							WHERE [DEPT_CODE] = @A_DEPARTMENT 
							ORDER BY ROW_NUMBER() OVER(PARTITION BY SPARE_PART_CODE ORDER BY [DATE] DESC)
						) AS price ON MRP.SPAREPART_CODE = price.SPARE_PART_CODE
			 LEFT JOIN [dbo].[EWIP_VENDER] VD ON PRD.[VENDOR_ID] = VD.VENDER_ID
			 LEFT JOIN [dbo].[EWIP_SETUP_MINSTOCK] MINSTOCK ON MINSTOCK.DEPT_CODE = MRP.DEPT_CODE AND MINSTOCK.SPARE_PART_CODE = MRP.SPAREPART_CODE 
			 LEFT JOIN [dbo].[EWIP_INVENTORY_BY_TIME] INVTIME ON INVTIME.DEPT_CODE = MRP.DEPT_CODE AND INVTIME.SPARE_PART_CODE = MRP.SPAREPART_CODE AND INVTIME.MONTH = MONTH(DATEADD(MONTH,-1,CAST(@A_DATE AS date))) 
			           AND INVTIME.YEAR = YEAR(DATEADD(MONTH,-1,CAST(@A_DATE AS date))) 

			 LEFT JOIN (SELECT SUM(ISNULL([QUANTITY],0) * [dbo].[CONVERT_UNIT]([UNIT_ID],'PACK',SPARE_PART_CODE,@A_DEPARTMENT)) AS QUANTITY_USE_CURRENT,[DEPT_CODE],[SPARE_PART_CODE] 
						FROM [dbo].[EWIP_STOCK_OUT] OU
						 WHERE OU.DEPT_CODE = @A_DEPARTMENT AND OU.MONTH = MONTH(CAST(@A_DATE AS date)) AND OU.YEAR = YEAR(CAST(@A_DATE AS date))
						 GROUP BY [DEPT_CODE],[SPARE_PART_CODE]) SUB ON SUB.DEPT_CODE = MRP.DEPT_CODE AND SUB.SPARE_PART_CODE = MRP.SPAREPART_CODE

			 LEFT JOIN [dbo].[EWIP_BOM_BY_MONTH] BOM_M ON BOM_M.[DEPT_CODE] = MRP.DEPT_CODE AND BOM_M.[SPARE_PART_CODE] = MRP.SPAREPART_CODE AND 
			            BOM_M.[MONTH] = MONTH(DATEADD(MONTH,1,CAST(@A_DATE AS date)))  AND BOM_M.[YEART] = YEAR(DATEADD(MONTH,1,CAST(@A_DATE AS date))) 

			LEFT JOIN  (( SELECT SUM([dbo].[CONVERT_UNIT]([UNIT],'PACK',[SPAREPART_CODE],@A_DEPARTMENT) * ISNULL([QUANTITY_NEED_BUY],0)) AS PO_LAST_M,[DEPT_CODE],[SPAREPART_CODE] 
						 FROM  [dbo].[EWIP_PURCHASE_REQUEST_DETAIL] PRD_LAST_M 
			             WHERE 
						 FORMAT(PRD_LAST_M.[DATE_CREATE], 'yyyyMM')  =  FORMAT(DATEADD(MONTH,-1,CAST(@A_DATE AS date)), 'yyyyMM') AND PRD_LAST_M.STATUS = 'COMPLETE'
						 GROUP BY [DEPT_CODE],[SPAREPART_CODE])) AS SUB1 ON MRP.DEPT_CODE = SUB1.DEPT_CODE AND MRP.SPAREPART_CODE = SUB1.SPAREPART_CODE 
			LEFT JOIN [dbo].[EWIP_SPAREPART_UNIT] SUNIT ON SP.CODE = SUNIT.SPARE_PART_CODE AND SP.SP_DEPT_CODE = SUNIT.DEPT_CODE AND SUNIT.UNIT_CODE = MRP.UNIT
			LEFT JOIN EWIP_VENDER V ON SP.VENDER_ID = V.VENDER_ID
			WHERE MRP.DEPT_CODE = @A_DEPARTMENT AND MRP.MRP_CODE = @A_MRP_CODE AND PRD.[PR_CODE] = @A_PR_CODE

       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO