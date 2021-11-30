SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[F_CREATE_PR_CODE]
(
	@A_DEPARTMENT		NVARCHAR(50)
)
RETURNS NVARCHAR(50)
AS
BEGIN
			DECLARE @MAX_CODE nvarchar(50)

		    -- PRSMT-20210728-001

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

	-- Return the result of the function
	RETURN @MAX_CODE

END
GO
