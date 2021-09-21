﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@REPORT_BY_SPAREPART](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK_CODE       NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			DECLARE @PACK_UNIT NVARCHAR(50) = 'PACK';

		    SELECT ROW_NUMBER() OVER(ORDER BY inv.SPARE_PART_CODE ASC) as STT,
				inv.SPARE_PART_CODE AS CODE, 
				sp.NAME_VI,sp.NAME_KR,
				sp_type.NAME as SPARE_PART_TYPE,
				'Pack' as UNIT,
				SUB.PRICE_VN/[dbo].[CONVERT_UNIT](SUB.[UNIT_CODE],@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)  AS PRICE_VN,
				SUB.PRICE_US/[dbo].[CONVERT_UNIT](SUB.[UNIT_CODE],@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)  AS PRICE_US,
				([dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)* ISNULL(inv.QUANTITY,0) - ISNULL(SUB1.QUANTITY_PACK,0)) as QUANTITY,
				(SUB.PRICE_VN/[dbo].[CONVERT_UNIT](SUB.[UNIT_CODE],@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT))*([dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*ISNULL(inv.QUANTITY,0) - ISNULL(SUB1.QUANTITY_PACK,0)) AS AMOUNT_VN,
				(SUB.PRICE_US/[dbo].[CONVERT_UNIT](SUB.[UNIT_CODE],@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)) * ([dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*ISNULL(inv.QUANTITY,0) - ISNULL(SUB1.QUANTITY_PACK,0)) AS AMOUNT_US,
				[dbo].[CONVERT_UNIT](mins.UNIT_CODE,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*mins.MIN_STOCK as MIN_STOCK,
				[dbo].[CONVERT_UNIT](bom.UNIT,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*bom.[WORKING_A_MONTH] AS WORKING_A_MONTH,
				[dbo].[CONVERT_UNIT](sp.UNIT_ID,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*sp.[MIN_ORDER] AS MIN_ORDER,
				SP.VENDER_ID,
				inv.STOCK_CODE
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] inv
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON inv.SPARE_PART_CODE = sp.CODE and inv.DEPT_CODE = SP.SP_DEPT_CODE
			LEFT JOIN (
							SELECT [SPARE_PART_CODE],[dbo].[CONVERT_UNIT]([UNIT_ID],@PACK_UNIT,SPARE_PART_CODE,@A_DEPARTMENT)* ISNULL([QUANTITY],0) as QUANTITY_PACK
							FROM [dbo].[EWIP_SPAREPART_LOCATION] 
							WHERE [DEPT_CODE] = @A_DEPARTMENT AND [STOCK_CODE] = @A_STOCK_CODE AND (CONDITION_CODE = 'INTEGRATED' OR CONDITION_CODE = 'NG')
					  ) AS SUB1 ON inv.SPARE_PART_CODE = SUB1.SPARE_PART_CODE 
			LEFT JOIN [dbo].[EWIP_SETUP_MINSTOCK] mins ON inv.SPARE_PART_CODE = mins.SPARE_PART_CODE AND mins.DEPT_CODE = @A_DEPARTMENT
			LEFT JOIN [dbo].[EWIP_BOM] bom ON inv.SPARE_PART_CODE = bom.[SPARE_PART_CODE] AND bom.[DEPT_CODE] = @A_DEPARTMENT
			LEFT JOIN [dbo].[EWIP_SPAREPART_TYPE] sp_type ON sp.TYPE = sp_type.CODE AND sp_type.DEPT_CODE = @A_DEPARTMENT
			LEFT JOIN (SELECT TOP 1 WITH TIES 
						[SPARE_PART_CODE],
						[PRICE_VN],
						[PRICE_US], 
						[UNIT_CODE]
						FROM [dbo].[EWIP_SPAREPART_PRICE]
						WHERE [DEPT_CODE] = @A_DEPARTMENT
						ORDER BY ROW_NUMBER() OVER(PARTITION BY SPARE_PART_CODE ORDER BY [DATE] DESC)) SUB ON SUB.SPARE_PART_CODE = inv.SPARE_PART_CODE

			WHERE inv.DEPT_CODE = @A_DEPARTMENT and inv.STOCK_CODE = @A_STOCK_CODE
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO