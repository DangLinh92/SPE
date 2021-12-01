SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM001@PUT_ITEM](
@A_PLANT			VARCHAR(50),
@A_GLSR				VARCHAR(4000),
@A_KOR				NVARCHAR(4000),
@A_VTN				NVARCHAR(4000),
@A_TRAN_USER_ID		VARCHAR(30),
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
    FROM ESYSMSTGLA T1
    WHERE T1.PLANT = @A_PLANT
    AND T1.GLSR = @A_GLSR;

	BEGIN TRAN

	IF @V_CHECK != 0
		BEGIN
			UPDATE ESYSMSTGLA
			SET 
				KOR = @A_KOR,
				VTN = @A_VTN,
				UPDATE_TIME = @V_TRAN_TIME,
				UPDATE_USER = @A_TRAN_USER_ID
			WHERE PLANT = @A_PLANT
			AND GLSR = @A_GLSR;
		END
    ELSE
		BEGIN
			INSERT INTO ESYSMSTGLA (
				PLANT,
				GLSR,
				KOR,
				VTN,
				CREATE_TIME,
				CREATE_USER
			) VALUES (
				@A_PLANT,
				@A_GLSR,
				@A_KOR,
				@A_VTN,
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