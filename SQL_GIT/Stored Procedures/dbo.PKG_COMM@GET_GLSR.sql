SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC	[dbo].[PKG_COMM@GET_GLSR]
@A_PLANT	VARCHAR(50), 
@N_RETURN	INT OUTPUT, 
@V_RETURN	NVARCHAR(4000) OUTPUT
WITH EXEC AS CALLER
AS
BEGIN TRY
  SELECT 
    T.GLSR,
	T.CHN,
	T.KOR,
	T.ENG,
	T.VTN
  FROM ESYSMSTGLA T
  WHERE T.PLANT = @A_PLANT
  ORDER BY T.GLSR ASC;

  SET @N_RETURN = 0;
  SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
