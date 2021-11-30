SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_LOGDAT001@INT_LIST](
@A_DEPARTMENT		VARCHAR(50),
@A_ROLE				VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	IF @A_ROLE = 'ROLE_ADMIN'
		BEGIN
			SELECT '' AS USERID,
				   '' AS USER_NAME,
				   '' AS ACCESS_TIME,
				   '' AS ACCESS_IP,
				   '' AS ACCESS_PC
			WHERE @@ROWCOUNT < 0;

			SELECT T.USER_ID AS USER_ID,
				   T.USER_NAME AS USER_NAME
			FROM ESYSMSTUSR T
			ORDER BY T.USER_NAME ASC;
		END
	ELSE
		BEGIN
			SELECT '' AS USERID,
				   '' AS USER_NAME,
				   '' AS ACCESS_TIME,
				   '' AS ACCESS_IP,
				   '' AS ACCESS_PC
			WHERE @@ROWCOUNT < 0;

			SELECT T.USER_ID AS USER_ID,
				   T.USER_NAME AS USER_NAME
			FROM ESYSMSTUSR T
			WHERE T.DEPARTMENT = @A_DEPARTMENT
			ORDER BY T.USER_NAME ASC;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
