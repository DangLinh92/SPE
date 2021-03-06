SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM004@GET_LIST_CONTROLS](
@A_PLANT			VARCHAR(50),
@A_USERROLE			VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
DECLARE @V_MASTER_FLAG VARCHAR(1);

BEGIN TRY

IF NOT EXISTS(SELECT * FROM [dbo].[ESYSM_CONTROLS_ROL] WHERE DEPARTMENT = @A_DEPARTMENT AND USERROLE = @A_USERROLE AND PLANT = @A_PLANT) BEGIN  
	SELECT DISTINCT [CONTROL_TEXT] AS 'Text',[CONTROL_NAME] AS 'Name',[MENU_SEQ] AS 'FormId',CAST('False' AS bit) AS 'IsActive' 
	FROM [dbo].[ESYSM_CONTROLS_ROL] WHERE DEPARTMENT = @A_DEPARTMENT AND PLANT = @A_PLANT
END
ELSE
BEGIN
		SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID AND T1.DEPARTMENT = @A_DEPARTMENT)
		IF(@V_MASTER_FLAG = 'Y')
		BEGIN	
				SELECT DISTINCT T4.[CONTROL_TEXT] AS 'Text',T4.[CONTROL_NAME] AS 'Name',T4.[MENU_SEQ] AS 'FormId',CAST(ISNULL(T4.[USE_FLAG],'False') AS bit) AS 'IsActive'
			    FROM ESYSMSTMEU T1 
					LEFT OUTER JOIN ESYSMSTGLA T2 ON T2.PLANT = T1.PLANT AND T2.GLSR = T1.MENUNAME
					LEFT OUTER JOIN ESYSMSTMRO T3 ON T3.PLANT = T1.PLANT AND T3.MENUSEQ = T1.MENUSEQ AND T3.USERROLE = @A_USERROLE AND t3.DEPARTMENT = @A_DEPARTMENT
					LEFT OUTER JOIN [dbo].[ESYSM_CONTROLS_ROL] T4 ON T4.USERROLE = @A_USERROLE AND T4.DEPARTMENT = @A_DEPARTMENT AND T4.PLANT = @A_PLANT AND t4.MENU_SEQ = t1.MENUSEQ
		       WHERE T1.PLANT = @A_PLANT
		END
		ELSE
		BEGIN
				SELECT DISTINCT T4.[CONTROL_TEXT] AS 'Text',T4.[CONTROL_NAME] AS 'Name',T4.[MENU_SEQ] AS 'FormId',CAST(ISNULL(T4.[USE_FLAG],'False') AS bit) AS 'IsActive'
			    FROM ESYSMSTMEU T1 
					LEFT OUTER JOIN ESYSMSTGLA T2 ON T2.PLANT = T1.PLANT AND T2.GLSR = T1.MENUNAME
					LEFT OUTER JOIN ESYSMSTMRO T3 ON T3.PLANT = T1.PLANT AND T3.MENUSEQ = T1.MENUSEQ AND T3.USERROLE = @A_USERROLE AND t3.DEPARTMENT = @A_DEPARTMENT
					LEFT OUTER JOIN [dbo].[ESYSM_CONTROLS_ROL] T4 ON T4.USERROLE = @A_USERROLE AND T4.DEPARTMENT = @A_DEPARTMENT AND T4.PLANT = @A_PLANT AND t4.MENU_SEQ = t1.MENUSEQ
		       WHERE T1.PLANT = @A_PLANT
			   AND T1.MENUNAME <> 'SYSTEM001' AND T1.MENUNAME <>'SYSTEM002' AND T1.MENUNAME <> 'SYSTEM006' AND T1.MENUNAME <>'SYSTEM007' AND T1.MENUNAME <>'SYSTEM014'
			   AND T1.MENUNAME <> 'MENU_LOG' AND T1.MENUNAME <> 'LOGDAT001' AND T1.MENUNAME <> 'LOGDAT002'
			   AND T1.USEFLAG = 'Y'
		END
END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
