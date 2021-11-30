SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_SHEET@SEARCH_BY_TIME](
@A_FROM_TIME NVARCHAR(50),
@A_TO_TIME NVARCHAR(50),
@A_DEPT_CODE NVARCHAR(50),
@A_STOCK NVARCHAR(50),
@N_RETURN  int	OUTPUT,
@V_RETURN  NVARCHAR(4000) OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			SELECT [SHEET_ID],[TITLE],[INVENTORY_SHEET_MONTH],[DATE_START],[DATE_END],[USER_CREATE],[USER_UPDATE],[DATE_UPDATE]
			FROM [dbo].[EWIP_INVENTORY_SHEET]
			WHERE [DATE_START] >= CAST(@A_FROM_TIME AS DATE) AND [DATE_START] <= CAST(@A_TO_TIME AS DATE) AND [DEPT_CODE]= @A_DEPT_CODE AND [STOCK_CODE] = @A_STOCK
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
