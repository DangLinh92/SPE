SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[CREATE_BARCODE]
(
	@A_CODE NVARCHAR(50),
	@A_LOCATION NVARCHAR(50),
	@A_NG NVARCHAR(50)
)
RETURNS NVARCHAR(100)
AS
BEGIN

	-- Declare the return variable here
	DECLARE @RESULT NVARCHAR(100);

	IF @A_LOCATION IS NULL
	   SET @A_LOCATION = ''
	
	SELECT @RESULT = @A_CODE + (CASE @A_LOCATION  
	                           WHEN '' THEN ''
							   ELSE '.'+@A_LOCATION
							   END ) +  (CASE @A_NG 
							             WHEN 'NG' THEN '.NG'
										 ELSE '' END)
	-- Return the result of the function
	RETURN @RESULT

END
GO