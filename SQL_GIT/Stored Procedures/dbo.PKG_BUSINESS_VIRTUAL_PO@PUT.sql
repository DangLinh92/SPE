SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_VIRTUAL_PO@PUT](
@A_DEPARTMENT		NVARCHAR(50),
@A_PO_ID            NVARCHAR(50),
@A_PR_ID            NVARCHAR(50),
@A_MRP_ID           NVARCHAR(50),
@A_USER             NVARCHAR(50),
@A_DELETE           NVARCHAR(50),
@A_DATA             [dbo].[PO_VIRTUAL_INFO_TYPE] READONLY,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @A_TOTAL_VN FLOAT = 0
			DECLARE @A_TOTAL_US FLOAT = 0
			
			DELETE FROM EWIP_PURCHASE_REQUEST_DETAIL WHERE MRP_CODE = @A_MRP_ID AND DEPT_CODE = @A_DEPARTMENT
			DELETE FROM EWIP_MRP WHERE MRP_CODE = @A_MRP_ID AND DEPT_CODE = @A_DEPARTMENT
			DELETE FROM EWIP_PURCHASE_REQUEST WHERE PR_CODE = @A_PR_ID AND DEPT_CODE = @A_DEPARTMENT
			DELETE FROM EWIP_MRP_LIST WHERE MRP_CODE = @A_MRP_ID AND DEPT_CODE = @A_DEPARTMENT
			DELETE FROM EWIP_ORDER_PR WHERE PR_CODE = @A_PR_ID  AND DEPT_CODE = @A_DEPARTMENT
			DELETE FROM EWIP_ORDER WHERE PO_ID = @A_PO_ID
			DELETE FROM EWIP_ORDER_DETAIL WHERE PO_ID = @A_PO_ID

			IF @A_DELETE = 'False'
			  BEGIN
					INSERT INTO EWIP_PURCHASE_REQUEST_DETAIL (MRP_CODE, SPAREPART_CODE, DEPT_CODE, QUANTITY_NEED_BUY, UNIT, EXPECTED_PRICE_VN, PRICE_VN, TOTAL_MONEY_VN, VENDOR_ID, PR_CODE, DATE_NEED_FINISH, USER_UPDATE, DATE_UPDATE, DATE_CREATE, STATUS, EXPECTED_PRICE_US, PRICE_US, TOTAL_MONEY_US)
					SELECT @A_MRP_ID,[SPAREPART_CODE],@A_DEPARTMENT,CAST([QUANTITY_NEED_BUY] AS FLOAT),[UNIT],CAST([PRICE_VN] AS FLOAT),CAST([PRICE_VN] AS FLOAT),
					CAST([QUANTITY_NEED_BUY] AS FLOAT) *CAST([PRICE_VN] AS FLOAT),[VENDOR],@A_PR_ID,GETDATE(),@A_USER,GETDATE(),GETDATE(),'COMPLETE',CAST([PRICE_US] AS FLOAT),CAST([PRICE_US] AS FLOAT),CAST([QUANTITY_NEED_BUY] AS FLOAT) * CAST([PRICE_US] AS FLOAT)
					FROM @A_DATA

					INSERT INTO EWIP_MRP
					SELECT [SPAREPART_CODE],CAST([QUANTITY_NEED_BUY] AS FLOAT),[UNIT],'COMPLETE',@A_MRP_ID,@A_DEPARTMENT,GETDATE(),GETDATE(),GETDATE(),@A_USER,GETDATE(),'False',GETDATE()
					FROM @A_DATA

					INSERT INTO EWIP_MRP_LIST (MRP_CODE, DATE_CREATE, STATUS, DEPT_CODE, DATE_END_ACTUAL, DATE_NEED_FINISH, USER_CREATE, USER_UPDATE, DATE_UPDATE, TITLE)
					VALUES (@A_MRP_ID, GETDATE(), N'COMPLETE', @A_DEPARTMENT, GETDATE(), GETDATE(), @A_USER, @A_USER, GETDATE(), N'Virtual PO');

					SELECT @A_TOTAL_VN = SUM(TOTAL_MONEY_VN),@A_TOTAL_US = SUM(TOTAL_MONEY_US)
					FROM EWIP_PURCHASE_REQUEST_DETAIL
					WHERE PR_CODE = @A_PR_ID
					GROUP BY PR_CODE

					INSERT INTO EWIP_PURCHASE_REQUEST (DATE_CREATE, PR_CODE, PR_STATUS, MRP_CODE, TOTAL_VALUE, DATE_NEED_FINISH, DATE_END_ACTUAL, DEPT_CODE, PURPOSE_OF_BUYING, USER_CREATE, USER_UPDATE, DATE_UPDATE, TOTAL_VALUE_US)
					VALUES (GETDATE(), @A_PR_ID, N'COMPLETE', @A_MRP_ID, ISNULL(@A_TOTAL_VN,0), GETDATE(), GETDATE(), @A_DEPARTMENT, N'Virtual PO', @A_USER, @A_USER, GETDATE(), ISNULL(@A_TOTAL_US,0));

					INSERT INTO EWIP_ORDER_PR (PO_ID, PR_CODE, STATUS, DATE_NEED_FINISH, DATE_END_ACTUAL, DATE_CREATE, DATE_UPDATE, USER_CREATE, USER_UPDATE, DEPT_CODE, PO_ID_TEMP)
					VALUES (@A_PO_ID, @A_PR_ID, N'COMPLETE', GETDATE(), GETDATE(), GETDATE(), GETDATE(), @A_USER, @A_USER, @A_DEPARTMENT, @A_PO_ID);

					INSERT INTO EWIP_ORDER (PO_ID, DATE_ORERED, DATE_CREATE, STATUS, USER_ID, UPDATED_DATE, TITLE, DATE_ACTUAL_END, DATE_NEED_FINISH, PO_ID_TEMP)
					VALUES (@A_PO_ID, GETDATE(), GETDATE(), N'COMPLETE', @A_USER, GETDATE(), N'Virtual PO', GETDATE(), GETDATE(), @A_PO_ID)

					INSERT INTO EWIP_ORDER_DETAIL (PO_ID, PO_CREATE, BKGRP, KUNNR, PSTYP, SPARE_PART_CODE, WERKS, LGORT, NETPR, PER, WAERS, MWSKZ, KNTTP, MATKL, POSID, DEPT_CODE, PO_QTY, UNIT, PR_CODE, PO_ID_TEMP, TXZ01_DESCRIPTION, VENDOR, DELIVERY_DATE, GL_ACCOUNT, COST_CENTER)
					SELECT @A_PO_ID,SYSDATETIME(),'','','',[SPAREPART_CODE],'','',CAST([PRICE_VN] AS FLOAT),1,'VND','','','','',@A_DEPARTMENT,CAST([QUANTITY_NEED_BUY] AS FLOAT),[UNIT],@A_PR_ID,@A_PO_ID,'',[VENDOR],FORMAT (getdate(), 'yyyyMMdd') ,'',''
					FROM @A_DATA
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
