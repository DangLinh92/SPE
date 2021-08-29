﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@GET_QUANTITY_REAL](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_YEAR             NVARCHAR(4),
@A_MONTH			NVARCHAR(2),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT [SPARE_PART_CODE],[QUANTITY],[QUANTITY_REAL],[UNIT]
			FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO