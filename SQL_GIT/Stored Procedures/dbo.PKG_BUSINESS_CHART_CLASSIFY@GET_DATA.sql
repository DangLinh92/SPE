SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_CHART_CLASSIFY@GET_DATA](
@A_DEPT_CODE       NVARCHAR(50),
@A_MONTH           NVARCHAR(50),
@A_SPARE_PART_CODE NVARCHAR(max),
@A_KRW_VND         FLOAT,
@N_RETURN		   int				OUTPUT,
@V_RETURN		   NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			 DECLARE @PACK_UNIT NVARCHAR(50) = 'PACK'
			 DECLARE @INVVALUE_SPAREPART_BY_MONTH FLOAT = 0
			 DECLARE @INVVALUE_TOTAL_BY_MONTH FLOAT = 0
			 DECLARE @SPARE_PART_NAME NVARCHAR(50)

			-- so sanh cac thiet bị vơi tong the theo thang , K CO HANG THEO MAY
           SELECT @INVVALUE_SPAREPART_BY_MONTH = SUM([INVENTORY_VALUES_VN])
		   FROM [dbo].[EWIP_INVENTORY_VALUES_BY_TIME] cte
		   INNER JOIN EWIP_SPARE_PART esp ON esp.CODE = cte.SPARE_PART_CODE AND esp.SP_DEPT_CODE = cte.DEPT_CODE
		   WHERE DEPT_CODE = @A_DEPT_CODE AND [MONTH] =  MONTH(CAST(@A_MONTH AS DATE)) AND [YEAR] = YEAR(CAST(@A_MONTH AS DATE)) AND cte.SPARE_PART_CODE IN (SELECT TRIM(VALUE) FROM string_split(@A_SPARE_PART_CODE,'$'))
		   --GROUP BY DEPT_CODE,cte.SPARE_PART_CODE

		   SELECT @INVVALUE_TOTAL_BY_MONTH = SUM([INVENTORY_VALUES_VN])
		   FROM [dbo].[EWIP_INVENTORY_VALUES_BY_TIME] cte
		   INNER JOIN EWIP_SPARE_PART esp ON esp.CODE = cte.SPARE_PART_CODE AND esp.SP_DEPT_CODE = cte.DEPT_CODE
		   WHERE DEPT_CODE = @A_DEPT_CODE AND [MONTH] =  MONTH(CAST(@A_MONTH AS DATE)) AND [YEAR] = YEAR(CAST(@A_MONTH AS DATE))

		   --SELECT @SPARE_PART_NAME = esp.NAME_KR FROM EWIP_SPARE_PART esp WHERE CODE = @A_SPARE_PART_CODE AND esp.SP_DEPT_CODE = @A_DEPT_CODE

		   --SELECT SUM([INVENTORY_VALUES_VN])*@A_KRW_VND as VALUE_SPAREPART,cte.SPARE_PART_CODE AS SPARE_CODE
		   --FROM [dbo].[EWIP_INVENTORY_VALUES_BY_TIME] cte
		   --INNER JOIN EWIP_SPARE_PART esp ON esp.CODE = cte.SPARE_PART_CODE AND esp.SP_DEPT_CODE = cte.DEPT_CODE
		   --WHERE DEPT_CODE = @A_DEPT_CODE AND [MONTH] =  MONTH(CAST(@A_MONTH AS DATE)) AND [YEAR] = YEAR(CAST(@A_MONTH AS DATE)) AND cte.SPARE_PART_CODE IN (SELECT TRIM(VALUE) FROM string_split(@A_SPARE_PART_CODE,'$'))
		   --GROUP BY DEPT_CODE,cte.SPARE_PART_CODE

		   --SELECT @SPARE_PART_NAME AS SPARE_CODE,@INVVALUE_SPAREPART_BY_MONTH*@A_KRW_VND AS VALUE_SPAREPART
		   SELECT esp.NAME_KR AS SPARE_CODE,SUM([INVENTORY_VALUES_VN])*@A_KRW_VND as VALUE_SPAREPART
		   FROM [dbo].[EWIP_INVENTORY_VALUES_BY_TIME] cte
		   INNER JOIN EWIP_SPARE_PART esp ON esp.CODE = cte.SPARE_PART_CODE AND esp.SP_DEPT_CODE = cte.DEPT_CODE
		   WHERE DEPT_CODE = @A_DEPT_CODE AND [MONTH] =  MONTH(CAST(@A_MONTH AS DATE)) AND [YEAR] = YEAR(CAST(@A_MONTH AS DATE)) AND cte.SPARE_PART_CODE IN (SELECT TRIM(VALUE) FROM string_split(@A_SPARE_PART_CODE,'$'))
		   GROUP BY DEPT_CODE,cte.SPARE_PART_CODE,esp.NAME_KR
		   UNION
		   SELECT 'OTHER' AS SPARE_CODE,(@INVVALUE_TOTAL_BY_MONTH - @INVVALUE_SPAREPART_BY_MONTH)*@A_KRW_VND AS VALUE_SPAREPART

		   DECLARE @DATA_BY_MONTH AS TABLE(
				SPARE_PART_CODE NVARCHAR(50),
				[INVENTORY_VALUES_VN] FLOAT,
				[INVENTORY_VALUES_US] FLOAT,
				[QUANTITY_INVENTORY] FLOAT,
				[QTY_INVENTORY_INCLUDE] FLOAT,
				[MONTH] INT,
				[YEAR] INT
		   )
           -- so sanh thiet bi theo may va tong 
		  ;WITH cte AS
			( SELECT *, ROW_NUMBER() OVER (PARTITION BY SPARE_PART_CODE ORDER BY [DATE] DESC) AS rn
				 FROM [dbo].[EWIP_INVENTORY_QTY_VALUE_BY_DAY]
				 WHERE DEPT_CODE = @A_DEPT_CODE AND MONTH([DATE]) = MONTH(CAST(@A_MONTH AS DATE)) AND YEAR([DATE]) = YEAR(CAST(@A_MONTH AS DATE))
			)
			INSERT INTO @DATA_BY_MONTH
			SELECT CTE.SPARE_PART_CODE,CTE.INVENTORY_VALUES_VN,CTE.INVENTORY_VALUES_US,CTE.QUANTITY_INVENTORY,CTE.QTY_INVENTORY_INCLUDE,MONTH([DATE]),YEAR([DATE]) 
			FROM cte 
			INNER JOIN EWIP_SPARE_PART esp ON esp.CODE = cte.SPARE_PART_CODE AND esp.SP_DEPT_CODE = cte.DEPT_CODE
			WHERE ESP.SP_DEPT_CODE = @A_DEPT_CODE AND rn = 1

			DECLARE @VALUE_INCLUDE FLOAT= 0
			DECLARE @VALUE_OTHER FLOAT = 0

			SELECT @VALUE_INCLUDE = SUM(ISNULL([QTY_INVENTORY_INCLUDE],0) * ISNULL(SUB3.PRICE_VN,SUB.PRICE_VN)),@VALUE_OTHER = @INVVALUE_TOTAL_BY_MONTH
			FROM @DATA_BY_MONTH DM
			 LEFT JOIN (SELECT DISTINCT
		              SPARE_PART_CODE,
		              [PRICE_VN]/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPT_CODE) AS PRICE_VN,
					  [PRICE_US]/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPT_CODE)  AS PRICE_US
		            FROM [dbo].[EWIP_INVENTORY_BY_TIME]
					WHERE DEPT_CODE = @A_DEPT_CODE AND [MONTH] =  MONTH(CAST(@A_MONTH AS DATE)) AND [YEAR] = YEAR(CAST(@A_MONTH AS DATE))
					) AS SUB3 ON SUB3.SPARE_PART_CODE = DM.SPARE_PART_CODE
			 LEFT JOIN (SELECT TOP 1 WITH TIES 
						[SPARE_PART_CODE],
						[PRICE_VN]/[dbo].[CONVERT_UNIT]([UNIT_CODE],@PACK_UNIT,[SPARE_PART_CODE],@A_DEPT_CODE) AS [PRICE_VN],
						[PRICE_US]/[dbo].[CONVERT_UNIT]([UNIT_CODE],@PACK_UNIT,[SPARE_PART_CODE],@A_DEPT_CODE) AS [PRICE_US], 
						@PACK_UNIT AS UNIT
						FROM [dbo].[EWIP_SPAREPART_PRICE]
						WHERE [DEPT_CODE] = @A_DEPT_CODE
						ORDER BY ROW_NUMBER() OVER(PARTITION BY SPARE_PART_CODE ORDER BY [DATE] DESC)) SUB ON SUB.SPARE_PART_CODE =DM.SPARE_PART_CODE

			 SELECT N'SUPPLY MACHINE' AS [NAME],@VALUE_INCLUDE*@A_KRW_VND AS VALUE_MACHINE
			 UNION
			 SELECT N'OTHER' AS [NAME],(@VALUE_OTHER)*@A_KRW_VND AS VALUE_MACHINE

			 SELECT T.NAME,SUM([INVENTORY_VALUES_VN])*@A_KRW_VND AS INVENTORY_VALUE
			 FROM [EWIP_INVENTORY_VALUES_BY_TIME] IV
			 INNER JOIN EWIP_SPARE_PART esp ON IV.SPARE_PART_CODE = ESP.CODE AND IV.DEPT_CODE = ESP.SP_DEPT_CODE
			 LEFT JOIN [dbo].[EWIP_SPAREPART_TYPE] T ON ESP.TYPE =  T.CODE
			 WHERE IV.DEPT_CODE = @A_DEPT_CODE AND [MONTH] =  MONTH(CAST(@A_MONTH AS DATE)) AND [YEAR] = YEAR(CAST(@A_MONTH AS DATE))
			 GROUP BY ISNULL(ESP.TYPE,'3'),T.NAME -- OTHER : 3

       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
