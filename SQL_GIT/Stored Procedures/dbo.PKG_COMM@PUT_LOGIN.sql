SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_COMM@PUT_LOGIN](
@A_PLANT		VARCHAR(50),
@A_USER_ID		VARCHAR(50),
@A_FORM_CODE	NVARCHAR(500),
@A_DEPARTMENT	VARCHAR(50),
@N_RETURN		int				OUTPUT,
@V_RETURN		NVARCHAR(4000)	OUTPUT
)
AS 

DECLARE @V_TRAN_TIME	VARCHAR(14);
DECLARE @N_CHECK		INT;

BEGIN TRY
	
	SET @V_TRAN_TIME = DBO.FUN_CURR_TIME();

	SELECT @N_CHECK = ISNULL(MAX(T1.HIST_SEQ), 0)
	FROM ESYSLOGFORM T1
	WHERE T1.PLANT = @A_PLANT 
	AND T1.USER_ID = @A_USER_ID 
	AND T1.DEPARTMENT = @A_DEPARTMENT;

	SET @N_CHECK = @N_CHECK + 1;

	DECLARE @V_FORM_CODE  VARCHAR(50)

	SELECT @V_FORM_CODE = GLSR FROM ESYSMSTGLA WHERE (KOR = @A_FORM_CODE OR VTN = @A_FORM_CODE)

	BEGIN TRAN
	INSERT INTO ESYSLOGFOM(PLANT,DEPARTMENT,USER_ID,HIST_SEQ,FORM_CODE,ACCESS_TYPE)
	VALUES (@A_PLANT, @A_DEPARTMENT, @A_USER_ID, @N_CHECK, @V_FORM_CODE, @V_TRAN_TIME);
	COMMIT TRAN;
	

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
