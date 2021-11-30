SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[F_CREATE_MRP_CODE]
(
	-- Add the parameters for the function here
	@A_DEPARTMENT		NVARCHAR(50)
)
RETURNS nvarchar(50)
AS
BEGIN
			DECLARE @MAX_CODE nvarchar(50)

		    -- MRPSMT-20210728-001
			SELECT TOP 1 @MAX_CODE = [MRP_CODE]
			FROM [dbo].[EWIP_MRP_LIST]
			WHERE [DEPT_CODE] = @A_DEPARTMENT AND FORMAT(GETDATE(),'yyyyMMdd') = CAST(SUBSTRING(MRP_CODE,LEN(@A_DEPARTMENT) + 5,8) AS date)
			ORDER BY CAST(SUBSTRING(MRP_CODE,LEN(@A_DEPARTMENT) + 5,8) AS date) DESC, CAST(SUBSTRING(MRP_CODE,LEN(MRP_CODE)-2,3) AS INT) DESC

			IF @MAX_CODE IS NULL OR @MAX_CODE = ''
				 BEGIN
					SET @MAX_CODE = 'MRP' + @A_DEPARTMENT + '-' + FORMAT(GETDATE(),'yyyyMMdd') +'-'+ '001'
				 END
			ELSE 
			        BEGIN	
						SELECT @MAX_CODE = SUBSTRING(@MAX_CODE,1,LEN(@A_DEPARTMENT) + 13) +  REPLACE(STR((CAST(SUBSTRING(@MAX_CODE,LEN(@A_DEPARTMENT) + 14,3) AS INT)+1), 3), SPACE(1), '0')  
					END

	     -- Return the result of the function
	        RETURN @MAX_CODE
END
GO
