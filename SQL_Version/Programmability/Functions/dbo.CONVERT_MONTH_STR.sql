SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CONVERT_MONTH_STR]
(
	-- Add the parameters for the function here
	@A_MONTH INT
)
RETURNS nvarchar(20)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(20)

	SELECT @Result = 
	CASE @A_MONTH
		when   1 THEN 'January'
		when  2 THEN 'February'
		when  3 THEN 'March'
		when  4 THEN 'April'
		when  5 THEN 'May'
		when  6 THEN 'June'
		when  7 THEN 'July'
		when  8 THEN 'August'
		when  9 THEN 'September'
		when  10 THEN 'October'
		when  11 THEN 'November'
		when  12 THEN 'December'
		ELSE ''
	END;

	-- Return the result of the function
	RETURN @Result

END
GO