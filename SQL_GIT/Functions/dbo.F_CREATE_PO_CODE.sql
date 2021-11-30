SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[F_CREATE_PO_CODE]()
RETURNS NVARCHAR(50)
AS
BEGIN
		    DECLARE @MAX_CODE nvarchar(50)

		    -- PO-20210728-001

			SELECT TOP 1 @MAX_CODE = [PO_ID_TEMP]
			FROM [dbo].[EWIP_ORDER]
			WHERE FORMAT(GETDATE(),'yyyyMMdd') = CAST(SUBSTRING([PO_ID_TEMP],4,8) AS date)
			ORDER BY CAST(SUBSTRING([PO_ID_TEMP],4,8) AS date) DESC, CAST(SUBSTRING([PO_ID_TEMP],LEN([PO_ID_TEMP])-2,3) AS INT) DESC

			IF @MAX_CODE IS NULL OR @MAX_CODE = ''
				 BEGIN
					SET @MAX_CODE = 'PO' + '-' + FORMAT(GETDATE(),'yyyyMMdd') +'-'+ '001'
				 END
			ELSE 
			        BEGIN	
						SELECT @MAX_CODE = SUBSTRING(@MAX_CODE,1, 12) +  REPLACE(STR((CAST(SUBSTRING(@MAX_CODE,13,3) AS INT)+1), 3), SPACE(1), '0')  
					END

			-- Return the result of the function
			RETURN @MAX_CODE
END
GO
