﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM006@GET_LIST](
@A_PLANT			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
		SELECT T.USERROLE AS USERROLE,
               T.USERROLE_NAME AS USERROLE_NAME,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS
        FROM ESYSMSTROL T
        WHERE T.USERROLE <> 'ROLE_ADMIN'
        ORDER BY T.USERROLE ASC;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO