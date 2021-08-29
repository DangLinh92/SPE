﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_LOGDAT002@INT_LIST](
@A_PLANT			VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
	SELECT '' AS USERID,
           '' AS FORM_CODE,
           '' AS FORMNAME,
           0 AS ACCESS_COUNTER,
           '' AS LAST_ACCESS_TIME
	WHERE @@ROWCOUNT < 0;

	SELECT T.USER_ID AS USER_ID,
           T.USER_NAME AS USER_NAME
    FROM ESYSMSTUSR T
    WHERE T.PLANT = @A_PLANT
    ORDER BY T.USER_NAME ASC;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO