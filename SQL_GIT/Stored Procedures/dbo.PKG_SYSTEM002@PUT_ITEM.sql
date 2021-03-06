SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM002@PUT_ITEM](
@A_PLANT			VARCHAR(10),
@A_FORM				VARCHAR(30),
@A_FORMNAME			NVARCHAR(50),
@A_USEFLAG			VARCHAR(1),
@A_REMARKS			NVARCHAR(4000),
@A_TRAN_USER_ID		VARCHAR(30),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE @V_TRAN_TIME	VARCHAR(14);
DECLARE	@V_CHECK		INT;

BEGIN TRY

	SET @V_TRAN_TIME = DBO.FUN_CURR_TIME();
	SET @V_CHECK = 0;

	SELECT @V_CHECK = COUNT(*)
    FROM ESYSMSTFORM T1
    WHERE T1.PLANT = @A_PLANT
    AND T1.FORM = @A_FORM;

	BEGIN TRAN

	IF @V_CHECK != 0
		BEGIN
			UPDATE ESYSMSTFORM
			SET FORMNAME = @A_FORMNAME,
				USEFLAG = @A_USEFLAG,
				REMARKS = @A_REMARKS,
				UPDATE_TIME = @V_TRAN_TIME,
				UPDATE_USER = @A_TRAN_USER_ID
			WHERE PLANT = @A_PLANT
			AND FORM = @A_FORM;

			UPDATE ESYSMSTMEU 
			SET USEFLAG = @A_USEFLAG
			WHERE PLANT = @A_PLANT
			AND MENUNAME = @A_FORM
		END
    ELSE
		BEGIN
			INSERT INTO ESYSMSTFORM (
				PLANT,
				DEPARTMENT,
				FORM,
				FORMNAME,
				USEFLAG,
				REMARKS,
				CREATE_TIME,
				CREATE_USER
			) VALUES (
				@A_PLANT,
				'ALL',
				@A_FORM,
				@A_FORMNAME,
				@A_USEFLAG,
				@A_REMARKS,
				@V_TRAN_TIME,
				@A_TRAN_USER_ID
			);
		END

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
