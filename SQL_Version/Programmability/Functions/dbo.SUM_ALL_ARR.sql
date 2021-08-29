SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SUM_ALL_ARR] 
(
	-- Add the parameters for the function here
	@A_TIME_FROM NVARCHAR(50),
	@A_TIME_TO  NVARCHAR(50)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @TIME_FROM DATE = CAST(@A_TIME_FROM AS date);
	DECLARE @TIME_TO DATE = CAST(@A_TIME_TO AS date);
	DECLARE @RESULT NVARCHAR(MAX) = '';

	DECLARE @MONTH_NUMBER INT = DATEDIFF(month,@TIME_FROM,@TIME_TO);
	DECLARE @I INT = 0;

	WHILE @I <=  @MONTH_NUMBER
	   BEGIN
			IF @I < @MONTH_NUMBER
				SET @RESULT = @RESULT + 'SUM([Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+ CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']) AS Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+',
										 SUM([Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+ ']) AS Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+ ',
										 SUM([Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']) AS Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+',
										 SUM([Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']) AS Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+','
			ELSE
				SET @RESULT = @RESULT + 'SUM([Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']) AS Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+',
										 SUM([Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+ ']) AS Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+ ',
										 SUM([Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']) AS Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+',
										 SUM([Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']) AS Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+''
			SET @I = @I + 1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END

--CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))
GO