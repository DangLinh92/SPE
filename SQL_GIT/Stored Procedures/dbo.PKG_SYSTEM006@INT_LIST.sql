SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM006@INT_LIST](
@A_PLANT			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@A_USER_ID           NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	DECLARE @V_MASTER_FLAG VARCHAR(1);
	SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID AND T1.DEPARTMENT = @A_DEPARTMENT)
	IF(@V_MASTER_FLAG = 'Y') 
	  BEGIN
		SELECT T.USERROLE AS USERROLE,
               T.USERROLE_NAME AS USERROLE_NAME,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS
        FROM ESYSMSTROL T
        ORDER BY T.USERROLE ASC;
	  END
	ELSE  
	  BEGIN
				SELECT T1.USERROLE AS USERROLE,
				       T1.USERROLE_NAME AS USERROLE_NAME,
					    T1.USEFLAG AS USEFLAG,
						T1.REMARKS AS REMARKS
				FROM ESYSMSTROL T1
				WHERE T1.PLANT = @A_PLANT
				AND T1.USEFLAG = 'Y'
				AND T1.DEPARTMENT = @A_DEPARTMENT
				AND T1.USERROLE <> 'ROLE_ADMIN'
				ORDER BY T1.USERROLE;
      END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
