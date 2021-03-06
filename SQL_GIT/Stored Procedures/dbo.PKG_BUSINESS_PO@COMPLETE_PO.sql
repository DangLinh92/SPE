SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_PO@COMPLETE_PO](
@A_STATUS          NVARCHAR(50),
@A_USER            NVARCHAR(50),
@A_PO_ID           NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			UPDATE EWIP_ORDER
			SET STATUS = @A_STATUS,USER_ID = @A_USER
			WHERE PO_ID = @A_PO_ID

			UPDATE EWIP_ORDER_PR
			SET STATUS = @A_STATUS, USER_UPDATE = @A_USER
			WHERE PO_ID = @A_PO_ID

			UPDATE EWIP_PURCHASE_REQUEST
			SET PR_STATUS = @A_STATUS,USER_UPDATE = @A_USER
			WHERE PR_CODE IN (SELECT eop.PR_CODE FROM EWIP_ORDER_PR eop WHERE eop.PO_ID = @A_PO_ID)

			UPDATE EWIP_MRP_LIST
			SET STATUS = @A_STATUS,USER_UPDATE = @A_USER
			WHERE MRP_CODE IN (SELECT MRP_CODE FROM EWIP_PURCHASE_REQUEST epr WHERE epr.PR_CODE IN (SELECT eop.PR_CODE FROM EWIP_ORDER_PR eop WHERE eop.PO_ID = @A_PO_ID))

			UPDATE EWIP_PURCHASE_REQUEST_DETAIL
			SET STATUS = @A_STATUS,USER_UPDATE = @A_USER
			WHERE MRP_CODE IN (SELECT MRP_CODE FROM EWIP_PURCHASE_REQUEST epr WHERE epr.PR_CODE IN (SELECT eop.PR_CODE FROM EWIP_ORDER_PR eop WHERE eop.PO_ID = @A_PO_ID))

			UPDATE EWIP_MRP
			SET STATUS = @A_STATUS,USER_UPDATE = @A_USER
			WHERE MRP_CODE IN (SELECT MRP_CODE FROM EWIP_PURCHASE_REQUEST epr WHERE epr.PR_CODE IN (SELECT eop.PR_CODE FROM EWIP_ORDER_PR eop WHERE eop.PO_ID = @A_PO_ID))
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
