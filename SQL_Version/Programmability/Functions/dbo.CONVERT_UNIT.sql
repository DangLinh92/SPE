SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CONVERT_UNIT]
(
	@A_UNIT_FROM VARCHAR(20),
	@A_UNIT_TO VARCHAR(20),
	@A_SPARE_PART_CODE NVARCHAR(50),
	@A_DEPT_CODE NVARCHAR(50)
)
RETURNS FLOAT
AS
BEGIN

	-- Declare the return variable here
	DECLARE @RATE1 float;
	DECLARE @RATE2 float;
	DECLARE @RESULT float;

	SELECT @RATE1 = RATE 
	FROM [dbo].[EWIP_SPAREPART_UNIT] 
	WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND UNIT_CODE = @A_UNIT_FROM AND [DEPT_CODE] = @A_DEPT_CODE

	SELECT @RATE2 = RATE 
	FROM [dbo].[EWIP_SPAREPART_UNIT] 
	WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND UNIT_CODE = @A_UNIT_TO AND [DEPT_CODE] = @A_DEPT_CODE


	IF @RATE1 IS NULL OR @RATE2 IS NULL
	   SET @RESULT = 1;
   ELSE
	  SET @RESULT = @RATE1/@RATE2

	-- Return the result of the function
	RETURN @RESULT

END
GO