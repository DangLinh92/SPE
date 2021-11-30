SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@CACULAR_REMAIN_QUANTITY](
@A_DEPARTMENT       NVARCHAR(100),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_UNIT             nvarchar(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			  DECLARE @QUANTIY_TOTAL float = 0;
			  DECLARE @QUANTIY_IN_POSITION float = 0;
			  DECLARE @RESULT FLOAT = 0;

			  SELECT @QUANTIY_IN_POSITION = SUM([dbo].[CONVERT_UNIT]([UNIT_ID],@A_UNIT,[SPARE_PART_CODE],[DEPT_CODE])*[QUANTITY])
			  FROM [dbo].[EWIP_SPAREPART_LOCATION]
			  WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK
			  GROUP BY [DEPT_CODE],[STOCK_CODE],[SPARE_PART_CODE]

			  SELECT @QUANTIY_TOTAL = [dbo].[CONVERT_UNIT]([UNIT_IN_CODE],@A_UNIT,[SPARE_PART_CODE],[DEPT_CODE])* [QUANTITY]
			  FROM [dbo].[EWIP_SPAREPART_INVENTORY]
			  WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			  SET @RESULT = (@QUANTIY_TOTAL - @QUANTIY_IN_POSITION)
			  SELECT @RESULT as QUANTITY
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH


GO
