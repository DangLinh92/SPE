SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM004@GET_LIST](
@A_PLANT			VARCHAR(50),
@A_USERROLE			VARCHAR(50),
@A_LANG				VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
DECLARE @V_MASTER_FLAG VARCHAR(1);

BEGIN TRY

SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID AND T1.DEPARTMENT = @A_DEPARTMENT)
IF(@V_MASTER_FLAG = 'Y')
BEGIN	
		SELECT ISNULL(T3.USEFLAG, 'N') AS USEFLAG,
              ( CASE WHEN @A_LANG = 'KOR' THEN T2.KOR
					WHEN @A_LANG = 'VTN' THEN T2.VTN
			 END) AS MENUNAME,
              T1.MENUSEQ AS MENUSEQ,
              T1.UPRSEQ AS UPRSEQ,
              T3.FORMROLE AS FORMROLE,
			  T1.FORM AS FORM_NAME
       FROM ESYSMSTMEU T1 
			LEFT OUTER JOIN ESYSMSTGLA T2 ON T2.PLANT = T1.PLANT AND T2.GLSR = T1.MENUNAME
			LEFT OUTER JOIN ESYSMSTMRO T3 ON T3.PLANT = T1.PLANT AND T3.MENUSEQ = T1.MENUSEQ AND T3.USERROLE = @A_USERROLE AND t3.DEPARTMENT = @A_DEPARTMENT
       WHERE T1.PLANT = @A_PLANT
	   ORDER BY T1.MENUSEQ
END
ELSE
BEGIN
		SELECT ISNULL(T3.USEFLAG, 'N') AS USEFLAG,
              ( CASE WHEN @A_LANG = 'KOR' THEN T2.KOR
					WHEN @A_LANG = 'VTN' THEN T2.VTN
				END
			   ) AS MENUNAME,
              T1.MENUSEQ AS MENUSEQ,
              T1.UPRSEQ AS UPRSEQ,
              T3.FORMROLE AS FORMROLE,
			  T1.FORM AS FORM_NAME
       FROM ESYSMSTMEU T1 
			LEFT OUTER JOIN ESYSMSTGLA T2 ON T2.PLANT = T1.PLANT AND T2.GLSR = T1.MENUNAME
			LEFT OUTER JOIN ESYSMSTMRO T3 ON T3.PLANT = T1.PLANT AND T3.MENUSEQ = T1.MENUSEQ AND T3.USERROLE = @A_USERROLE AND t3.DEPARTMENT = @A_DEPARTMENT
       WHERE T1.PLANT = @A_PLANT
	   AND T1.MENUNAME <> 'SYSTEM001' AND T1.MENUNAME <>'SYSTEM002' AND T1.MENUNAME <> 'SYSTEM006' AND T1.MENUNAME <>'SYSTEM007' AND T1.MENUNAME <>'SYSTEM014'
	   AND T1.MENUNAME <> 'MENU_LOG' AND T1.MENUNAME <> 'LOGDAT001' AND T1.MENUNAME <> 'LOGDAT002'
	   AND T1.USEFLAG = 'Y'
	   ORDER BY T1.MENUSEQ
END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
