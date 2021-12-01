SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_SHEET@GET](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK_CODE       NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			SELECT [SHEET_ID],[TITLE],[INVENTORY_SHEET_MONTH],[DATE_START],[DATE_END],[USER_CREATE],[USER_UPDATE],[DATE_UPDATE]
			FROM [dbo].[EWIP_INVENTORY_SHEET]
			WHERE [DEPT_CODE] = @A_DEPARTMENT AND [STOCK_CODE] = @A_STOCK_CODE
			ORDER BY [DATE_END] DESC,[DATE_START] DESC
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO