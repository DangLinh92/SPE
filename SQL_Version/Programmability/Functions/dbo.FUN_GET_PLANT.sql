SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE  FUNCTION [dbo].[FUN_GET_PLANT]()
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @V_PLANT varchar(20);
	SET @V_PLANT = 'LFEM';
	RETURN @V_PLANT

END







GO