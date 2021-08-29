﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_PO@GET_PO_BY_ID](
@A_PO_ID     NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			IF @A_PO_ID != '' AND @A_PO_ID IS NOT NULL
			  BEGIN
					SELECT OPR.[ID],OPR.[PR_CODE],PR.MRP_CODE,PR.TOTAL_VALUE,PR.TOTAL_VALUE_US,PR.[DATE_CREATE],PR.[DATE_NEED_FINISH],PR.[DEPT_CODE],OPR.STATUS
					FROM [dbo].[EWIP_ORDER_PR] OPR
					INNER JOIN [dbo].[EWIP_PURCHASE_REQUEST] PR ON OPR.PR_CODE = PR.PR_CODE
					WHERE [PO_ID] =  @A_PO_ID
			 END
			 ELSE
			   BEGIN
					SELECT OPR.[ID],OPR.[PR_CODE],PR.MRP_CODE,PR.TOTAL_VALUE,PR.TOTAL_VALUE_US,PR.[DATE_CREATE],PR.[DATE_NEED_FINISH],PR.[DEPT_CODE],OPR.STATUS
					FROM [dbo].[EWIP_ORDER_PR] OPR
					INNER JOIN [dbo].[EWIP_PURCHASE_REQUEST] PR ON OPR.PR_CODE = PR.PR_CODE
					WHERE ([PO_ID] IS NULL OR [PO_ID] = '') AND OPR.STATUS = 'PUR_RECEIPT'
			  END
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO