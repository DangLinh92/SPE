SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GET_QUARTER_BY_MONTH]
(
	@MONTHS INT
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @QUARTER INT = 0

	IF @MONTHS IN(1,2,3)
	   SET @QUARTER = 1
	ELSE IF @MONTHS IN(4,5,6)
	   SET @QUARTER = 2
	ELSE IF @MONTHS IN (7,8,9)
	   SET @QUARTER = 3
	ELSE IF @MONTHS IN (10,11,12)
	   SET @QUARTER = 4

	-- Return the result of the function
	RETURN @QUARTER

END
GO
