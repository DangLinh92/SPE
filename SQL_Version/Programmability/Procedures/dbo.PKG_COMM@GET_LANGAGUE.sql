﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_COMM@GET_LANGAGUE](
@N_RETURN  int			 OUTPUT,
@V_RETURN  NVARCHAR(4000) OUTPUT
)
AS

BEGIN TRY
  /**SELECT T.COMMCODE AS LANGUAGE,
	 	 T.COMMNAME AS LANGUAGE_DESC
  FROM ESYSMSTCOD T
  WHERE T.COMMGRP = 'LANGUAGE'
  ORDER BY T.COMMCODE;
  **/

  SELECT DEPARTMENT AS CODE, DEPARTMENT  FROM ESYSMSTDEPT-- ORDER BY CODE

  SET @N_RETURN = 0;
  SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO