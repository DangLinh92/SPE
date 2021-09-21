﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_SYSTEM005@GET_DETAIL](
@A_USER_ID				VARCHAR(50),
@N_RETURN				int				OUTPUT,
@V_RETURN				NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY

	SELECT USR.PLANT, USR.DEPARTMENT, USR.USER_ID, USR.PASSWORD, USR.USER_NAME, USR.PHONE_NUM,
	USR.EMAIL, USR.USEFLAG, USR.ADDRESS, USR.REMARKS, USR.MASTER_FLAG, 
	USRL.USERROLE
	FROM ESYSMSTUSR USR 
	LEFT JOIN ESYSMSTURO USRL ON USR.USER_ID = USRL.USER_ID
	LEFT JOIN ESYSMSTROL ROLE ON USRL.USERROLE = ROLE.USERROLE
	WHERE USR.USER_ID = @A_USER_ID

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO