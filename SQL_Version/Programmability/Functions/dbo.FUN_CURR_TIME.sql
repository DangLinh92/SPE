SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE  FUNCTION [dbo].[FUN_CURR_TIME]()
RETURNS VARCHAR(14)
AS
BEGIN
	DECLARE @V_CURR_TIME varchar(14);
	SET @V_CURR_TIME = CONVERT(CHAR(8),GETDATE(),112)+REPLACE(CONVERT(CHAR(8),GETDATE(),108),':','');
	RETURN @V_CURR_TIME

END
GO