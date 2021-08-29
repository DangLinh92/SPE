﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM005@INT_LIST](
@A_PLANT			VARCHAR(50),
@A_LANG				VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE @V_MASTER_FLAG		VARCHAR(1);
DECLARE @V_IS_ADMIN			TINYINT;

BEGIN TRY

/**SET @V_IS_ADMIN = (SELECT COUNT(*) FROM ESYSMSTUSR USR
INNER JOIN ESYSMSTURO USRL ON USR.USER_ID = USRL.USER_ID
INNER JOIN ESYSMSTROL ROLE ON USRL.USERROLE = ROLE.USERROLE
WHERE USR.USER_ID = @A_USER_ID)**/

SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID AND T1.DEPARTMENT = @A_DEPARTMENT)
IF(@V_MASTER_FLAG = 'Y')
BEGIN	
		SELECT T.USER_ID AS USER_ID,
               T.PASSWORD AS PASSWORD,
               T.USER_NAME AS USER_NAME,
               T.PHONE_NUM AS PHONE_NUM,
               T.EMAIL AS EMAIL,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS,
			   T.DEPARTMENT
        FROM ESYSMSTUSR T
        ORDER BY T.USER_ID ASC;

		SELECT * FROM ESYSMSTDEPT;

END
ELSE
BEGIN
		SELECT T.USER_ID AS USER_ID,
               T.PASSWORD AS PASSWORD,
               T.USER_NAME AS USER_NAME,
               T.PHONE_NUM AS PHONE_NUM,
               T.EMAIL AS EMAIL,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS,
			   T.DEPARTMENT
        FROM ESYSMSTUSR T
        WHERE T.PLANT = @A_PLANT
		AND T.MASTER_FLAG IS NULL
		AND T.USEFLAG = 'Y'
		AND T.DEPARTMENT = @A_DEPARTMENT
        ORDER BY T.USER_ID ASC;

		SELECT * FROM ESYSMSTDEPT WHERE DEPARTMENT = @A_DEPARTMENT;
END



	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO