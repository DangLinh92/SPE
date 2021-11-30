SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_DOCUMENT@UPLOAD](
@A_CODE             NVARCHAR(50),-- MA THIET BI
@A_NAME_FILE        NVARCHAR(250), -- NAME FILE
@A_CONTENT_TYPE     NVARCHAR(250),
@A_DATA             VARBINARY(MAX),
@A_USER				NVARCHAR(50),
@A_DEPARTMENT		NVARCHAR(50),
@A_IS_DELETE        NVARCHAR(20),
@A_IS_EQUIPMENT     VARCHAR(5),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			IF(@A_IS_DELETE = 'TRUE')
			   BEGIN
						DELETE FROM [dbo].[EWIP_SPAREPART_DOCUMENT]
						WHERE [CODE] = @A_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND [NAME] = @A_NAME_FILE AND [CONTENT_TYPE] = @A_CONTENT_TYPE AND [IS_EQUIPMENT] = @A_IS_EQUIPMENT
			   END
			 ELSE
			 BEGIN
					IF @A_NAME_FILE != '' AND @A_NAME_FILE IS NOT NULL
					  BEGIN
							DELETE FROM [dbo].[EWIP_SPAREPART_DOCUMENT]
							WHERE [CODE] = @A_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND [NAME] = @A_NAME_FILE AND [CONTENT_TYPE] = @A_CONTENT_TYPE AND [IS_EQUIPMENT] = @A_IS_EQUIPMENT

							INSERT INTO [dbo].[EWIP_SPAREPART_DOCUMENT]
							VALUES(@A_CODE,@A_DEPARTMENT,@A_NAME_FILE,@A_CONTENT_TYPE,@A_DATA,SYSDATETIME(),@A_USER,@A_IS_EQUIPMENT)
					  END
					ELSE
					   BEGIN
							DELETE FROM [dbo].[EWIP_SPAREPART_DOCUMENT]
							WHERE [CODE] = @A_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND [IS_EQUIPMENT] = @A_IS_EQUIPMENT
					   END
			   END

			   SELECT [NAME],[CONTENT_TYPE],[USER_UPLOAD],[SYS_TIME]
			   FROM [dbo].[EWIP_SPAREPART_DOCUMENT]
			   WHERE [DEPT_CODE] = @A_DEPARTMENT AND [CODE] = @A_CODE AND [IS_EQUIPMENT] =  @A_IS_EQUIPMENT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH


GO
