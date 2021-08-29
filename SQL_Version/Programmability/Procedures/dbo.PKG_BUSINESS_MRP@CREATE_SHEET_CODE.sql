﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_MRP@CREATE_SHEET_CODE](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN

			DECLARE @MAX_CODE nvarchar(50)

		    -- SHSMT-20210728-001
		    SET NOCOUNT OFF;  
			SELECT TOP 1 @MAX_CODE = [SHEET_ID]
			FROM [dbo].[EWIP_INVENTORY_SHEET]
			WHERE [DEPT_CODE] = @A_DEPARTMENT AND  FORMAT(GETDATE(),'yyyyMMdd') = CAST(SUBSTRING([SHEET_ID],LEN([DEPT_CODE])+4,8) AS date)
			ORDER BY CAST(SUBSTRING([SHEET_ID],LEN([DEPT_CODE])+4,8) AS date) DESC, CAST(SUBSTRING([SHEET_ID],LEN([SHEET_ID]) - 2,3) AS INT) DESC

			IF @MAX_CODE IS NULL OR @MAX_CODE = ''
				 BEGIN
					SET @MAX_CODE = 'SH'+ @A_DEPARTMENT + '-' + FORMAT(GETDATE(),'yyyyMMdd') +'-'+ '001'
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