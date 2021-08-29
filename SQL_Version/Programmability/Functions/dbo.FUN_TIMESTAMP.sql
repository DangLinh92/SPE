SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[FUN_TIMESTAMP]()
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @V_CURR_TIME NVARCHAR(50);
	SET @V_CURR_TIME = CAST(CONVERT(NVARCHAR(50), GETDATE(), 120) AS NVARCHAR);
	RETURN @V_CURR_TIME

END
GO