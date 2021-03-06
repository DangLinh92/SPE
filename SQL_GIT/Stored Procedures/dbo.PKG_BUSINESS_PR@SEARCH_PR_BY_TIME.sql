SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_PR@SEARCH_PR_BY_TIME](
@A_DEPARTMENT		NVARCHAR(50),
@A_FROM_TIME        NVARCHAR(50),
@A_TO_TIME          NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT [PR_CODE],[MRP_CODE],[TOTAL_VALUE],[TOTAL_VALUE_US],[DATE_CREATE],[DATE_NEED_FINISH],[DATE_END_ACTUAL],[USER_CREATE],[USER_UPDATE],[DATE_UPDATE],[PR_STATUS]
			FROM [dbo].[EWIP_PURCHASE_REQUEST]
			WHERE DEPT_CODE = @A_DEPARTMENT AND [DATE_CREATE] BETWEEN CAST(@A_FROM_TIME AS date) AND CAST(@A_TO_TIME AS date)
			ORDER BY [DATE_NEED_FINISH] ASC
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
