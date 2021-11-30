SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CONVERT_INOUT_STR] 
(
	-- Add the parameters for the function here
	@INOUT NVARCHAR(50)
)
RETURNS NVARCHAR(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @RESULT NVARCHAR(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @RESULT = 
	    CASE @INOUT
			WHEN 'IN' THEN 'Receive'
			WHEN 'OUT' THEN 'Delivery'
			WHEN 'QUANTITY' THEN 'Stock'
			WHEN 'QUANTITY_REAL' THEN 'Inventory'
			ELSE ''
		END;

	-- Return the result of the function
	RETURN @RESULT

END
GO
