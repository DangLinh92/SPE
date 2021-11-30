SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_MRP@DELETE](
@A_ID nvarchar(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @A_MRP_CODE NVARCHAR(50)
			DECLARE @DEPT_CODE NVARCHAR(50)
			DECLARE @SPAREPART_CODE NVARCHAR(50)

			SELECT @A_MRP_CODE = MRP_CODE,@DEPT_CODE = DEPT_CODE,@SPAREPART_CODE = SPAREPART_CODE
			FROM [dbo].[EWIP_MRP]
			WHERE ID = CAST(@A_ID AS INT) 

			DELETE FROM [dbo].[EWIP_MRP]
			WHERE ID = CAST(@A_ID AS INT) 

			DELETE FROM [dbo].[EWIP_PURCHASE_REQUEST_DETAIL]
			WHERE MRP_CODE = @A_MRP_CODE AND SPAREPART_CODE = @SPAREPART_CODE AND DEPT_CODE = @DEPT_CODE
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
