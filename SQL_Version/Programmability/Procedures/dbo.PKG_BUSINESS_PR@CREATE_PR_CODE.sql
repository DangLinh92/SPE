﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_PR@CREATE_PR_CODE](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN

			DECLARE @MAX_CODE nvarchar(50)

		    -- PRSMT-20210728-001
		    SET NOCOUNT OFF;  
			SELECT TOP 1 @MAX_CODE = [PR_CODE]
			FROM [dbo].[EWIP_PURCHASE_REQUEST]
			WHERE [DEPT_CODE] = @A_DEPARTMENT AND  FORMAT(GETDATE(),'yyyyMMdd') =  CAST(SUBSTRING([PR_CODE],LEN([DEPT_CODE])+4,8) AS date)
			ORDER BY CAST(SUBSTRING([PR_CODE],LEN([DEPT_CODE])+4,8) AS date) DESC, CAST(SUBSTRING([PR_CODE],LEN([PR_CODE]) - 2,3) AS INT) DESC

			IF @MAX_CODE IS NULL OR @MAX_CODE = ''
				 BEGIN
					SET @MAX_CODE = 'PR'+ @A_DEPARTMENT + '-' + FORMAT(GETDATE(),'yyyyMMdd') +'-'+ '001'
				 END
			ELSE 
			        BEGIN	
						SELECT @MAX_CODE = SUBSTRING(@MAX_CODE,1,LEN(@A_DEPARTMENT) + 12) +  REPLACE(STR((CAST(SUBSTRING(@MAX_CODE,LEN(@A_DEPARTMENT) + 13,3) AS INT)+1), 3), SPACE(1), '0')  
					END
			SELECT @MAX_CODE as CODE
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO