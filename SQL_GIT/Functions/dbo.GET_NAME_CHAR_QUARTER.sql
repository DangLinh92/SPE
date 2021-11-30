SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GET_NAME_CHAR_QUARTER]
(
	@QUARTER INT
)
RETURNS NVARCHAR(5)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @NAME NVARCHAR(5)

	IF @QUARTER = 1
	   SET @name = 'I'
	ELSE IF @QUARTER = 2
	  SET @name = 'II'
	ELSE IF @QUARTER = 3
	  SET @name = 'III'
	ELSE IF @QUARTER = 4
	  SET @name = 'IV'

	-- Return the result of the function
	RETURN @name

END
GO
