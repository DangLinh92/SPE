SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SAP_PO@INIT](
@A_PR_LIST  NVARCHAR(MAX),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT DISTINCT V.VENDER_ID,V.NAME, '' AS SAP_PO 
			FROM [dbo].[EWIP_PURCHASE_REQUEST_DETAIL] D
			LEFT JOIN [dbo].[EWIP_VENDER] V ON D.VENDOR_ID = V.VENDER_ID
			WHERE PR_CODE IN (SELECT TRIM(VALUE) FROM string_split(@A_PR_LIST,'^'))
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO