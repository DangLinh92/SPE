USE [SPARE_PART_UPDATE]
GO
/****** Object:  UserDefinedTableType [dbo].[GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE2]    Script Date: 7/17/2021 2:55:03 PM ******/
CREATE TYPE [dbo].[GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE2] AS TABLE(
	[RECEIPT_ISSUE_CODE] [nvarchar](50) NULL,
	[SPARE_PART_CODE] [nvarchar](50) NULL,
	[NAME] [nvarchar](200) NULL,
	[QUANTITY] [float] NULL,
	[UNIT] [nvarchar](50) NULL,
	[PRICE_VN] [float] NULL,
	[PRICE_US] [float] NULL,
	[AMOUNT_VN] [float] NULL,
	[AMOUNT_US] [float] NULL,
	[CAUSE] [nvarchar](500) NULL,
	[NOTE] [nvarchar](500) NULL,
	[STOCK_CODE] [varchar](50) NULL,
	[DEPT_CODE] [nvarchar](100) NULL,
	[INT_OUT] [nvarchar](50) NULL,
	[CREATE_DATE] [date] NULL,
	[USER_CREATE] [nvarchar](50) NULL,
	[USER_SYS] [nvarchar](50) NULL,
	[ORDER_CODE] [nvarchar](50) NULL,
	[STATUS] [nvarchar](50) NULL,
	[TYPE_IN_OUT_CODE] [nvarchar](50) NULL,
	[RETURN_TIME] [nvarchar](50) NULL,
	[LOCATION] [nvarchar](500) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[LOCATION_TYPE]    Script Date: 7/17/2021 2:55:03 PM ******/
CREATE TYPE [dbo].[LOCATION_TYPE] AS TABLE(
	[CODE] [nvarchar](50) NULL,
	[STOCK_CODE] [varchar](50) NULL,
	[DEPT_CODE] [nvarchar](100) NULL,
	[RACK_CODE] [nchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SPAREPART_LOCATION_TYPE]    Script Date: 7/17/2021 2:55:03 PM ******/
CREATE TYPE [dbo].[SPAREPART_LOCATION_TYPE] AS TABLE(
	[SPARE_PART_CODE] [nvarchar](50) NULL,
	[LOCATION_CODE] [nvarchar](50) NULL,
	[CONDITION_CODE] [nvarchar](50) NULL,
	[IS_WAITE] [nvarchar](10) NULL,
	[QUANTITY] [nvarchar](50) NULL,
	[UNIT_ID] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SPAREPART_LOCATION_TYPE1]    Script Date: 7/17/2021 2:55:03 PM ******/
CREATE TYPE [dbo].[SPAREPART_LOCATION_TYPE1] AS TABLE(
	[SPARE_PART_CODE] [nvarchar](50) NULL,
	[LOCATION_CODE] [nvarchar](50) NULL,
	[CONDITION_CODE] [nvarchar](50) NULL,
	[IS_WAITE] [nvarchar](10) NULL,
	[QUANTITY] [nvarchar](50) NULL,
	[UNIT_ID] [nvarchar](50) NULL,
	[EXPIRED_DATE] [nvarchar](50) NULL,
	[TIME_IN] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TableType]    Script Date: 7/17/2021 2:55:03 PM ******/
CREATE TYPE [dbo].[TableType] AS TABLE(
	[MONTH] [int] NULL,
	[YEAR] [int] NULL,
	[CODE] [nvarchar](50) NULL,
	[NAME_VI] [nvarchar](200) NULL,
	[DESCRIPTION] [nvarchar](1000) NULL,
	[PRICE_VN] [float] NULL,
	[PRICE_US] [float] NULL,
	[VENDER_NAME] [nvarchar](50) NULL,
	[UNIT] [nvarchar](50) NULL,
	[SPARE_PART_TYPE] [nvarchar](50) NULL,
	[MIN_STOCK] [float] NULL,
	[QUANTITY_MONTH] [float] NULL,
	[IN_OUT] [nvarchar](50) NULL,
	[QUANTITY] [float] NULL,
	[QUANTITY_REAL] [float] NULL,
	[STOCK_CODE] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[ALL_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE FUNCTION [dbo].[ALL_ARR] 
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
				SET @RESULT = @RESULT + '[Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'],
										 [Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+ '],
										 [Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'],
										 [Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'],'
			ELSE
				SET @RESULT = @RESULT + '[Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'],
										 [Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+ '],
										 [Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'],
										 [Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']'
			SET @I = @I + 1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END
GO
/****** Object:  UserDefinedFunction [dbo].[CHAR_TO_DATE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[CHAR_TO_DATE]
(
 @CHARDATETIME VARCHAR(14)
) 


RETURNS varchar(24)


AS 


 BEGIN 
  DECLARE @ReturnDate varchar(24)

  IF LEN(@CHARDATETIME) = 14
	BEGIN
  
	  SET @ReturnDate = 
		 left(@CHARDATETIME,4) + '-' 
		 + substring(@CHARDATETIME,5,2) +'-'
		 + substring(@CHARDATETIME,7,2) +' '
		 + substring(@CHARDATETIME,9,2) +':'
		 + substring(@CHARDATETIME,11,2) + ':' 
		 + right(@CHARDATETIME,2)
	END
  ELSE IF LEN(@CHARDATETIME) = 8
    BEGIN
	  SET @ReturnDate = 
		 left(@CHARDATETIME,4) + '-' 
		 + substring(@CHARDATETIME,5,2) +'-'
		 + substring(@CHARDATETIME,7,2);
	END
  ELSE IF LEN(@CHARDATETIME) = 6
    BEGIN
	  SET @ReturnDate = 
		 left(@CHARDATETIME,4) + '-' 
		 + substring(@CHARDATETIME,5,2)
	END
  ELSE
  BEGIN
      SET @ReturnDate = '';
  END;

  RETURN @ReturnDate
 END
GO
/****** Object:  UserDefinedFunction [dbo].[CHAR_TO_MONTHYEAR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[CHAR_TO_MONTHYEAR]
(
 @CHARDATETIME VARCHAR(14)
) 


RETURNS varchar(24)


AS 


 BEGIN 
  DECLARE @ReturnDate varchar(24)

  IF LEN(@CHARDATETIME) = 14
	BEGIN
  
	  SET @ReturnDate = 
		 left(@CHARDATETIME,4) + '-' 
		 + substring(@CHARDATETIME,5,2) +'-'
		 + substring(@CHARDATETIME,7,2) +' '
		 + substring(@CHARDATETIME,9,2) +':'
		 + substring(@CHARDATETIME,11,2) + ':' 
		 + right(@CHARDATETIME,2)
	END
  ELSE IF LEN(@CHARDATETIME) = 8
    BEGIN
	  SET @ReturnDate = 
		 left(@CHARDATETIME,4) + '-' 
		 + substring(@CHARDATETIME,5,2) +'-'
		 + substring(@CHARDATETIME,7,2);
	END
  ELSE
  BEGIN
      SET @ReturnDate = '';
  END;

  RETURN @ReturnDate
 END

GO
/****** Object:  UserDefinedFunction [dbo].[CONVERT_INOUT_STR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[CONVERT_MONTH_STR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[CONVERT_UNIT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[CREATE_BARCODE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[DELIVERY_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DELIVERY_ARR] 
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
				SET @RESULT = @RESULT + '[Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'],'
			ELSE
				SET @RESULT = @RESULT + '[Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']'

				SET @I =@I+1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END
GO
/****** Object:  UserDefinedFunction [dbo].[FUN_CURR_TIME]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[FUN_GET_PLANT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[FUN_TIMESTAMP]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[GETBARCODE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GETBARCODE] 
(
	@A_LOCATION  NVARCHAR(50),
	@A_SPAREPART  NVARCHAR(50),
	@A_CONDITION  NVARCHAR(50)
)
RETURNS NVARCHAR(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @BARCODE NVARCHAR(50)

	SET @BARCODE = CASE 
				          WHEN @A_LOCATION = '' OR @A_LOCATION IS NULL THEN  CASE 
					                                                                WHEN @A_CONDITION = 'NG' THEN @A_SPAREPART+'.NG'
																					ELSE @A_SPAREPART
																				END
							ELSE 
								CASE  
										WHEN @A_CONDITION = 'NG' THEN @A_SPAREPART+'.'+@A_LOCATION+'.NG'
										ELSE @A_SPAREPART+'.'+@A_LOCATION
								END
				      END

	-- Return the result of the function
	RETURN @BARCODE

END
GO
/****** Object:  UserDefinedFunction [dbo].[INVENTORY_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[INVENTORY_ARR] 
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
				SET @RESULT = @RESULT + '[Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'],'
			ELSE
				SET @RESULT = @RESULT + '[Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']'
		 SET @I = @I+1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END
GO
/****** Object:  UserDefinedFunction [dbo].[RECEIVE_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[RECEIVE_ARR] 
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
				SET @RESULT = @RESULT + '[Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'],'
			ELSE
				SET @RESULT = @RESULT + '[Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']'
			SET @I = @I+1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END
GO
/****** Object:  UserDefinedFunction [dbo].[STOCK_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[STOCK_ARR] 
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
				SET @RESULT = @RESULT + '[Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'],'
			ELSE
				SET @RESULT = @RESULT + '[Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']'
			SET @I = @I+1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END
GO
/****** Object:  UserDefinedFunction [dbo].[SUM_ALL_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[SUM_DELIVERY_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SUM_DELIVERY_ARR] 
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
				SET @RESULT = @RESULT + 'SUM([Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']),'
		   ELSE
				SET @RESULT = @RESULT + 'SUM([Delivery_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'])'
				SET @I = @I+1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END
GO
/****** Object:  UserDefinedFunction [dbo].[SUM_INVENTORY_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SUM_INVENTORY_ARR] 
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
				SET @RESULT = @RESULT + 'SUM([Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']),'
			ELSE
				SET @RESULT = @RESULT + 'SUM([Inventory_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'])'
				SET @I = @I+1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END
GO
/****** Object:  UserDefinedFunction [dbo].[SUM_RECEIVE_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SUM_RECEIVE_ARR] 
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
				SET @RESULT = @RESULT + 'SUM([Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']),'
			ELSE
				SET @RESULT = @RESULT + 'SUM([Receive_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'])'
				SET @I = @I+1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END
GO
/****** Object:  UserDefinedFunction [dbo].[SUM_STOCK_ARR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SUM_STOCK_ARR] 
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
				SET @RESULT = @RESULT + 'SUM([Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+']),'
			ELSE
				SET @RESULT = @RESULT + 'SUM([Stock_'+ [dbo].[CONVERT_MONTH_STR](MONTH(DATEADD(month,@I,@TIME_FROM))) + '_'+CAST(YEAR(DATEADD(month,@I,@TIME_FROM)) AS nvarchar(4))+'])'
				SET @I = @I+1;
	   END
	
	-- Return the result of the function
	RETURN @RESULT
END
GO
/****** Object:  Table [dbo].[ESYSLOGFORM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSLOGFORM](
	[PLANT] [varchar](10) NOT NULL,
	[USER_ID] [varchar](30) NOT NULL,
	[HIST_SEQ] [int] NOT NULL,
	[FORM_CODE] [varchar](30) NOT NULL,
	[DEPARTMENT] [varchar](50) NOT NULL,
	[ACCESS_TIME] [varchar](14) NOT NULL,
 CONSTRAINT [PK_ESYSLOGFORM] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[USER_ID] ASC,
	[HIST_SEQ] ASC,
	[FORM_CODE] ASC,
	[DEPARTMENT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESYSMSTDEPT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSMSTDEPT](
	[CODE] [nvarchar](100) NOT NULL,
	[DEPARTMENT] [nvarchar](100) NULL,
 CONSTRAINT [PK_ESYSMSTDEPT] PRIMARY KEY CLUSTERED 
(
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESYSMSTFORM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSMSTFORM](
	[PLANT] [varchar](10) NOT NULL,
	[DEPARTMENT] [varchar](50) NOT NULL,
	[FORM] [varchar](30) NOT NULL,
	[FORMNAME] [nvarchar](50) NOT NULL,
	[MENUAL_FILE] [nvarchar](4000) NULL,
	[ACCESS_TYPE] [char](1) NULL,
	[USEFLAG] [char](1) NOT NULL,
	[REMARKS] [nvarchar](4000) NULL,
	[CREATE_TIME] [varchar](14) NOT NULL,
	[CREATE_USER] [varchar](20) NOT NULL,
	[UPDATE_TIME] [varchar](14) NULL,
	[UPDATE_USER] [varchar](20) NULL,
 CONSTRAINT [PK_ESYSMSTFORM] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[DEPARTMENT] ASC,
	[FORM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESYSMSTGLA]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSMSTGLA](
	[PLANT] [varchar](10) NOT NULL,
	[DEPARTMENT] [varchar](50) NOT NULL,
	[GLSR] [varchar](200) NOT NULL,
	[ENG] [nvarchar](4000) NULL,
	[KOR] [nvarchar](4000) NULL,
	[CHN] [nvarchar](4000) NULL,
	[VTN] [nvarchar](4000) NULL,
	[MASTER_FLAG] [char](1) NULL,
	[CREATE_TIME] [varchar](14) NOT NULL,
	[CREATE_USER] [varchar](20) NOT NULL,
	[UPDATE_TIME] [varchar](14) NULL,
	[UPDATE_USER] [varchar](20) NULL,
	[USE_FLAG] [varchar](1) NULL,
 CONSTRAINT [PK_ESYSMSTGLA] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[DEPARTMENT] ASC,
	[GLSR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESYSMSTMEU]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSMSTMEU](
	[PLANT] [varchar](10) NOT NULL,
	[DEPARTMENT] [varchar](50) NOT NULL,
	[MENUSEQ] [int] NOT NULL,
	[UPRSEQ] [int] NULL,
	[MENUNAME] [nvarchar](50) NOT NULL,
	[FORM] [varchar](30) NULL,
	[IMGIDX] [int] NULL,
	[DISPSEQ] [int] NULL,
	[DISPFLAG] [char](1) NOT NULL,
	[USEFLAG] [char](1) NOT NULL,
	[FORM_GUBUN] [varchar](10) NULL,
	[MASTER_FLAG] [char](1) NULL,
	[REMARKS] [nvarchar](4000) NULL,
	[IMAGE] [varchar](100) NULL,
	[CREATE_TIME] [varchar](14) NOT NULL,
	[CREATE_USER] [varchar](20) NOT NULL,
	[UPDATE_TIME] [varchar](14) NULL,
	[UPDATE_USER] [varchar](20) NULL,
 CONSTRAINT [PK_ESYSMSTMEU] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[DEPARTMENT] ASC,
	[MENUSEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESYSMSTMRO]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSMSTMRO](
	[PLANT] [varchar](10) NOT NULL,
	[DEPARTMENT] [varchar](50) NOT NULL,
	[USERROLE] [varchar](30) NOT NULL,
	[MENUSEQ] [int] NOT NULL,
	[FORMROLE] [varchar](3) NULL,
	[USEFLAG] [char](1) NULL,
	[CREATE_TIME] [varchar](14) NULL,
	[UPDATE_TIME] [varchar](20) NULL,
	[CREATE_USER] [varchar](30) NULL,
 CONSTRAINT [PK_ESYSMSTMRO] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[DEPARTMENT] ASC,
	[USERROLE] ASC,
	[MENUSEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESYSMSTROL]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSMSTROL](
	[PLANT] [varchar](10) NOT NULL,
	[DEPARTMENT] [varchar](50) NOT NULL,
	[USERROLE] [varchar](20) NOT NULL,
	[USERROLE_NAME] [nvarchar](50) NOT NULL,
	[USEFLAG] [char](1) NOT NULL,
	[REMARKS] [nvarchar](4000) NULL,
	[CREATE_TIME] [varchar](14) NOT NULL,
	[CREATE_USER] [varchar](30) NOT NULL,
	[UPDATE_TIME] [varchar](14) NULL,
	[UPDATE_USER] [varchar](30) NULL,
 CONSTRAINT [PK_ESYSMSTROL] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[DEPARTMENT] ASC,
	[USERROLE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESYSMSTURO]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSMSTURO](
	[PLANT] [varchar](10) NOT NULL,
	[DEPARTMENT] [varchar](50) NOT NULL,
	[USER_ID] [varchar](20) NOT NULL,
	[ITEM_NO] [int] NOT NULL,
	[USERROLE] [varchar](30) NULL,
	[CREATE_TIME] [varchar](14) NULL,
	[CREATE_USER] [varchar](20) NULL,
	[UPDATE_TIME] [varchar](14) NULL,
	[UPDATE_USER] [varchar](20) NULL,
 CONSTRAINT [PK_ESYSMSTURO] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[DEPARTMENT] ASC,
	[USER_ID] ASC,
	[ITEM_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESYSMSTUSR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSMSTUSR](
	[PLANT] [varchar](10) NOT NULL,
	[DEPARTMENT] [varchar](100) NOT NULL,
	[USER_ID] [varchar](20) NOT NULL,
	[PASSWORD] [nvarchar](200) NOT NULL,
	[USER_NAME] [nvarchar](100) NULL,
	[PHONE_NUM] [nvarchar](50) NULL,
	[EMAIL] [nvarchar](100) NULL,
	[USEFLAG] [char](1) NOT NULL,
	[ADDRESS] [nvarchar](1000) NULL,
	[REMARKS] [nvarchar](4000) NULL,
	[CREATE_TIME] [varchar](14) NOT NULL,
	[CREATE_USER] [varchar](20) NOT NULL,
	[UPDATE_TIME] [varchar](14) NULL,
	[UPDATE_USER] [varchar](20) NULL,
	[MASTER_FLAG] [varchar](1) NULL,
 CONSTRAINT [PK_ESYSMSTUSR] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[DEPARTMENT] ASC,
	[USER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_BOM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_BOM](
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[QUANTITY_IN_UNIT] [float] NULL,
	[UNIT] [varchar](20) NULL,
	[WORKING_DAY_NUMBER] [float] NULL,
	[WORKING_LINE_NUMBER] [float] NULL,
	[WORKING_A_LINE] [float] NULL,
	[WORKING_A_MONTH] [float] NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[WORKING_A_LINE_PACK] [float] NULL,
 CONSTRAINT [PK_EWIP_BOM] PRIMARY KEY CLUSTERED 
(
	[SPARE_PART_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_COST_CTR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_COST_CTR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[COST_CTR] [varchar](50) NOT NULL,
	[SHORT_TEXT] [varchar](50) NULL,
	[DEPT_CODE] [nvarchar](100) NULL,
 CONSTRAINT [PK_EWIP_COST_CTR] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_EXCHANGE_RATE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_EXCHANGE_RATE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VALID_TIME] [date] NOT NULL,
	[FROM] [varchar](5) NOT NULL,
	[TO] [varchar](5) NOT NULL,
	[RATE] [float] NOT NULL,
	[UPDATED_AT] [date] NULL,
	[CREATED_AT] [date] NULL,
 CONSTRAINT [PK_EWIP_EXCHANGE_RATE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_FILE_TEMP]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_FILE_TEMP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[ContenType] [nvarchar](300) NOT NULL,
	[Data] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_EWIP_FILE_TEMP] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_GL_ACCOUNT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_GL_ACCOUNT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GL_ACCOUNT] [varchar](50) NOT NULL,
	[SHORT_TEXT_VN] [nvarchar](50) NULL,
	[SHORT_TEXT_KR] [nvarchar](200) NULL,
 CONSTRAINT [PK_EWIP_GL_ACCOUNT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_HISTORY_INVENTORY]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_HISTORY_INVENTORY](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[QUANTITY] [float] NOT NULL,
	[UNIT] [varchar](20) NOT NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[STOCK_CODE] [varchar](50) NOT NULL,
	[DATE] [date] NULL,
	[MONTH] [int] NULL,
	[YEAR] [int] NULL,
	[IN_OUT] [nvarchar](50) NULL,
	[STOCK_IN_OUT_CODE] [nvarchar](50) NULL,
	[STATUS] [nvarchar](50) NULL,
 CONSTRAINT [PK_EWIP_HISTORY_INVENTORY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[CAUSE_REPAIR] [nvarchar](500) NULL,
	[TIME_REPAIR] [date] NULL,
	[TIME_SUCCESS] [date] NULL,
	[ACTION] [nvarchar](500) NULL,
	[USER_REPARE] [nvarchar](100) NULL,
 CONSTRAINT [PK_EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_INVENTORY_BY_TIME]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_INVENTORY_BY_TIME](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NULL,
	[QUANTITY] [float] NULL,
	[UNIT] [varchar](20) NULL,
	[DEPT_CODE] [nvarchar](100) NULL,
	[STOCK_CODE] [varchar](50) NULL,
	[DATE] [date] NULL,
	[MONTH] [int] NULL,
	[YEAR] [int] NULL,
	[QUANTITY_REAL] [float] NULL,
 CONSTRAINT [PK_EWIP_INVENTORY_BY_TIME] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODE_NO] [nvarchar](50) NOT NULL,
	[DATE] [date] NULL,
	[IN_OUT] [nvarchar](50) NULL,
	[STOCK_CODE] [varchar](50) NULL,
	[DEPT_CODE] [nvarchar](100) NULL,
	[USER_CREATE] [nvarchar](50) NULL,
	[USER_SYS] [nvarchar](50) NULL,
	[ORDER_CODE] [nvarchar](50) NULL,
	[STATUS] [nvarchar](50) NULL,
	[DELIVERET_RECEIVER] [nvarchar](100) NULL,
 CONSTRAINT [PK_EWIP_INVENTORY_DELIVERY_RECEIVING] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_LABEL]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_LABEL](
	[CODE] [nvarchar](50) NOT NULL,
	[LABEL] [nvarchar](max) NULL,
	[DESC] [nvarchar](500) NULL,
 CONSTRAINT [PK_EWIP_LABEL] PRIMARY KEY CLUSTERED 
(
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_LOCATIONS]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_LOCATIONS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODE] [nvarchar](50) NOT NULL,
	[STOCK_CODE] [varchar](50) NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[UPDATE_DATE] [date] NULL,
 CONSTRAINT [PK_EWIP_LOCATIONS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_ORDER]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_ORDER](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ORDER_ID] [nvarchar](50) NULL,
	[SPARE_PART_CODE] [nvarchar](50) NULL,
	[UNIT_CODE] [nvarchar](50) NULL,
	[QUANTITY] [float] NULL,
	[PRICE_VN] [float] NULL,
	[PRICE_US] [float] NULL,
	[VENDER_ID] [varchar](50) NULL,
	[LEAD_TIME] [date] NULL,
	[DATE_CREATE] [date] NULL,
	[DEPT_CODE] [nvarchar](100) NULL,
	[STATUS] [int] NULL,
	[USER_ID] [varchar](20) NULL,
	[UPDATED_DATE] [date] NULL,
	[TITLE] [nvarchar](200) NULL,
 CONSTRAINT [PK_EWIP_ORDER] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SETUP_MINSTOCK]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SETUP_MINSTOCK](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[UNIT_CODE] [varchar](20) NOT NULL,
	[MIN_STOCK] [float] NOT NULL,
	[STOCK_CODE] [varchar](50) NOT NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[RATE_ALARM] [float] NULL,
 CONSTRAINT [PK_EWIP_SETUP_MINSTOCK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SP_STOCKIN]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SP_STOCKIN](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[STOCK_IN_CODE] [nvarchar](50) NOT NULL,
	[QUANTITY] [float] NOT NULL,
	[PRICE_VN] [float] NOT NULL,
	[UNIT_CODE] [varchar](20) NOT NULL,
	[VENDER_ID] [varchar](50) NULL,
	[STOCK_CODE] [varchar](50) NULL,
	[CAUSE] [nvarchar](500) NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[DATE_IN] [date] NOT NULL,
	[USER_ID] [varchar](20) NULL,
	[AMOUNT_US] [float] NULL,
	[AMOUNT_VN] [float] NULL,
	[NOTE] [nvarchar](500) NULL,
	[YEAR] [int] NULL,
	[MONTH] [int] NULL,
	[PRICE_US] [float] NULL,
	[TYPE_IN_CODE] [nvarchar](50) NULL,
 CONSTRAINT [PK_EWIP_SP_STOCKIN] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SPARE_PART_DEPT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SPARE_PART_DEPT](
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[COST_CTR] [varchar](50) NULL,
 CONSTRAINT [PK_EWIP_SPARE_PART_DEPT] PRIMARY KEY CLUSTERED 
(
	[DEPT_CODE] ASC,
	[SPARE_PART_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SPAREPART_CONDITION]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SPAREPART_CONDITION](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODE] [varchar](50) NOT NULL,
	[NAME] [nvarchar](50) NULL,
 CONSTRAINT [PK_EWIP_SPAREPART_CONDITION] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SPAREPART_DOCUMENT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SPAREPART_DOCUMENT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[LINK] [nvarchar](1000) NULL,
 CONSTRAINT [PK_EWIP_SPAREPART_DOCUMENT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SPAREPART_INVENTORY]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SPAREPART_INVENTORY](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[QUANTITY] [float] NOT NULL,
	[UNIT_IN_CODE] [varchar](20) NOT NULL,
	[QUANTITY_REAL] [float] NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[STOCK_CODE] [varchar](50) NOT NULL,
	[CREATE_DATE] [date] NULL,
	[UPDATE_DATE] [date] NULL,
	[USER_UPDATE] [nvarchar](50) NULL,
 CONSTRAINT [PK_EWIP_SPAREPART_INVENTORY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SPAREPART_LOCATION]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SPAREPART_LOCATION](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[LOCATION_CODE] [nvarchar](50) NULL,
	[CONDITION_CODE] [varchar](50) NULL,
	[IS_WAITE] [bit] NULL,
	[QUANTITY] [float] NULL,
	[DEPT_CODE] [varchar](50) NULL,
	[STOCK_CODE] [varchar](50) NULL,
	[BARCODE] [nvarchar](100) NULL,
	[UNIT_ID] [varchar](20) NULL,
	[EXPIRED_DATE] [date] NULL,
	[TIME_IN] [date] NULL,
 CONSTRAINT [PK_EWIP_SPAREPART_LOCATION] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SPAREPART_PRICE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SPAREPART_PRICE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[STOCK_IN_CODE] [varchar](50) NULL,
	[PRICE_VN] [float] NULL,
	[PRICE_US] [float] NULL,
	[UNIT_CODE] [varchar](20) NULL,
	[DEPT_CODE] [nvarchar](50) NULL,
	[DATE] [date] NULL,
 CONSTRAINT [PK_EWIP_SPAREPART_PRICE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SPAREPART_TYPE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SPAREPART_TYPE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODE] [varchar](50) NOT NULL,
	[NAME] [nvarchar](50) NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_EWIP_SPAREPART_TYPE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SPAREPART_UNIT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SPAREPART_UNIT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NULL,
	[UNIT_CODE] [varchar](20) NULL,
	[UNIT_CODE_MIN] [varchar](20) NULL,
	[RATE] [float] NULL,
	[DEPT_CODE] [nvarchar](50) NULL,
 CONSTRAINT [PK_EWIP_SPAREPART_UNIT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_STOCK]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_STOCK](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODE] [varchar](50) NOT NULL,
	[NAME] [nvarchar](50) NULL,
	[DEPT_CODE] [nvarchar](100) NOT NULL,
	[MANAGERMENT_EMAIL1] [nvarchar](320) NULL,
	[MANAGERMENT_EMAIL2] [nvarchar](320) NULL,
 CONSTRAINT [PK_EWIP_STOCK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_STOCK_OUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_STOCK_OUT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[STOCK_OUT_CODE] [nvarchar](50) NOT NULL,
	[SPARE_PART_CODE] [nvarchar](50) NOT NULL,
	[CAUSE] [nvarchar](100) NULL,
	[STOCK_CODE] [varchar](50) NULL,
	[DEPT_CODE] [nvarchar](100) NULL,
	[DATE] [date] NULL,
	[YEAR] [int] NULL,
	[MONTH] [int] NULL,
	[USER_ID] [varchar](20) NULL,
	[QUANTITY] [float] NULL,
	[TYPE_OUT_CODE] [nvarchar](50) NULL,
	[RETURN_TIME] [date] NULL,
	[UNIT_ID] [varchar](20) NULL,
	[LOCATION] [nvarchar](500) NULL,
 CONSTRAINT [PK_EWIP_STOCK_OUT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_TYPE_IN_OUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_TYPE_IN_OUT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODE] [nvarchar](50) NULL,
	[NAME] [nvarchar](50) NULL,
 CONSTRAINT [PK_EWIP_TYPE_IN_OUT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_UNITS]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_UNITS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODE] [varchar](20) NOT NULL,
	[NAME] [nvarchar](50) NULL,
 CONSTRAINT [PK_EWIP_UNITS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_VENDER]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_VENDER](
	[VENDER_ID] [varchar](50) NOT NULL,
	[NAME] [nvarchar](50) NULL,
	[ADDRESS] [nvarchar](50) NULL,
	[PHONE] [nvarchar](15) NULL,
	[EMAIL] [nvarchar](50) NULL,
 CONSTRAINT [PK_EWIP_VENDER_1] PRIMARY KEY CLUSTERED 
(
	[VENDER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ESYSMSTDEPT] ([CODE], [DEPARTMENT]) VALUES (N'CSP', N'CSP')
GO
INSERT [dbo].[ESYSMSTDEPT] ([CODE], [DEPARTMENT]) VALUES (N'LFEM', N'LFEM')
GO
INSERT [dbo].[ESYSMSTDEPT] ([CODE], [DEPARTMENT]) VALUES (N'SMT', N'SMT')
GO
INSERT [dbo].[ESYSMSTDEPT] ([CODE], [DEPARTMENT]) VALUES (N'UTILITY', N'UTILITY')
GO
INSERT [dbo].[ESYSMSTDEPT] ([CODE], [DEPARTMENT]) VALUES (N'WLP1', N'WLP1')
GO
INSERT [dbo].[ESYSMSTDEPT] ([CODE], [DEPARTMENT]) VALUES (N'WLP2', N'WLP2')
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'BOM', N'BOM', NULL, NULL, N'Y', N'', N'20210403102710', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'COST_GLACCOUNT', N'COST_GLACCOUNT', NULL, NULL, N'Y', N'', N'20210412104705', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'CTG_STOCKIN', N'CTG_STOCKIN', NULL, NULL, N'Y', N'', N'20210402145853', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'EXCHANGE_RATE', N'EXCHANGE_RATE', NULL, NULL, N'Y', N'', N'20210312121232', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'INPUT_COST', N'INPUT_COST', NULL, NULL, N'Y', N'', N'20210405101606', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'LABEL', N'LABEL', NULL, NULL, N'Y', N'', N'20210316102258', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'LOCATION', N'LOCATION', NULL, NULL, N'Y', N'', N'20210316102305', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'LOGDAT001', N'LOGDAT001', NULL, N'Y', N'Y', N'', N'20210309160528', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'LOGDAT002', N'LOGDAT002', NULL, N'Y', N'Y', N'', N'20210309160723', N'H2102001', N'20210309161527', N'H2102001')
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'MAKER', N'MAKER', NULL, NULL, N'Y', N'', N'20210319110426', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'REPORT_STOCK', N'REPORT_STOCK', NULL, NULL, N'Y', N'', N'20210401095414', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'REPORT_STOCKIN', N'REPORT_STOCKIN', NULL, NULL, N'Y', N'', N'20210331151240', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'REPORT001', N'REPORT001', NULL, N'Y', N'Y', NULL, N'20200304151617', N'H2002001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'REPRINT_LABEL', N'REPRINT_LABEL', NULL, NULL, N'Y', N'', N'20210330163217', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'SPARE_PART', N'SPARE_PART', NULL, NULL, N'Y', N'', N'20210320095709', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'SPAREPART_INVENTORY', N'SPAREPART_INVENTORY', NULL, NULL, N'Y', N'', N'20210315082822', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'STOCK_IN', N'STOCK_IN', NULL, NULL, N'Y', N'', N'20210324100244', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'STOCK_OUT', N'STOCK_OUT', NULL, NULL, N'N', N'', N'20210406163216', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'STOCKIN_CANCEL', N'STOCKIN_CANCEL', NULL, NULL, N'Y', N'', N'20210326134923', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'SYSTEM001', N'SYSTEM001', NULL, N'Y', N'Y', NULL, N'20201202091011', N'H2002001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'SYSTEM002', N'SYSTEM002', NULL, N'Y', N'Y', NULL, N'20201202091011', N'H2002001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'SYSTEM004', N'SYSTEM004', NULL, N'Y', N'Y', NULL, N'20201202091011', N'H2002001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'SYSTEM005', N'SYSTEM005', NULL, N'Y', N'Y', NULL, N'2.02E+13', N'H2002001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'SYSTEM006', N'SYSTEM006', NULL, N'Y', N'Y', NULL, N'2.02E+13', N'H2002001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'SYSTEM008', N'SYSTEM008', NULL, N'Y', N'Y', NULL, N'2.02E+13', N'H2002001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTFORM] ([PLANT], [DEPARTMENT], [FORM], [FORMNAME], [MENUAL_FILE], [ACCESS_TYPE], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'UNIT', N'UNIT', NULL, NULL, N'Y', N'', N'20210315082822', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'ACCESS_IP', NULL, N'액세스 ip', NULL, N'Địa chỉ truy cập', NULL, N'20210401142507', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'ACCESS_PC', NULL, N'액세스 PC', NULL, N'Máy truy cập', NULL, N'20210401142542', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'ACCESS_TIME', NULL, N'액세스 시간', NULL, N'Thời gian truy cập', NULL, N'20210401142428', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'ADDRESS', NULL, N'주소', NULL, N'Địa chỉ', NULL, N'20210401143639', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'AMOUNT', NULL, N'양', NULL, N'Tổng tiền', NULL, N'20210401145505', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'AMOUNT_US', NULL, N'양(US)', NULL, N'Số Tiền(US)', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'AMOUNT_VN', NULL, N'양(VN)', NULL, N'Số Tiền(VN)', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'BALANCE_WAREHOUSE', NULL, N'평등 수량', NULL, N'Cân bằng kho', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'BOM', NULL, N'BOM', NULL, N'Định mức vật tư', NULL, N'20210403102703', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CANCEL_STOCKIN', NULL, N'Hủy nhập', NULL, N'Hủy nhập', NULL, N'20210405081900', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CATEGORY', NULL, N'범주', NULL, N'Danh mục', NULL, N'20210402154330', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CAUSE', NULL, N'원인', NULL, N'Nguyên nhân(nhập/xuất)', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CHAR_STOCKIN_30DAYS', NULL, N'30 일 창고 재고 차트', NULL, N'Biểu đồ nhập kho 30 ngày', NULL, N'20210401145730', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CLEAR', NULL, N'맑은', NULL, N'Làm mới', NULL, N'20210401143450', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CODE', NULL, N'암호', NULL, N'Mã', NULL, N'20210401142921', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CODE(*)', NULL, N'암호(*)', NULL, N'Mã(*)', NULL, N'20210401142921', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CODE_MAKER', NULL, N'코드 메이커', NULL, N'Mã nhà cung cấp', NULL, N'20210401144441', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CODE_OF_MAKER', NULL, N'코드 메이커', NULL, N'Mã nhà cung cấp', NULL, N'20210401171407', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CONDITION', NULL, N'질환', NULL, N'Điều kiện', NULL, N'20210401145814', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CONDITION_CODE', NULL, N'상태', NULL, N'Tình trạng', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CONDITION_NAME', NULL, N'상태', NULL, N'Tình trạng', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CONTENT', NULL, N'콘텐츠 관리', NULL, N'QUẢN TRỊ NỘI DUNG', NULL, N'20210326135453', N'H2102001', N'20210326135533', N'H2102001', N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'COST', NULL, N'비용', NULL, N'Đơn giá', NULL, N'20210401145437', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'COST_CTR', NULL, N'Cost center', NULL, N'Cost center', NULL, N'20210401143225', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'COST_CTR(*)', NULL, N'Cost center(*)', NULL, N'Cost center(*)', NULL, N'20210401143225', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'COST_GLACCOUNT', NULL, N'Cost Ctr & Gl Account', NULL, N'Cost Ctr & Gl Account', NULL, N'20210412104652', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CREATE', NULL, N'창조하다', NULL, N'Thêm mới', NULL, N'20210401144539', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'CTG_STOCKIN', NULL, N'카테고리 재고', NULL, N'Danh mục nhập kho', NULL, N'20210402145840', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'DATE', NULL, N'Date', NULL, N'Ngày tạo', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'DATE_STOCKIN', NULL, N'Ngày nhập', NULL, N'Ngày nhập', NULL, N'20210405081837', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'DAY-MONTH', NULL, N'Month', NULL, N'Tháng-Năm', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'DELETE', NULL, N'지우다', NULL, N'Xóa bỏ', NULL, N'20210401143516', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'DELIVERER_RECEIVER', NULL, N'인도자 - 리시버', NULL, N'Người giao/nhận hàng', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'DEPARTMENT', NULL, N'학과', NULL, N'Bộ phận', NULL, N'20210401141145', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'DESC', NULL, N'기술', NULL, N'Ghi chú', NULL, N'20210401143225', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'DESCRIPTION', NULL, N'기술', NULL, N'Mô tả', NULL, N'20210401143225', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'DIFFERENCE_QUANTITY', NULL, N'차', NULL, N'Chênh lệch', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'EQUIPMENT', NULL, N'Thiết bị sử dụng', NULL, N'Thiết bị sử dụng', NULL, N'20210606111111', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'EXCHANGE_RATE', NULL, N'Tỉ giá', NULL, N'Tỉ giá', NULL, N'20210312121640', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'Expired Date', NULL, N'Expired date', NULL, N'Hạn Sử dụng', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'EXPIRED_DATE', NULL, N'Expired date', NULL, N'Expired date', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'FLOOR', NULL, N'바닥', NULL, N'Tầng', NULL, N'20210401143310', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'FORMROLE', NULL, N'규칙', NULL, N'Quyền hạn', NULL, N'20210401140631', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'FROM', NULL, N'에서', NULL, N'Từ', NULL, N'20210401142737', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'GENERATE_CODE', NULL, N'New code', NULL, N'Chương trình tạo mã mới (không có mã từ nhà cung cấp)', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'GL_ACCOUNT', NULL, N'G/L account', NULL, N'G/L account', NULL, N'20210401143225', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'GL_ACCOUNT(*)', NULL, N'G/L account(*)', NULL, N'G/L account(*)', NULL, N'20210401143225', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'GROUP', NULL, N'그룹', NULL, N'Nhóm', NULL, N'20210401143345', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'Has Expired Date', NULL, N'Has Expired Date', NULL, N'Có hạn sử dụng', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'INPUT_COST', NULL, N'입력 비용', NULL, N'Nhập giá', NULL, N'20210405101547', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'INPUT_DATA', NULL, N'입력', NULL, N'Nhập dữ liệu', NULL, N'20210311135252', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'KHO', NULL, N'창고', NULL, N'Kho Hàng', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'LABEL', NULL, N'Label', NULL, N'Label', NULL, N'20210316102227', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'LINE', NULL, N'Line number', NULL, N'Số line làm việc', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'LIST', NULL, N'리스트', NULL, N'Danh sách', NULL, N'20210311135236', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'LOAD_FULL_LOCATION', NULL, N'View full location', NULL, N'Hiển thị đầy đủ vị trí', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'LOCATION', NULL, N'LOCATION', NULL, N'Vị trí', NULL, N'20210316102245', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'LOG-IN', NULL, N'로그인', NULL, N'Đăng nhập', NULL, N'20210310091349', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'LOG-OUT', NULL, N'로그아웃', NULL, N'Đăng xuất', NULL, N'20210310091408', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'LOGDAT001', NULL, N'로그인 이력 로그', NULL, N'Lịch sử đăng nhập', NULL, N'20210309162028', N'H2102001', N'20210310091326', N'H2102001', N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'LOGDAT002', NULL, N'사용자별 화면사용 로그', NULL, N'Lịch sử màn hình', NULL, N'20210309162114', N'H2102001', N'20210310092307', N'H2102001', N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MATERIAL', NULL, N'재료', NULL, N'Chất liệu', NULL, N'20210606111111', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MENUNAME', NULL, N'메뉴', NULL, N'Tên Menu', NULL, N'20210401140454', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MIN_ORDER', NULL, N'Min order', NULL, N'Lượng đặt tối thiểu', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MIN_STOCK', NULL, N'최소 재고', NULL, N'Tồn kho tối thiểu', NULL, N'20210401144514', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MINSTOCK', NULL, N'Min stock', NULL, N'Tồn kho an toàn', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MONTHLY_USING', NULL, N'Monthly using', NULL, N'Mức sử dụng hàng tháng', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_001', NULL, N'저장 되었습니다.', NULL, N'Đã được lưu', NULL, N'20210326135222', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_0016', NULL, N'Vật tư đã xuất hoặc đã hủy', NULL, N'Vật tư đã xuất hoặc đã hủy', NULL, N'20210408083542', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_002', NULL, N'저장 하시겠습니까?', NULL, N'Bạn có muốn lưu không?', NULL, N'20210408113811', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_003', NULL, N'삭제 하시겠습니까?', NULL, N'Đã xóa chưa?', NULL, N'20210408113825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_004', NULL, N'Đã tra xong', NULL, N'Đã tra xong', NULL, N'20210401165819', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_005', NULL, N'재고실사가 종료되었습니다. 프로그램 재시작 합니다.', NULL, N'Đã kết thúc kiểm kê. Hãy bắt đầu lại chương trình', NULL, N'20210408113837', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_006', NULL, N'재고실사가 시작되었습니다. 프로그램 재시작 합니다.', NULL, N'Đã bắt đầu kiểm kê. Hãy bắt đầu lại chương trình', NULL, N'20210408113851', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_007', NULL, N'자재출고 요청 수량은 포장 기준 수량으로 처리 됩니다.', NULL, N'Được sử lý bằng số lượng đóng gói sẳn có và yêu cầu xuất hàng', NULL, N'20210408113903', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_008', NULL, N'Restart 시 투입했던 피더는 자재를 투입 취소하면 함께 취소 됩니다.', NULL, N'Khi Restart, nếu hủy đưa nguyên liệu Feeder đã được đưa vào, sẽ được hủy đồng thời', NULL, N'20210408113914', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_011', NULL, N'삭제 되었습니다.', NULL, N'Đã được xóa', NULL, N'20210408114000', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_012', NULL, N'※구분※\n\r- 7행 까지 성적서 양식\n\r- 8행 부터 성적서 데이터 업로딩', NULL, N'Upload dữ liệu kết quả kiểm tra từ file kết quả kiểm tra\n\r- hàng 8 đến ※phân loại※\n\r- hàng 7', NULL, N'20210408114009', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_015', NULL, N'삭제 하시겠습니까?', NULL, N'Bạn chắc chắn muốn xóa?', NULL, N'20210401165558', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_COM_901', NULL, N'불합격입니다 저장 하시겠습니까?', NULL, N'Xử lý Thất bại.  Có lưu không?', NULL, N'20210408114036', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ER_114', NULL, N'CODE không được để trống', NULL, N'CODE không được để trống', NULL, N'20210408114056', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_001', NULL, N'로그인된 사용자가 없습니다.', NULL, N'Không có người dùng đăng nhập.', NULL, N'20210408114127', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_002', NULL, N'언어를 선택해주세요.', NULL, N'Hãy lựa chọn ngôn ngữ.', NULL, N'20210408114137', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_003', NULL, N'공장을 선택해주세요.', NULL, N'Hãy lựa chọn công đoạn.', NULL, N'20210408114145', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_004', NULL, N'계정을 입력해주세요.', NULL, N'Hãy nhập tài khoản.', NULL, N'20210408114153', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_005', NULL, N'비밀번호를 입력해주세요.', NULL, N'Hãy nhập mật khẩu.', NULL, N'20210408114201', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_006', NULL, N'계정이 존재하지 않습니다.', NULL, N'Tài khoản không tồn tại.', NULL, N'20210408114210', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_007', NULL, N'비밀번호가 틀립니다.', NULL, N'Mật khẩu không đúng.', NULL, N'20210408114221', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_008', NULL, N'접속된 계정정보가 없습니다.', NULL, N'Không có thông tin tài khoản truy cập.', NULL, N'20210408114230', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_009', NULL, N'현재 비밀번호를 입력해주세요.', NULL, N'Nhập mật khẩu hiện tại.', NULL, N'20210408114239', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_010', NULL, N'변경할 비빌번호를 입력해주세요.', NULL, N'Nhập số mật khẩu thay đổi', NULL, N'20210408114251', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_011', NULL, N'변경할 비빌번호를 한번 더 입력해주세요.', NULL, N'Nhập lại một lần nữa mật khẩu đã thay đổi.', NULL, N'20210408114259', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_016', NULL, N'변경할 비빌번호와 확인할 비밀번호가 틀립니다.', NULL, N'Mật khẩu xác nhận không giống nhau.', NULL, N'20210408114308', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_044', NULL, N'Thông tin nhập vào không được để trống.', NULL, N'Thông tin nhập vào không được để trống.', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_102', NULL, N'화면코드가 입력되지 않았습니다.', NULL, N'Mã màn hình chưa được nhập vào\n\r\n\r화면코드가 입력되지 않았습니다.', NULL, N'20210402095348', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_9999', NULL, N'Over 9999', NULL, N'Đã tạo được tối đa cho 9999 mã thiết bị', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_SPARE_CODE_CONTAIN_DOT', NULL, N'the code must not contain characters . and _', NULL, N'Mã không được chứa ký tự chấm . và gạch dưới _', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_ERR_SPARE_TYPE', NULL, N'Hãy chọn phân loại thiết bị', NULL, N'Hãy chọn phân loại thiết bị', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_EXIST_DATA', NULL, N'Exist data !', NULL, N'Đã tồn tại,hãy tạo mã mới!', NULL, N'20210408114308', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_IMPORT_EXCEL', NULL, N'Are you sure want to import data!', NULL, N'Bạn chắc chắn muốn import data !', NULL, N'20210408114308', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_NO_EXIST_DATA', NULL, N'Not found data !', NULL, N'Không tồn tại mã ban đầu,hãy nhập mã khác', NULL, N'20210408114308', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_NO_LOCATION', NULL, N'Choose location', NULL, N'Hãy chọn vị trí xuất', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_NOT_HAVE_LOCATION', NULL, N'Please enter code and location', NULL, N'Vui lòng cung cấp mã sản phẩm và vị trí', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'MSG_QUANTITY_INVALID', NULL, N'Quantity invalid', NULL, N'Số lượng không phù hợp', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'NAME', NULL, N'이름', NULL, N'Tên', NULL, N'20210401143146', N'H2102001', N'20210401143618', N'H2102001', N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'NAME_KR', NULL, N'이름 KR', NULL, N'Tên tiếng khác', NULL, N'20210401144331', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'NAME_VI', NULL, N'이름 VI', NULL, N'Tên tiếng việt', NULL, N'20210401144255', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'NAME_VI(*)', NULL, N'이름 VI(*)', NULL, N'Tên tiếng việt(*)', NULL, N'20210401144255', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'NEW', NULL, N'New', NULL, N'Thêm mới', NULL, N'20210408114308', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'New Delivery', NULL, N'출고', NULL, N'Xuất Kho', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'New Receive', NULL, N'입고', NULL, N'Nhập Kho', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'NON_PRINT_LABEL', NULL, N'비 인쇄 라벨', NULL, N'Không in', NULL, N'20210401145326', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'NOTE', NULL, N'Note', NULL, N'Ghi Chú', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'ORDER_CODE', NULL, N'Order code', NULL, N'Mã đặt hàng', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'PASSWORD', NULL, N'암호', NULL, N'Mật khẩu', NULL, N'20210401145903', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'PASTE', NULL, N'풀', NULL, N'Dán', NULL, N'20210406162923', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'PHONE', NULL, N'전화', NULL, N'SDT', NULL, N'20210401143703', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'PHONE_NUM', NULL, N'전화', NULL, N'SDT', NULL, N'20210401141112', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'PositionNumber', NULL, N'Position Number', NULL, N'Số lượng vị trí trong một ô', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'PRICE', NULL, N'가격', NULL, N'Giá', NULL, N'20210401144755', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'PRICE_US', NULL, N'단가(US)', NULL, N'Đơn giá(US)', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'PRICE_VN', NULL, N'단가(VN)', NULL, N'Đơn giá(VN)', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'PRINT_LABEL', NULL, N'라벨 인쇄', NULL, N'In label', NULL, N'20210401143544', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'QUANTITY', NULL, N'수량', NULL, N'Số lượng', NULL, N'20210401144831', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'QUANTITY_ADD', NULL, N'Add new', NULL, N'Số lượng thêm mới', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'QUANTITY_GET', NULL, N'Quantity', NULL, N'Số lượng cần xuất/nhập', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'QUANTITY_IN_PACK', NULL, N'Quantity in a pack', NULL, N'Số lượng trong pack', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'QUANTITY_IN_STOCK', NULL, N'Quantity in warehouse', NULL, N'Số lượng trong kho', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'QUANTITY_PRINT_LABEL', NULL, N'number of labels to print', NULL, N'number of labels to print', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'QUANTITY_REAL', NULL, N'실제 재고', NULL, N'Tồn kho thực tế', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'QUANTITY_UNIT', NULL, N'단위당 수량', NULL, N'Số lượng trên 1 đơn vị', NULL, N'20210406162756', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'QUANTITY1', NULL, N'Quantity', NULL, N'Số Lượng', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'Rack', NULL, N'Rack name', NULL, N'Tên Rack', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'RACK_CODE', NULL, N'Rack', NULL, N'Rack', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'RackNumber', NULL, N'Rack Number', NULL, N'Số lượng rack cần tạo', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'RATE', NULL, N'율', NULL, N'Tỉ lệ', NULL, N'20210401142841', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'RATE_ALARM', NULL, N'Alarm(%)', NULL, N'Ngưỡng cảnh báo(%)', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'READ', NULL, N'읽다', NULL, N'Chỉ đọc', NULL, N'20210401140853', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'REMAIN_QUANTITY', NULL, N'Remain quantity', NULL, N'Số lượng nhập chưa xếp vào kho', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'REMARKS', NULL, N'비고', NULL, N'Ghi chú', NULL, N'20210401141508', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'REPORT', NULL, N'보고서', NULL, N'BÁO CÁO', NULL, N'20210326135554', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'REPORT_STOCK', NULL, N'Report', NULL, N'Báo cáo kiểm kê', NULL, N'20210401095346', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'REPORT_STOCKIN', NULL, N'Report Stock in', NULL, N'Báo cáo nhập hàng', NULL, N'20210331151223', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'REPRINT_LABEL', NULL, N'In lại Label', NULL, N'In lại Label', NULL, N'20210330163205', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'RETURN_TIME', NULL, N'Time back', NULL, N'Thời gian trả lại', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SAVE', NULL, N'저장', NULL, N'Lưu', NULL, N'20210401143423', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SEARCH', NULL, N'검색', NULL, N'TÌM KIẾM', NULL, N'20210326135628', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SETTING001', NULL, N'용어 마스터', NULL, N'Thuật ngữ', NULL, N'20210309160023', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SIZE', NULL, N'크기', NULL, N'Kích Thước', NULL, N'20210606111111', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SP_CODE', NULL, N'코드 예비 부품', NULL, N'Mã vật tư', NULL, N'20210406163027', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SPARE_PART', NULL, N'Spare part', NULL, N'Vật tư', NULL, N'20210320095653', N'H2102001', N'20210324090647', N'H2102001', N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SPARE_PART_CODE', NULL, N'암호', NULL, N'Mã Thiết Bị', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SPARE_PART_TYPE', NULL, N'유형', NULL, N'Phân Loại', NULL, N'20210606111111', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SPAREPART_INVENTORY', NULL, N'Inventory', NULL, N'Tồn Kho', NULL, N'20210408114308', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SPECIFICATION', NULL, N'세부', NULL, N'Mô tả chi tiết', NULL, N'20210606111111', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SquareNumber', NULL, N'Square Number', NULL, N'Số lượng ô', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'StartPosition', NULL, N'시작 위치', NULL, N'Số thứ tự vị trí bắt đầu', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'STATUS', NULL, N'STATUS', NULL, N'Trạng thái', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'STOCK', NULL, N'스톡', NULL, N'Tồn kho', NULL, N'20210402162435', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'STOCK_CODE', NULL, N'창고', NULL, N'Kho', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'STOCK_IN', NULL, N'Stock in', NULL, N'Nhập kho', NULL, N'20210324100227', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'STOCK_IN_LIST', NULL, N'Danh sách nhập kho', NULL, N'Danh sách nhập kho', NULL, N'20210405081930', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'STOCK_IN_OUT', NULL, N'수출입', NULL, N'Nhập-Xuất Kho', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'STOCK_OUT', NULL, N'STOCK OUT', NULL, N'Xuất kho', NULL, N'20210406163207', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'STOCKIN_CANCEL', NULL, N'Stockin cancel', NULL, N'Hủy nhập', NULL, N'20210326134905', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'STOCKIN_TODAY', NULL, N'오늘의 재고', NULL, N'Nhập kho trong ngày', NULL, N'20210401145638', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SYSTEM', NULL, N'시스템 관리', NULL, N'QUẢN TRỊ HỆ THỐNG', NULL, N'20210326135409', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SYSTEM001', NULL, N'용어 마스터', NULL, N'Thuật ngữ', NULL, N'20210309160147', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SYSTEM002', NULL, N'화면 마스터', NULL, N'Màn hình', NULL, N'20210309160045', N'H2102001', N'20210309164517', N'H2102001', N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SYSTEM003', NULL, N'메뉴 마스터', NULL, N'Menu Master', NULL, N'20210309160112', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SYSTEM004', NULL, N'권한별 메뉴 마스터', NULL, N'Phân quyền menu', NULL, N'20210309160121', N'H2102001', N'20210309164710', N'H2102001', N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SYSTEM005', NULL, N'사용자 마스터', NULL, N'Quản lý tài khoản', NULL, N'20210309160129', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SYSTEM006', NULL, N'권한 마스터', NULL, N'Vai trò', NULL, N'20210309162141', N'H2102001', N'20210312104237', N'H2102001', N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SYSTEM007', NULL, N'공통코드 마스터', NULL, N'Cài Đặt MASTER Chung', NULL, N'20210310090355', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'SYSTEM008', NULL, N'계정별 권한 마스터', NULL, N'Phân quyền', NULL, N'20210310090405', N'H2102001', N'20210312104248', N'H2102001', N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'TIME_IN', NULL, N'Time input', NULL, N'Thời gian nhập kho', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'TO', NULL, N'큰', NULL, N'Đến', NULL, N'20210401142818', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'TYPENAME', NULL, N'Type', NULL, N'Phân Loại', NULL, N'20210607000001', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'UNIT', NULL, N'Unit', NULL, N'Đơn vị', NULL, N'20210315082810', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'UNIT(*)', NULL, N'Unit(*)', NULL, N'Đơn vị(*)', NULL, N'20210315082810', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'UNIT_MIN(*)', NULL, N'Unit(*)', NULL, N'Đơn vị nhỏ nhất(*)', NULL, N'20210315082810', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'UNIT1', NULL, N'Unit', NULL, N'Đơn vị thứ nhất', NULL, N'20210315082810', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'UNIT2', NULL, N'Unit', NULL, N'Đơn vị thứ hai', NULL, N'20210315082810', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'UNIT3', NULL, N'Unit', NULL, N'Đơn vị thứ ba', NULL, N'20210315082810', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'UNIT4', NULL, N'Unit', NULL, N'Đơn vị thứ tư', NULL, N'20210315082810', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'UPDATE', NULL, N'최신 정보', NULL, N'Cập nhật', NULL, N'20210401143730', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'UPDATE CODE', NULL, N'Update sparepart code', NULL, N'Chỉnh sửa mã thiết bị', NULL, N'20210408114308', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'USEFLAG', NULL, N'고르다', NULL, N'Lựa chọn', NULL, N'20210401140426', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'USER_CREATE', NULL, N'User create', NULL, N'Người tạo', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'USER_ID', NULL, N'사용자 ID', NULL, N'Tài khoản', NULL, N'20210401140959', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'USER_NAME', NULL, N'사용자 이름', NULL, N'Tên người dùng', NULL, N'20210401141040', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'USERROLE', NULL, N'사용자 역할', NULL, N'Mã quyền hạn', NULL, N'20210401135653', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'USERROLE_NAME', NULL, N'역할', NULL, N'Quyền hạn', NULL, N'20210401140126', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'USES', NULL, NULL, NULL, N'Công dụng', NULL, N'20210606111111', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'VALID_DATE', NULL, N'데이트', NULL, N'Ngày', NULL, N'20210401145533', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'VALID_MONTH', NULL, N'달', NULL, N'Tháng', NULL, N'20210401142706', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'VENDER_ID', NULL, N'Vendor', NULL, N'Nhà cung cấp', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'VENDER_NAME', NULL, N'공급 업체', NULL, N'Nhà cung cấp', NULL, N'20210607000001', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'VENDOR', NULL, N'공급 업체', NULL, N'Nhà cung cấp', NULL, N'20210319110506', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'VENDOR(*)', NULL, N'공급 업체(*)', NULL, N'Nhà cung cấp(*)', NULL, N'20210319110506', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'VIEW_DATE', NULL, N'날짜보기', NULL, N'Ngày', NULL, N'20210401142047', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'WaitPosition', NULL, N'Wait position', NULL, N'Thiết bị đang chờ xếp vị trí', NULL, N'20210402100007', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'WEIGHT', NULL, N'무게', NULL, N'Trọng Lượng', NULL, N'20210606111111', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'WORKING_A_LINE', NULL, N'working a line', NULL, N'Mức sử dụng hàng ngày cho 1 line', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'WORKING_A_LINE_PACK', NULL, N'working a line(pack)', NULL, N'Mức sử dụng hàng ngày cho 1 line(pack)', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'WORKING_A_MONTH', NULL, N'Monthly ussing', NULL, N'Mức sử dụng hàng tháng', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'WORKING_DAY', NULL, N'working day', NULL, N'Số ngày làm việc', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'WORKING_DAY_NUMBER', NULL, N'working day', NULL, N'Số ngày làm việc', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'WORKING_LINE_NUMBER', NULL, N'working line', NULL, N'Số line làm việc', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTGLA] ([PLANT], [DEPARTMENT], [GLSR], [ENG], [KOR], [CHN], [VTN], [MASTER_FLAG], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [USE_FLAG]) VALUES (N'WHC', N'ALL', N'WRITE_READ', NULL, N'쓰기 읽기', NULL, N'Đọc và Ghi', NULL, N'20210401140825', N'H2102001', NULL, NULL, N'N')
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 1, 0, N'MENU_SYSTEM', NULL, 0, 0, N'Y', N'Y', N'PC', N'N', NULL, NULL, N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 2, 0, N'MENU_CONTENT', NULL, 0, 2, N'Y', N'Y', N'PC', N'N', NULL, NULL, N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 3, 0, N'MENU_REPORT', NULL, 0, 4, N'Y', N'Y', N'PC', N'N', NULL, NULL, N'20200304151617', N'H2002001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 101, 1, N'SYSTEM001', N'SYSTEM001', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'language.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 102, 1, N'SYSTEM002', N'SYSTEM002', 0, 1, N'Y', N'Y', N'PC', N'N', NULL, N'screen.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 104, 1, N'SYSTEM004', N'SYSTEM004', 0, 2, N'Y', N'Y', N'PC', N'N', NULL, N'per-menu.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 105, 1, N'SYSTEM005', N'SYSTEM005', 0, 3, N'Y', N'Y', N'PC', N'N', NULL, N'user.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 106, 1, N'SYSTEM006', N'SYSTEM006', 0, 4, N'Y', N'Y', N'PC', N'N', NULL, N'permission.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 107, 1, N'SYSTEM007', N'SYSTEM007', 0, 5, N'Y', N'N', N'PC', N'N', NULL, N'user.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 108, 1, N'SYSTEM008', N'SYSTEM008', 0, 6, N'Y', N'Y', N'PC', N'N', NULL, N'role.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 121, 1, N'LOGDAT001', N'LOGDAT001', 0, 8, N'Y', N'Y', N'PC', N'N', NULL, N'history.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 122, 1, N'LOGDAT002', N'LOGDAT002', 0, 9, N'Y', N'Y', N'PC', N'N', NULL, N'history.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 151, 3, N'REPORT_STOCKIN', N'REPORT_STOCKIN', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'report.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 152, 3, N'REPORT_STOCK', N'REPORT_STOCK', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'report.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 201, 2, N'EXCHANGE_RATE', N'EXCHANGE_RATE', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'exchange.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 202, 2, N'UNIT', N'UNIT', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'unit.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 203, 2, N'LABEL', N'LABEL', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'label.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 204, 2, N'LOCATION', N'LOCATION', 0, 1, N'Y', N'Y', N'PC', N'N', NULL, N'storage.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 205, 2, N'MAKER', N'MAKER', 0, 2, N'Y', N'Y', N'PC', N'N', NULL, N'supplier.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 206, 2, N'SPARE_PART', N'SPARE_PART', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'sp.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 207, 2, N'STOCK_IN_OUT', N'STOCK_IN', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'packing.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 208, 2, N'STOCKIN_CANCEL', N'STOCKIN_CANCEL', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'cancel-receipt.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 209, 2, N'REPRINT_LABEL', N'REPRINT_LABEL', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'reprint.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 210, 2, N'CTG_STOCKIN', N'CTG_STOCKIN', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'category.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 211, 2, N'BOM', N'BOM', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'reprint.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 212, 2, N'INPUT_COST', N'INPUT_COST', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'input_cost.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 213, 2, N'STOCK_OUT', N'STOCK_OUT', 0, 0, N'Y', N'N', N'PC', N'N', NULL, N'stockout.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 214, 2, N'COST_GLACCOUNT', N'COST_GLACCOUNT', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'stockout.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMEU] ([PLANT], [DEPARTMENT], [MENUSEQ], [UPRSEQ], [MENUNAME], [FORM], [IMGIDX], [DISPSEQ], [DISPFLAG], [USEFLAG], [FORM_GUBUN], [MASTER_FLAG], [REMARKS], [IMAGE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', 215, 2, N'SPAREPART_INVENTORY', N'SPAREPART_INVENTORY', 0, 0, N'Y', N'Y', N'PC', N'N', NULL, N'storage.png', N'20200204151623', N'34499', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 1, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 2, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 3, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 101, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 102, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 104, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 105, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 106, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 107, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 108, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 121, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 122, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 151, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 152, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 201, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 202, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 203, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 204, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 205, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 206, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 207, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 208, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 209, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 210, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 211, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 212, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 213, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 214, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', 215, N'W', N'Y', N'20210412104749', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 1, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 2, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 3, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 101, N'', N'N', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 102, N'', N'N', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 104, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 105, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 106, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 107, N'', N'N', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 108, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 121, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 122, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 151, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 152, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 201, N'R', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 202, N'R', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 203, N'', N'N', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 204, N'R', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 205, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 206, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 207, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 208, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 209, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 210, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 211, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 212, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 213, N'W', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', 215, N'R', N'Y', N'20210408092531', NULL, N'H2102001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 1, N'R', N'Y', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 2, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 3, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 104, N'R', N'Y', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 105, N'R', N'Y', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 108, N'R', N'Y', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 151, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 152, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 201, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 202, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 203, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 204, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 205, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 206, N'R', N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 207, N'W', N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 208, N'W', N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 209, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTMRO] ([PLANT], [DEPARTMENT], [USERROLE], [MENUSEQ], [FORMROLE], [USEFLAG], [CREATE_TIME], [UPDATE_TIME], [CREATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', 215, NULL, N'N', N'20210402093025', NULL, N'h1506001')
GO
INSERT [dbo].[ESYSMSTROL] ([PLANT], [DEPARTMENT], [USERROLE], [USERROLE_NAME], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_ADMIN', N'FOR NORMAL USER', N'Y', N'', N'20200218091011', N'H2002001', N'20200218160728', N'H2002001')
GO
INSERT [dbo].[ESYSMSTROL] ([PLANT], [DEPARTMENT], [USERROLE], [USERROLE_NAME], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_C', N'FOR CREATE USER', N'Y', N' ', N'20200218091011', N'H2002001', N'20200218091011', N'H2002001')
GO
INSERT [dbo].[ESYSMSTROL] ([PLANT], [DEPARTMENT], [USERROLE], [USERROLE_NAME], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_USR_N', N'FOR NORMAL USER', N'Y', N'', N'20200218091011', N'H2002001', N'20200218160742', N'H2002001')
GO
INSERT [dbo].[ESYSMSTROL] ([PLANT], [DEPARTMENT], [USERROLE], [USERROLE_NAME], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'ROLE_VIEW', N'FOR VIEW ONLY', N'Y', N'', N'20200611091011', N'H2002001', N'20201118131423', N'h2002001')
GO
INSERT [dbo].[ESYSMSTROL] ([PLANT], [DEPARTMENT], [USERROLE], [USERROLE_NAME], [USEFLAG], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'SMT', N'ROLE_USR_C', N'MANAGER', N'Y', N'', N'20210323163129', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'ALL', N'H2102001', 1, N'ROLE_ADMIN', N'20210303081758', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'SMT', N'H1506001', 1, N'ROLE_USR_C', N'20210327113849', N'H1506001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'SMT', N'H1506001', 2, N'ROLE_USR_N', N'20210327113849', N'H1506001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'SMT', N'H1702008', 1, N'ROLE_USR_C', N'20210401092734', N'H1506001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'SMT', N'H1702008', 2, N'ROLE_USR_N', N'20210401092734', N'H1506001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'SMT', N'H2102002', 1, N'ROLE_USR_C', N'20210330143033', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'SMT', N'H2105001', 1, N'ROLE_USR_C', N'20210327113849', N'H1506001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'SMT', N'H2105001', 2, N'ROLE_USR_N', N'20210327113849', N'H1506001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'WLP1', N'H1504002', 1, N'ROLE_USR_C', N'20210312120311', N'H2102001', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTURO] ([PLANT], [DEPARTMENT], [USER_ID], [ITEM_NO], [USERROLE], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER]) VALUES (N'WHC', N'WLP1', N'H1504005', 1, N'ROLE_VIEW', N'20210324094322', N'H1504002', NULL, NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'SMT', N'H1506001', N'H1506001', N'Mai Van Tới', N'', N'', N'Y', NULL, N'', N'20210316114954', N'H2102001', NULL, NULL, NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'SMT', N'H1702008', N'H1702008', N'Nguyễn Thị Mỹ Hậu', N'', N'', N'Y', NULL, N'', N'20210327112727', N'H1506001', NULL, NULL, NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'SMT', N'H2102001', N'0', N'DUY', NULL, NULL, N'Y', NULL, NULL, N'2.02002E+13', N'H2102001', NULL, NULL, N'Y')
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'SMT', N'H2102002', N'0', N'DUY2', N'', N'', N'Y', NULL, N'', N'20210311141055', N'H2102001', N'20210312101629', N'H2102001', NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'SMT', N'H2105001', N'H2105001', N'LE VAN DANG', N'', N'', N'Y', NULL, N'', N'20210316114954', N'H2102001', NULL, NULL, NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'SMT', N'OP', N'1234', N'OP', N'', N'', N'Y', NULL, N'', N'20210402092814', N'h1506001', N'20210402092858', N'h1506001', NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'WLP1', N'H1504001', N'0011', N'Nguyen The Huy', N'', N'', N'Y', NULL, N'', N'20210325084753', N'H1504002', NULL, NULL, NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'WLP1', N'H1504002', N'0011', N'Nguyễn Đức Trai', N'', N'', N'Y', NULL, N'', N'20210322162837', N'H2102001', N'20210324094244', N'H1504002', NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'WLP1', N'H1504005', N'0011', N'nda', N'', N'', N'Y', NULL, N'', N'20210324094256', N'H1504002', NULL, NULL, NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'WLP2', N'H2102002', N'0', N'DUY2', N'', N'', N'Y', NULL, N'', N'20210312101633', N'H2102001', NULL, NULL, NULL)
GO
INSERT [dbo].[ESYSMSTUSR] ([PLANT], [DEPARTMENT], [USER_ID], [PASSWORD], [USER_NAME], [PHONE_NUM], [EMAIL], [USEFLAG], [ADDRESS], [REMARKS], [CREATE_TIME], [CREATE_USER], [UPDATE_TIME], [UPDATE_USER], [MASTER_FLAG]) VALUES (N'WHC', N'WLP2', N'H2102003', N'0', N'DUY2', N'', N'', N'Y', NULL, N'', N'20210312101735', N'H2102001', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[EWIP_COST_CTR] ON 
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (1, N'201005', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (2, N'201008', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (3, N'262102', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (4, N'262101', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (5, N'262108', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (6, N'262104', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (7, N'262105', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (8, N'201003', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (9, N'201007', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (10, N'201006', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (11, N'201004', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (12, N'201016', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (13, N'290012', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (14, N'290014', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (15, N'290002', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (16, N'222001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (17, N'221001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (18, N'222101', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (19, N'212102', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (20, N'232001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (21, N'231001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (22, N'232101', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (23, N'212101', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (24, N'262106', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (25, N'262109', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (26, N'201002', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (27, N'262107', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (28, N'262001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (29, N'261001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (30, N'210001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (31, N'220001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (32, N'230001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (33, N'240001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (34, N'250001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (35, N'260001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (36, N'201014', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (37, N'201013', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (38, N'201015', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (39, N'201009', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (40, N'201011', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (41, N'201010', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (42, N'201012', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (43, N'202001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (44, N'202002', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (45, N'202003', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (46, N'202007', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (47, N'202004', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (48, N'202008', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (49, N'290011', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (50, N'290013', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (51, N'290001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (52, N'212001', N'SMT PRODUCTION GROUP', N'1')
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (53, N'211001', N'SMT TECHNOLOGY GROUP', N'1')
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (54, N'201001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (55, N'262103', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (56, N'200001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (57, N'252001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (58, N'251001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (59, N'242001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (60, N'241001', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (61, N'242106', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (62, N'242107', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (63, N'242108', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (64, N'242104', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (65, N'242103', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (66, N'242105', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (67, N'242102', NULL, NULL)
GO
INSERT [dbo].[EWIP_COST_CTR] ([ID], [COST_CTR], [SHORT_TEXT], [DEPT_CODE]) VALUES (68, N'242101', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[EWIP_COST_CTR] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_EXCHANGE_RATE] ON 
GO
INSERT [dbo].[EWIP_EXCHANGE_RATE] ([ID], [VALID_TIME], [FROM], [TO], [RATE], [UPDATED_AT], [CREATED_AT]) VALUES (1, CAST(N'2021-06-06' AS Date), N'USD', N'VN', 23138, CAST(N'2021-06-06' AS Date), CAST(N'2021-06-06' AS Date))
GO
SET IDENTITY_INSERT [dbo].[EWIP_EXCHANGE_RATE] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_FILE_TEMP] ON 
GO
INSERT [dbo].[EWIP_FILE_TEMP] ([ID], [Name], [ContenType], [Data]) VALUES (6, N'EWIP_SPAREPART_LOCATION.xlsx', N'application/vnd.ms-excel', 0x504B0304140006000800000021006E723E89A001000024090000130008025B436F6E74656E745F54797065735D2E786D6C20A2040228A000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CC56C94EC33010BD23F10F91AF2871CB26849AF6C07204A4C207B8F134B19AD8966780F6EF999882102AADA246A29758893DEFBD997896D164D9D4C91B0434CEE662980D4402B670DAD832172FCFF7E995489094D5AA761672B1021493F1F1D1E879E50113B6B6988B8AC85F4B8945058DC2CC79B0BC3377A151C4AFA1945E150B55823C1D0C2E65E12C81A5945A0C311EDDC25CBDD694DC2DF9F3A79299B122B9F93CD752E542795F9B42110B956F56FF2249DD7C6E0AD0AE786D183A431F4069AC00A8A9331F0C33862910B16328E446CE003576235D7B95B165148695F178C2AEFFC1D0EEFCEDD5DAEE917F47301A922715E84135ECBB5CD6F2DD85C5CCB945B61DA46B686288B24619FBA57B0B7F3C8C322EC39E85B4FE45E08E3A4E0F44C7D981E8383F101D17FFA483B806818CCFFDAF6884D9712191563560DF6919417731572A809E1257B7B277013FB177E82035E308C8B8F45D16226807FEBECB4157FEBECB4057FEBED37F273FB7DCA7E03C72570FD03D0BBE5A686B9D7A06824006BE9BE8A666F4CDC823C1DE6907EDCCA1416FE09671C6197F000000FFFF0300504B030414000600080000002100B5553023F40000004C0200000B0008025F72656C732F2E72656C7320A2040228A000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AC924D4FC3300C86EF48FC87C8F7D5DD9010424B774148BB21547E8049DC0FB58DA3241BDDBF271C10541A8303477FBD7EFCCADBDD3C8DEAC821F6E234AC8B12143B23B677AD8697FA7175072A2672964671ACE1C41176D5F5D5F699474A792876BD8F2AABB8A8A14BC9DF2346D3F144B110CF2E571A0913A51C86163D99815AC64D59DE62F8AE01D54253EDAD86B0B737A0EA93CF9B7FD796A6E90D3F88394CECD29915C8736267D9AE7CC86C21F5F91A5553683969B0629E723A22795F646CC0F3449BBF13FD7C2D4E9CC852223412F832CF47C725A0F57F5AB434F1CB9D79C43709C3ABC8F0C9828B1FA8DE010000FFFF0300504B0304140006000800000021003D58807A10010000EE0400001A000801786C2F5F72656C732F776F726B626F6F6B2E786D6C2E72656C7320A2040128A0000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BC94DD6A84301085EF0B7D07C97D8DBA3F2D65E3DE94C2DEB6DB07083A1A594D2433FDF1ED3B08AD1596F446BC094C869CF3E50CC9E1F8D5B5D107786C9C55228D1311812D5CD9D85A89B7F3F3DD838890B42D75EB2C2831008A637E7B73788156131F42D3F418B18A45250C51FF282516063A8DB1EBC172A772BED3C4A5AF65AF8B8BAE416649B297FEAF86C8679AD1A954C29F4AF63F0F3D3BFFAFEDAAAA29E0C915EF1D58BA6221D1680FE52B79BE1EB2B0F6359012B3ED988985BC0EB35912E6D3F90B1A009A407EB79051B9B309C1DC2F9A0C0D2D8F768A64AC43F6D9CA596421987465983404B35F1286F829C13497B194E31A64D8AD1CC82E14C8766598ED0F8C9CFD52F937000000FFFF0300504B030414000600080000002100BCC7BD497D020000650500000F000000786C2F776F726B626F6F6B2E786D6CAC54DB6EDA40107DAFD47FB0F69DF8829D100B3B22E0AA96284189135E90A2C55EE315EB5D7777094455FFBD63BB4E5D90AA54ED03EC6DE6CC9C33331EDF1C4B66BC10A9A8E001B22F2C64109E8A8CF26D801E934F83113294C63CC34C7012A057A2D04DF8F1C3F820E46E23C4CE0000AE0254685DF9A6A9D28294585D888A7078C9852CB186A3DC9AAA920467AA204497CC742CEBD22C31E5A845F0E57B30449ED394CC44BA2F09D72D88240C6B485F15B4521D5A99BE07AEC472B7AF06A9282B80D85046F56B038A8C32F5E32D17126F18D03EDA5E870CDB33E892A6522891EB0B8032DB24CFF8DA9669DB2DE5709C53469E5AD90D5C550B5CD651183218563ACAA82659802EE1280EE4B70BB9AF6EF794C1ABEDBA8E85CCF0AD144B696424C77BA6132842070F86DED0719CDA12484D982692634DA6826BD0F0A7FAFFAA57833D2D0454C7B8275FF75412688A5AB6700CFF38F5F1462DB12E8CBD64019AFAEB4705F4D7B3683E5FCF88DA6951AD7B12E3F3FAFD85C838ADD99A40B74DA9DD9F520FC775033F517250BF44AC8FC6714579260E01827178EDED0FCDF58A66BA0890331A59F0DEDE7D26745B68D0DA71875E13BC87DDF43CC468568337B58E56F1F2F96139B98FE0973CCFEFA69324BE5BC0B4D50312D7F54586F4296C649CD935E41FDCA7778B597CE2EFF4FC9BEA9FF93F2EE2E4A11771D8F3189E468C1F8CD5244EA29EBDDBB3774FED93F84BDF16E6E78D4D2B50A74A8A590AAD5B2F0D6DCFF1EC862F39EAB9D2E11856E81A1AA06FB66B4DAEAC6B776045436FE08EAE9DC1C81D3A83A93B7322EF2A9A45B7DEF7FF3BA8D0BC7EF7ADABB32CB0D489C4E90EBE90F724BFC50A06B749D7843CA1D1BAACCDCE2BFC010000FFFF0300504B03041400060008000000210062D8951D620200005C05000018000000786C2F776F726B7368656574732F7368656574342E786D6C8C54CB6E9C3014DD57EA3F58DE07C324693A0888928946CDA25214F5B136C6803536A6B6E791BFEFB53D4CE7A14AC302309C7BEEF1B9078AC79D9268C38D157A287196A418F181E9460C5D897FFE58DE7CC5C83A3A3454EA8197F8835BFC587DFE546CB559D99E73878061B025EE9D1B73422CEBB9A236D1231FE04DAB8DA20E96A62376349C36A14849324BD32F445131E0C8909B6B3874DB0AC65F345B2B3EB84862B8A40EF4DB5E8C766253EC1A3A45CD6A3DDE30AD46A0A88514EE239062A458FEDA0DDAD05AC2BE77D91D651377585CD02BC18CB6BA7509D09128F472CF733227C05415C1873753158ED60B2DB541A6AB4BBC8423850393AA20074C2360BB7E46C8F0B6C44F59BEB8F58800F825F8D61EDD233F9B5AEB957FF1DA9438F5EDB8E4CCBB84285C367CC1A52CF17306E3FD13389F27CED8D5D74E0A8E1B2CC340DF0C6A784BD7D2BDEBED372EBADE417AEEC120EF53DE7CBC70CB6040D03B99DD7BA54C4BD00867A4844F1A184C77E1BA158DEB4B3C83476C6D9D56BFE3836C5F160B66FB02B84E05F3E4214BE7B70FD0F6B290C486C1A017EA685518BD459031BFE391FAC466F9EDFF0483528F7DF2E012CF31829D58707153A505D9802F6C8F08069E22B253C4E29223BB3F4008A83A4883BD5D2FCD83C1B520AD0ED2CE1A3F1F23A2F8ECEE4C5B8464D959FD892A30E97A551E7CAAEADCB0634454353B5735414EFD8EA2623AE34447DAF1EFD47462B048F236A4ED012313E3982670EFF4E833E833526B07E19A563DFC8A388C384DA05BABB59B169055F822257FA3C659C4F4DAA7D81B74788A4C2EE0AB32AF4D8828F90787601CFE8BD55F000000FFFF0300504B030414000600080000002100521FB1945F0200009405000018000000786C2F776F726B7368656574732F7368656574322E786D6C9454C96EDB3010BD17E83F10BCC7929CAD112405591034870241D0E54C53238930A95149DA4EFEBE432A566C270757079B1C3DBE37CBA38AEB17A3D91AAC53D8973C9BA59C412FB1567D5BF25F3F1F4EBE71E6BCE86BA1B18792BF82E3D7D5D72FC506EDD275009E1143EF4ADE793FE449E2640746B8190ED0D39B06AD119EB6B64DDC6041D4F190D1C93C4D2F122354CF4786DC1EC3814DA324DCA35C19E8FD4862410B4FF9BB4E0D6ECB66E4317446D8E56A38916806A25828ADFC6B24E5CCC8FCB1EDD18A85A6BA5FB23321B7DC71F381DE2869D161E36744978C897EACF92AB94A88A92A621F9E6C5578B1B8438D96D97651F2077A527A785215C984A915951B66C42C3425BFC9F2DBF3808880DF0A366E67CDC26C1688CBF0E2B12E791AE440830C5D6282FED670075A935A16E6FB379286F5241A8E6E13D8E57F88F37CB2AC8646ACB47FC6CD77506DE7C93CE7D49FD0A6BC7EBD0727693E243D9BC744256A4A917E9951C168D45FF152F239671B55FB8E2214922BE7D1FC790BC464C673B1CC7BE1455558DC30720AA1DD2082EFB29C483ED725C180BD09E0925F70460939EAC5BA4A8B644DE5C937C4ED88A05E4C886C42242439E992D6F1BA011C539D58E7E707C223E474477807B2A74C98E39503F840F9407844EC097F5EF1D9FFE806F0BEEEE981EE88D8D57D47ECD54B6E3ABEDE002EF959B04C1C39DD8E1088D61B59C7BB347A68102DFC10B655BD631A9A68D34BCEECE8E374466B8F4330EF25F12CD0932BB7BB8E3E6140A64A67544383E8B71B92A69BACE14958EF98C455B07F466E9BA2CCE68A6EA37DACB3E8ED77385971FA9E56FF000000FFFF0300504B03041400060008000000210041BFF860D9000000CA01000023000000786C2F776F726B7368656574732F5F72656C732F7368656574312E786D6C2E72656C73AC91C14EC3300C40EF48FC43E43B49BB034268E92E086957181FE0A56E1BD13A516C10FB7B8276A1D3242E9C2CDBF2F393BDDD7D2DB3F9A42231B187D636608843EA238F1EDE0ECF770F6044917B9C1393871309ECBADB9BED0BCDA87548A698C5540A8B8749353F3A2761A205C5A64C5C3B432A0B6A4DCBE83286771CC96D9AE6DE95DF0CE8564CB3EF3D947DBF017338E5BAF96F761A8618E829858F8558AFAC708AC7992A10CB48EAC1DA7345CEA1B55516DC758FF63F3D7289AC545E49B51E5A5646173D7791B7F618F947D2AD3ED07D030000FFFF0300504B0304140006000800000021008035EB58BC0000002501000023000000786C2F776F726B7368656574732F5F72656C732F7368656574322E786D6C2E72656C73848FC10AC2301044EF82FF10F66ED27A1091A6BD88D0ABE807ACE9B60DB649C846D1BF37E04541F034EC0EFB66A76A1EF324EE14D97AA7A194050872C677D60D1ACEA7C36A0B8213BA0E27EF48C393189A7AB9A88E3461CA473CDAC022531C6B18530A3BA5D88C34234B1FC865A7F771C694C738A880E68A03A975516C54FC6440FDC5146DA721B65D09E2F40C39F93FDBF7BD35B4F7E636934B3F2254C2CB44198871A0A441CAF786DFB296F9595075A5BECAD52F000000FFFF0300504B030414000600080000002100A750CED9BC0000002501000023000000786C2F776F726B7368656574732F5F72656C732F7368656574332E786D6C2E72656C73848FCD0AC2301084EF82EF10F66ED22A8848D35E44F02AF501D674FB836D12B251F4ED0DF4A220781A7687FD66A7A89ED3281E14787056432E3310648D6B06DB69B8D4C7D50E0447B40D8ECE9286173154E572519C69C4988EB81F3C8B44B1ACA18FD1EF9562D3D3842C9D279B9CD68509631A43A73C9A1B76A4D659B655E19301E517539C1A0DE1D4E420EA974FC9FFD9AE6D07430767EE13D9F8234245BC8E9480183A8A1AA49C373CCB46A667419585FA2A57BE010000FFFF0300504B030414000600080000002100D067D6E8BC0000002501000023000000786C2F776F726B7368656574732F5F72656C732F7368656574342E786D6C2E72656C73848FCD0AC2301084EF82EF10F66ED28A8848D35E44F02AF501D674FB836D12B251F4ED0DF4A220781A7687FD66A7A89ED3281E14787056432E3310648D6B06DB69B8D4C7D50E0447B40D8ECE9286173154E572519C69C4988EB81F3C8B44B1ACA18FD1EF9562D3D3842C9D279B9CD68509631A43A73C9A1B76A4D659B655E19301E517539C1A0DE1D4E420EA974FC9FFD9AE6D07430767EE13D9F8234245BC8E9480183A8A1AA49C373CCB46A667419585FA2A57BE010000FFFF0300504B0304140006000800000021003C78BDFC68030000310C000018000000786C2F776F726B7368656574732F7368656574332E786D6C94964B8FDA301485F795FA1F2CEF8724CC1344180D45A3CEA2D2A8EA636D1203D124716A1B98F9F7BDD7C6711C5A2961014938399F9FC777F1F85E95E4C8A52A449DD2641253C2EB4CE445BD4BE9CF1FCF570F9428CDEA9C95A2E629FDE08A3E2E3F7F5A9C847C537BCE3501875AA574AF75338F2295ED79C5D44434BC867FB642564CC3ADDC45AA919CE5E6A5AA8CA6717C1755ACA8A97598CB211E62BB2D32BE16D9A1E2B5B62692974C43FBD5BE689473ABB2217615936F87E62A135503169BA22CF48731A5A4CAE62FBB5A48B629A1DFEFC90DCB9CB7B9B9B0AF8A4C0A25B67A0276916DE8659F67D12C02A7E5C28CC3AB5C2E34DB7C11A59044EE36297D864F0C1F1A2D1751ABC90BE82ECE11917C9BD2A764BE9A2628318A5F053FA9CE35C1C9D908F1867FBCE4298D91C74B9EE13011063F47FE8597654AD7C90D4CF01FE38AD72D155F752DE8FA3F9B097D9524E75B7628F57771FACA8BDD5EC3EAB98501C2719AE71F6BAE329820404FA6B7E89A89129A08DFA42A70A5C100B3F7944E293915B9DEC31378941D9416D5EFF303D318FB9EE9E69A69B65C487122B05440AD1A860B2F9983C9BFB90044ED138A537A47093448C1581C97F1223A42F7B2B3626515B0D85B45D22A2240B65C600DE7A2D834B575BDE971ADE2BAC3F58A800B92E15C1487DCDB1ED72ABA5CAF08B8B83C068F338A43EE5D8F6B155DAE57045C584BC3B9280EB9F73DAE5574B95E117061910CE7A238E43EF4B856D1E57A45C0BD1FC34571C89DF5B856D1E57A45C0C57C1F3CBF280EB9497F23594917DC9104E4D918328A7B64BF41CD265F594940FECF1E4EE0941B111EA8EEB1A7FDF8B09A00EE3541B731E746C06D30C1B70FA6EB3EDC6A02B8D784F051F1955CE6D7B4BFA1CF9A2EBCA309E1A3322C7121868707A6F8EAFCE4DA9C0BDD4C3667D8F0C3C0A5943776A984A75F603C2A85F0FC330BC51BBBD8B9301E153389CB196FEC72E5C278548E242E48BCB10B8E0BE3514191B8A4F0C62E182E8C47E540E282C01BBB7DDF379E8EDAE5468DBBBC353E3FB95C6E50798DA901ECEE34A5955DC7E6FD949AB2C82E375BE8D9FAA6613BFE8DC95D512B52F2AD29A16052A4ADB1E2095C6BD16061750FAB6B2334544CEE6E0FF53587AD124F60F36C85D0EE063A056566C95F99D48A64E280A559029550FB94C8790195A27CC9CD10445E0E7BA22DF6977F010000FFFF0300504B03041400060008000000210037FB3B2E440300002E09000018000000786C2F776F726B7368656574732F7368656574312E786D6C8C96CB6EE2301486F723CD3B58DE0FB900A54584AA2D65DAC548D5742E6BE318B09AC419DB94B64F3FBF9D844B40940D26CE772EFE8FED93D1F55B9E9157A18D544542A34E488928B84A65B148E8EF5FD36F979418CB8A9465AA10097D17865E8FBF7E19AD957E314B212C8187C22474696D390C02C3972267A6A34A51E0CD5CE99C593CEA45604A2D58EA8DF22C88C3F022C8992C68E561A8CFF1A1E673C9C544F1552E0A5B39D1226316F99BA52C4DE32DE7E7B8CB997E5995DFB8CA4BB898C94CDA77EF94929C0F1F1785D26C9661DD6F518FF1C6B77F38709F4BAE955173DB81BBA04AF470CD57C155004FE391D7E1498F4796CDEE54A634D18B5942A7D330BC0DFB210DC6A360C3A412CB7535225ACC137A130D1FBA8EF0C01F29D666E73F81C76791096E458A9A52E26A3553EAC5818F980A5D780F388F8C5BF92AEE449625F43E8A51EF7F3E88FBBF49C2993609EDC69BFAFA3E69928A395B65F6A75A3F08B9585A04EE432F27DB307D9F08C3512F84EEC47DE795AB0C29E397E4D26D3CE8CDDEAA64656A97098DFB9DA8175E80267C65ACCAFF56F3516D5DD9215B6F87715DDBC59D5EDC1F5C469F58766B4B8C8D65D81944E15577703A64AF36C4D81876CF32845B9F2BC6C610CB3EB1B88BDA00E336C5334419D47618CF0B8433EE33C3789E8A41553EBFFB26CCB2F148AB35C101C6824CC9DC75100DE1ED78F95177C7DE3838A1581DF685C1967C1D4717A3E015DB8CD7C86D8560215B64B08FDC1D412EF791C911E46A1FB93F44E2701F991E41A27DE4FB11A495CBC311649B4B0019375ABA9378B6960EF6F26F848A5B42DDD6086EF82D13B7C4AC18FC6E917E4BCC5D64E6ABD612EABE215C45BB2D110F03F45A1AD669E2786D72E8B6747EA8199CDD2DB3CD624F4530E7ABE8E04F54AC913D155B8BBCAB98932AEE22C7556C88632A1E0668AB58A77952C59A39A962D582AA335EB285F8C1F44216866462EE6F731C4D5D5DF7B83D510E55BA3BDE5DA13365716B374F4B747E81431F76106EAE946D1ED00B9CDF67615725295929F4B3FC40C385C04A4BF40CDFDA135A2A6D3593969225E63F145E64935226B41B02C5178C957C77460F253A9D7E4C7DC34047CCC413D3D610AE56AE1145D8BA9B59B2A1AB96B7C571196DBE74C6FF010000FFFF0300504B03041400060008000000210015F41B425D020000B405000018000000786C2F776F726B7368656574732F7368656574352E786D6C9454D98EDB20147DAFD47F40BC8FF192D58A339A496634F350A9AABA3C138C6314635C20DBDFF762E2244DD2367D3160CE3D3EE72E9E3CEE6485365C1BA1EA0C47418811AF99CA45BDCCF0B7AFAF0F238C8CA5754E2B55F30CEFB9C18FD38F1F265BA557A6E4DC2260A84D864B6B9B9410C34A2EA90954C36BB8299496D4C2512F896934A7791B242B1287E180482A6AEC19527D0F872A0AC1F85CB1B5E4B5F5249A57D4827E538AC6746C92DD4327A95EAD9B07A66403140B5109BB6F4931922C7D5FD64AD34505BE77518FB28EBB3D5CD14BC1B432AAB001D0112FF4DAF3988C09304D27B900072EED48F322C34F49FA32C2643A69F3F35DF0AD39DB2397EE85522B77F19E67380406C32BCE9C714461D9F019AFAA0CBF454328D9CF96D4ED81921C39CFF71DFF6B5BA2CF1AE5BCA0EBCA7E51DB372E96A5857EE88365E73CCDF7736E18A41C3E1DC47DC7CA540514F04452B8DE8194D15DBB6E456ECB0CC771D08BFBC3510478C4D6C62AF9C3DF4487781F191F22613D4426FD20EA85837FC425873858BB2F8EFF1247BCE03617736AE974A2D51641D741BC69A8EBE128FDA36170EAB04F0E9CE1314690090345D84CA309D9405ED901F17C03D1FF1D32BB8624F1114240D6515BEF7FB43930A4FD4C5B3CBA10E721912F8033343BBC01E34747C985A517C09C2E07B79502C1FD5974E00BA5E30BA51DC4755A2BD4BF88CEED25C96D2DEEA7756F459F017C32D7BBA8946382BE189C634ED5F4A5F2E3E55BAAA14BFE89EAA5A80DAA78D18E0BCCA3F6F31406B0B7AA714334043F0B656128BA53097F470E250903E88F4229DB1DDC081FFFB7D35F000000FFFF0300504B0304140006000800000021008B826E58930600008E1A000013000000786C2F7468656D652F7468656D65312E786D6CEC59CF8B1B3714BE17FA3F0C7377FC6B666C2FF1067B6C67DBEC2621EBA4E4A8B5658FB29A9119C9BB3121509263A1509A965E0ABDF550DA0612E825FD6BB64D6953C8BFD027CDD823ADE56E9A6E202D59C332A3F9F4F4E9BD37DF9334172FDD8DA97384534E58D276AB172AAE8393111B9364DA766F0E07A5A6EB70819231A22CC16D7781B97B69FBFDF72EA22D11E1183BD03FE15BA8ED4642CCB6CA653E8266C42FB0194EE0D984A53112709B4ECBE3141D83DD98966B954A508E11495C27413198BD369990117686D2A4BBBD34DEA7709B082E1B4634DD97A6B1D14361C7875589E00B1ED2D43942B4EDC23863763CC47785EB50C4053C68BB15F5E796B72F96D156DE898A0D7DB57E03F597F7CB3B8C0F6B6ACC747AB01AD4F37C2FE8ACEC2B0015EBB87EA31FF483953D0540A311CC34E3A2DBF4BBAD6ECFCFB11A28BBB4D8EE357AF5AA81D7ECD7D738777CF933F00A94D9F7D6F08341085E34F00A94E17D8B4F1AB5D033F00A94E183357CA3D2E9790D03AF401125C9E11ABAE207F57039DB1564C2E88E15DEF2BD41A3961B2F50900DABEC92434C582236E55A8CEEB074000009A44890C4118B199EA01164718828394889B34BA61124DE0C258C4373A5561954EAF05FFE3C75A53C82B630D27A4B5EC084AF35493E0E1FA56426DAEE8760D5D5202F9F7DFFF2D913E7E5B3C7270F9E9E3CF8E9E4E1C393073F66B68C8E3B2899EA1D5F7CFBD99F5F7FECFCF1E49B178FBEB0E3B98EFFF5874F7EF9F9733B10265B78E1F9978F7F7BFAF8F9579FFEFEDD230BBC93A2031D3E2431E6CE557CECDC6031CC4D79C1648E0FD27FD663182162F44011D8B698EE8BC8005E5D206AC375B1E9BC5B29088C0D78797EC7E0BA1FA573412C235F896203B8C718EDB2D4EA802B722CCDC3C37932B50F9ECE75DC0D848E6C6387283142DB9FCF405989CD64186183E6758A1281A638C1C291CFD821C696D9DD26C4F0EB1E19A58CB389706E13A78B88D5254372602452D16987C41097858D2084DAF0CDDE2DA7CBA86DD63D7C6422E18540D4427E88A9E1C6CB682E506C33394431D51DBE8B446423B9BF48473AAECF05447A8A2973FA63CCB9ADCFB514E6AB05FD0A888B3DEC7B74119BC85490439BCD5DC4988EECB1C33042F1CCCA9924918EFD801F428A22E73A1336F81E33DF10790F7140C9C670DF22D808F7D94270137455A75424887C324F2DB1BC8C99F93E2EE80461A53220FB869AC7243953DA4F89BAFF4ED4B3AA745AD43B29B1BE5A3BA7A47C13EE3F28E03D344FAE637867D60BD83BFD7EA7DFEEFF5EBF37BDCBE7AFDA8550838617AB75B5768F372EDD2784D27DB1A07897ABD53B87F2341E40A3DA56A8BDE56A2B378BE032DF2818B8698A541F2765E22322A2FD08CD60895F551BD129CF4D4FB933631C56FEAA596D89F129DB6AFF308FF7D838DBB156AB72779A890747A268AFF8AB76D86D880C1D348A5DD8CABCDAD74ED56E794940F6FD2724B4C14C12750B89C6B211A2F07724D4CCCE8545CBC2A229CD2F43B58CE2CA15406D1515583F39B0EA6ABBBE979D04C0A60A513C9671CA0E0596D195C139D7486F7226D533001613CB0C2822DD925C374E4FCE2E4BB55788B441424B3793849686111AE33C3BF5A393F38C75AB08A9414FBA62F93614341ACD37116B2922A7B48126BA52D0C4396EBB41DD87D3B1119AB5DD09ECFCE1329E41EE70B9EE45740AC7672391662FFCEB28CB2CE5A2877894395C894EA606311138752889DBAE9CFE2A1B68A2344471ABD64010DE5A722D9095B78D1C04DD0C329E4CF048E861D75AA4A7B35B50F84C2BAC4F55F7D707CB9E6C0EE1DE8FC6C7CE019DA73710A498DFA84A078E098703A06AE6CD318113CD959015F977AA30E5B2AB1F29AA1CCADA119D4528AF28BA98677025A22B3AEA6EE503ED2E9F333874DD8507535960FF75D53DBB544BCF69A259D44C435564D5B48BE99B2BF21AABA2881AAC32E956DB065E685D6BA97590A8D62A7146D57D8582A0512B0633A849C6EB322C353B6F35A99DE38240F344B0C16FAB1A61F5C4EB567EE8773A6B658158AE2B55E2AB4F1FFAD709767007C4A307E7C0732AB80A257C7B48112CFAB293E44C36E015B92BF235225C39F394B4DD7B15BFE385353F2C559A7EBFE4D5BD4AA9E977EAA58EEFD7AB7DBF5AE9756BF7A1B08828AEFAD96797019C47D145FEF145B5AF7D808997476E17462C2E33F581A5AC88AB0F30D5DAE60F300E01D1B917D406AD7AAB1B945AF5CEA0E4F5BACD522B0CBAA55E10367A835EE8375B83FBAE73A4C05EA71E7A41BF590AAA6158F2828AA4DF6C951A5EADD6F11A9D66DFEBDCCF973130F34C3E725F807B15AFEDBF000000FFFF0300504B03041400060008000000210015E8CB8BF0040000662D00000D000000786C2F7374796C65732E786D6CEC5A5F6FE238107F3F69BF4394F734092494A084D502E5B4D2DE6AA576A57B358903D63A3197981EECE9BEFB8D9D0402A525610B856B1EDA24C61EFF3C1ECF3F8FFB711951E511272961B1A79A3786AAE0D8670189A79EFAFD61AC755525E5280E106531F6D4154ED58FFD0FBFB9295F517C3FC3982B40224E3D75C6F9BCA7EBA93FC3114A6FD81CC7F04BC8920871F84CA67A3A4F300A523128A27ACB303A7A8448AC66147A915F854884921F8BB9E6B3688E3899104AF84AD25295C8EF7D9EC62C41130A5097A685FC82B6FC78423E227EC25216F21B20A7B330243E7E8AD2D11D1D28F5DD90C53C557CB68839F00A488B197A3F62F6773C163F89C6AC57DF4D7F2A8F88428BA9EA7DD76794250A07CE0030D912A308673D868892494244B7104584AEB2E6966890CCCCFB450496261A7581237FA4308850BA46D51600A0A1EF0277384EE2317C28F9FBC36A0ED3C7B0911919D9EF40EF69825666CBAE3E2065940402C574585EB4AD2A9C08BE19376DC7716E6DBB6B9B4ECB823FC98F49DE9DC4015EE2C0533B969CB3B40CB16409593E60E513960420BAC58E38306BD6D477290E39B02A21D39978723687FF13C639EC73DF0D089AB21851C1CC62447924883C48B7A7F2194867B17BBBC8C414F90C95FA4B2C124AA5EE00B9405CA97FB6B8C36B2BB85213F39A7DAF0AE6C48CBE0CD03BF27709BBF9A6125877D333FE5DE3A1A98BF904AAE938E63D03245796A07A7D4CE9BD50927F86258BD87797A1122FA271C43F830A07674298AAE2157477FE9AE9DAEC43E8E032B58C7699EC2DA8E0FA749565B89EA0EE683056C56805CDE7743590962637DD75A9094F21C7F20AD43AAF4AEDF655A981B3F86B2B6DA9CA4636E0639B9AF065A4E375D49E6CD16E9F90B67542DA70A4F6F3048ED1965C5ACEE1C3F74430BF2EA2094EC6D2653F9ED18071B3894F18FDFC5132817187F4C5392097E7F86BC138FE96E0902CAB30A4EE12F6923FF12ED45C522525BE11CA1DEA8576077D5E321A5B2663ADFC15111379EA57217EB424E79305A1103BEC31174033586E0C50AB0B96021A8A304029FCFCEF73698C8ACF11046CA2210B13AED9D987C89D135F06323396909F606DB7A31A5DB2A3E14939D22BF124F355765D1691B118B20064F1771CE3048451061222D86C44CA7DC7225549551467B2EF6E8E64A5819BEEA5B444C3ED97B3300DB7F344D9B1F9A282816F2BDB07B290BB49C59D5C5C913CCC13AC87728DFADEA4E2792CE519921997B1A3590850CD5E1E99933C694AE892B858336BBCCE69BF43E3F1FCDA8FCAA6EF23F7F6BAAADAD952D88253226EEDCE14EAACD3EDCF78DB7554C20526891BBD5ABE98BB6E7FA3B8ED835554B7228D5E4D2032D9F5931ABDCACF758DF9067AB5E635F1BB71C99A445059133479B475C14A5187717DDEC2FF21117E3D19BA26E64550A5F652B8D6F866072AD00A55D3C4BCB4B8D2BBA4985778CA7043C94539AAAC95595F7BC29D6A8043B4A0FC61FDA3A76EDEFFC001594450B090F7FA461E1997243C75F3FE4514379A1D71398597FC4B0AD588F0541609F1D47FEE06B7CEE86EDCD2BAC6A0AB596D6C6B8E3D1869B6351C8C4663C76819C37F4BD5B1BF501B2B6B78A1FCC0B47A29850ADA245F6C0EFE7ED3E6A9A58F0CBE2CF204D865EC4EAB637CB24D431BB70D53B33AA8AB753B6D5B1BDB666BD4B10677F6D82E61B78FC36E1ABA696605C802BCDDE324C2225FB20DFFA1DC0A9B049F2F2C422F7642DF1448F7FF030000FFFF0300504B0304140006000800000021002C64744BFF0100009304000014000000786C2F736861726564537472696E67732E786D6C8454416BDB3018BD0FF61F3E74E9C9B5E342B316C7254BDC5196D425F5BAED281CCD12B3652F52427B6B4E3DEC92FD8041436F83C260854173D8C12127FF09FF93290B6343CA98C1C67ADFD3F37BDF67E41D5D66294CC848B09CB75063D74140789C0F194F5AE855746C3D432024E6439CE69CB4D01511E8C87FFAC4134282DACB450B51298B43DB1631251916BB7941B8AABCCB4719966A394A6C518C081E0A4A88CC52DB759C7D3BC38C2388F331972DB4DF4430E6ECC3987436C05E13F99E60BE27FD4ED80D3C5BFA9EBD5E6FB0D376DFC45E18ACE0B50E9DB53B2F756C10043D937732D0B1E7E11B1D0ADA26298A7A86B77E1005865EEF24DA62CF7017F60C77CB19E609C47435AFAEE1B2FC524D0B98B0EA0EE48855535DE102A763A2839D7C686017FF94885875CDA992C7D51D4F74AD680383A4B89A32587EFAE34EA79E970FD514D2D557657D8BD272B69AF35F51F48D6EC3721ADB40D748567E8349BDF8A8DC96F77A3134A65FC4C25038B31CC771AD2838372614D17AF19941C230075A3FFE90EBE79C1B2DF98BC615E3BE80F73437FC3BEB584D6BCF31931D1CA8C05B3227AC9CAB68EB8059FDF83D56ED56EF9CEA0AA749797B0594D58B1B0E5279643AE3381CF4DBD1A10EBF5597D5EF5BDDAE5E59CED407A5CABEDD01A4E52DECB88DDFCE775464A6EEF261FDB3AAA9C8FFF5CE56878AFF130000FFFF0300504B030414000600080000002100164AB4BE390100003102000014000000786C2F7461626C65732F7461626C65332E786D6C6451CB6EC23010BC57EA3F58BE97841C5A8A48108F2221B5542AF403B664432CF911D94B81BFEF9A504AD4A367676766C7A3F1D168F18D3E286773D9EFA552A0DDBA52D95D2E3F378B87811481C096A09DC55C9E30C871717F3722F8D22878DB865CD644CD3049C2B64603A1E71AB43CA99C3740FCF4BB24341EA10C3522199D6469FA981850560A55B2AD14160CAB6FA228BF4A151A0DA75507F458E572D21F4E33669023D0E1C31DD6B53B7072CE5DB3017A86E6C76A1955B31B6CEA3C0F7F2751205A7551D6B8CA7626CFB218C19EDC4269422F6E832445DBC4CCE9BDB1416CDDDE522E33DE383BB478F7CAD9FBFC856F04824B9E81ECCA9CE99CBE2D653579EBD29F223DB9910F17B3359D342E6DE544E05616CA076AFDCFFD44EC15FE41B143F2AA41FE47EE25B2DAA52B9AFEF9153F000000FFFF0300504B0304140006000800000021006C71BE1108010000D906000027000000786C2F7072696E74657253657474696E67732F7072696E74657253657474696E6773312E62696EEC54CD6AC24010FE36DD5E0AD257C821875E8415425E20511052592405D963D928015131E0457C13F17D7C873E4A359D6928141B24F5E796819DD9BFF966F71BF80C22A4C891618219CD96706190C047070A6D04E4152C1674834F34628A2F0831079B90901F383CB6E6128296477C7280C4C81114D9036F54A1C4B614C784C5B5EC37423DC728FF353D1CE89F1C89A2B800A2496918B81B037BB408BB776C28BE8E01561C2671E49483D17EEBC533AD654589A78A3D82F8630F573688DF726EDCAAFFA71A59A599DBA2AE0EAEBD7AEFF236A77CDFEA3F2BEA9AC6CE31519A679359BA744DE277543B50CA2E32D7E8B8AC2490E8D721701016837ED88DDFA781FF050000FFFF0300504B030414000600080000002100797693AFD2010000AC03000014000000786C2F7461626C65732F7461626C65312E786D6C6C53CD6ED34010BE23F10EA3BD53C76929A58A5341514425C481B4DC8778E35DB19EB576376D736BDE001E8043D43312074EF4C0812A27BF44DF84B1DD149BFA6269BF99EF9BBFCFA3A3CBDCC0B9745E5B4A44BC3310206966534D5922CE4E27CF0E04F88094A2B12413B1945E1C8D9F3E1905FC6424309B7C225408C56114F9999239FA1D5B48E2C8DCBA1C033F5D16F9C2494CBD9232E4261A0E06FB518E9A04E83411BB020873563FAD44F9956A5F185CBEEF804ECE13F12A3E7CCB09C10634FE83BD982A7BC18D73DB8AF5A563E8CDE5FC8445872F5AD86BEB38B88DECB34055A98B3E6FC976237B623CC245B0136D8274D06A241A378B38B666919387995D5048C40113EA0A0D5E0F196F873CB6A9E41131E0B69F5DD1D5A9F387DBFC8FBABC86E074B9EAB2867DAC7FABD4E51529E661794D599719F731F71E8ED05020282C571A6EBF226530539B7579D59519F4C9F0169B5B4EFFFC2C5760363F98F87F07F1CB3E2A5BADA1DE7ED9AC09CE79EE6EC13E12DFF2DE3BEAEEE69B864C2381BAFBF53B54DF353BACB5E9DEC1D9278F1588C9DF0BF8AC6C47A01E396A9DD6DF1F7A1A96469ED0DC8267474EB4F3A1B97DEDCD0A7B878FA0CABF7CD842F22FC4F6A8B21AD203DAAA37FE0B0000FFFF0300504B0304140006000800000021001C207FF1BB010000A403000010000801646F6350726F70732F6170702E786D6C20A2040128A00001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009C93516BDB301485DF07FB0F46EF8DDC761923C82AC1C9A8A14DCCEC348F4595AF63515932926A92FDFAC93175ED2EEC610F82AB7B0E874FD215B93BD63268C158A15584AE67210A40715D087588D02EFF79F50305D6315530A91544E80416DDD1AF5F486A7403C609B0818F5036429573CD0263CB2BA8999D795979A5D4A666CE6FCD01EBB2141C569ABFD5A01CBE09C3EF188E0E5401C5553304A23E71D1BAFF0D2D34EFF8EC537E6A3C3025CBA6918233E74F491F0537DAEAD205EB230749F058249E2E03FE66843BD190E0F196649C49887D302D99B440F04783DC03EB2E2D65C2584A5AB768813B6D022B7EFB6BBB41C10BB3D0E144A8654630E53C5667EB37E75A36D619BAD7E6D55600CE12EC0D7DF35C8EBDE35A7CA3F3B3C117536317D08378618A980B27C16ECB94197781783E263E33F4BC3DCE7A9FA4CF59BAFCB5F62B7F7ED8C6CB3CD96EC6C003FA276FBCDDAC927F9B779B24CF2E662559B05F26F9FAA298278F136172F84FC78D75DD3075F2B732540F42BDDA5D93EB1573F0FEC2D326C92A66A0F043314CC0D020F7FE718DEC42E28AA90314EF9EBF856E1E9FFA4F47AFE7B3F036F4A336EA11FCF1BDE81F000000FFFF0300504B030414000600080000002100AEB5DF37450100005902000011000801646F6350726F70732F636F72652E786D6C20A2040128A000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000084925F4F833014C5DF4DFC0EA4EF500A2ADA004B74EE694B4CC4687C6BDABB8D480B69AB6CDFDEF2678899898FBDE7DCDF3DF7A6E9E2202BEF0BB4296B95211284C803C56B51AA5D865E8A957F8B3C639912ACAA1564E808062DF2CB8B943794D71A9E74DD80B62518CF9194A1BCC9D0DEDA86626CF81E2433817328276E6B2D99754FBDC30DE31F6C07380AC31B2CC132C12CC31DD06F26221A91824FC8E653573D40700C154850D6601210FCE3B5A0A5F9B3A157664E59DA63E3761AE3CED9820FE2E43E987232B66D1BB4711FC3E527F86DB37EEE57F54BD5DD8A03CA53C129D7C06CADF3E5E37A9DE259A13B5EC58CDDB83B6F4B10F7C7D1735E779C3EF60003E1B92074887D525EE38765B142791446C40F6F7C121721A15142C9D57B37F6577F176C28C871F8BFC4C42749115E5392D0F86E463C01F2149F7D86FC1B0000FFFF0300504B030414000600080000002100448F8762330100001502000014000000786C2F7461626C65732F7461626C65342E786D6C6C91414FC2401085EF26FE87CDDCA5059418424B084842A298287A1FE9946EB2DD6D76A702FFDE2945A5D1E3BE7DF3F67BB393E9A134EA937CD0CE26D0EFC5A0C86E5DA6ED2E81B7CDF2E61E5460B4191A672981230598A6D75713C60F434AA66D48A060AEC65114B60595187AAE222B37B9F325B21CFD2E0A9527CC4241C4A58906713C8A4AD41694CE121880B2584AFAA6099553A64365F0B8EE889EF20466FDF17C088A1DA3092F6EFF5AB8BD800B7621F9E4455A1CF295848E209D60CD6EA90D935717D351DAD2CF9DA94B1BD4D6D5961318CAC0A955AB9FC8FADF64F3E7C5837021E339FE0EBA31DD22EBD953D77EFB9F5D8AB4BDDFD1D4D4891F36FEE802279CE15EF968686573A782545F6A1FB8E53D2DA1D11EF18FD42C8ABDAE48FE4A2A35AE76E8478D7FDF4BBF000000FFFF0300504B030414000600080000002100A028E8913E0100003202000014000000786C2F7461626C65732F7461626C65322E786D6C64515D4FC240107C37F13F5CF65DDA22A031B4840F49481413C11F70D22DBDE47AD7DC2D02FFDE6D6B91EAE3CDCECECCCE8D27A7428B2F745E591343D40B41A0D9D954997D0C1FDBE5DD23084FD2A4525B83319CD1C324B9BD1993FCD42878DBF81872A2F22908FC2EC742FA9E2DD1F024B3AE90C44FB70F7CE950A63E47A44207FD301C05855406844A63188030B260F56D25CAAF54F952CBF3BA033ACC6298464FB32108B224B57FB7C74D6E8F1C9C63E7AC8F8EA1C5295BB168C4C92FD8CC3A1EB6930716A89CBAE8E84AB63B1942329607B24BA5099DB80A12244D1173AB0F85F162670F8662E8F342EDD0E0F591517BE4FC6DF1CC274A926D9E0174756A7EBFE5AFA7AF7FF8F7153FB832F03F761B3A6B5C99CC0ACFBD2C95F3D424A81BAAB017F90FAA5A24A74AE48FE49015AB59BAA0E1AF5FF20D0000FFFF0300504B01022D00140006000800000021006E723E89A0010000240900001300000000000000000000000000000000005B436F6E74656E745F54797065735D2E786D6C504B01022D0014000600080000002100B5553023F40000004C0200000B00000000000000000000000000D90300005F72656C732F2E72656C73504B01022D00140006000800000021003D58807A10010000EE0400001A00000000000000000000000000FE060000786C2F5F72656C732F776F726B626F6F6B2E786D6C2E72656C73504B01022D0014000600080000002100BCC7BD497D020000650500000F000000000000000000000000004E090000786C2F776F726B626F6F6B2E786D6C504B01022D001400060008000000210062D8951D620200005C0500001800000000000000000000000000F80B0000786C2F776F726B7368656574732F7368656574342E786D6C504B01022D0014000600080000002100521FB1945F020000940500001800000000000000000000000000900E0000786C2F776F726B7368656574732F7368656574322E786D6C504B01022D001400060008000000210041BFF860D9000000CA010000230000000000000000000000000025110000786C2F776F726B7368656574732F5F72656C732F7368656574312E786D6C2E72656C73504B01022D00140006000800000021008035EB58BC0000002501000023000000000000000000000000003F120000786C2F776F726B7368656574732F5F72656C732F7368656574322E786D6C2E72656C73504B01022D0014000600080000002100A750CED9BC0000002501000023000000000000000000000000003C130000786C2F776F726B7368656574732F5F72656C732F7368656574332E786D6C2E72656C73504B01022D0014000600080000002100D067D6E8BC00000025010000230000000000000000000000000039140000786C2F776F726B7368656574732F5F72656C732F7368656574342E786D6C2E72656C73504B01022D00140006000800000021003C78BDFC68030000310C0000180000000000000000000000000036150000786C2F776F726B7368656574732F7368656574332E786D6C504B01022D001400060008000000210037FB3B2E440300002E0900001800000000000000000000000000D4180000786C2F776F726B7368656574732F7368656574312E786D6C504B01022D001400060008000000210015F41B425D020000B405000018000000000000000000000000004E1C0000786C2F776F726B7368656574732F7368656574352E786D6C504B01022D00140006000800000021008B826E58930600008E1A00001300000000000000000000000000E11E0000786C2F7468656D652F7468656D65312E786D6C504B01022D001400060008000000210015E8CB8BF0040000662D00000D00000000000000000000000000A5250000786C2F7374796C65732E786D6C504B01022D00140006000800000021002C64744BFF010000930400001400000000000000000000000000C02A0000786C2F736861726564537472696E67732E786D6C504B01022D0014000600080000002100164AB4BE39010000310200001400000000000000000000000000F12C0000786C2F7461626C65732F7461626C65332E786D6C504B01022D00140006000800000021006C71BE1108010000D906000027000000000000000000000000005C2E0000786C2F7072696E74657253657474696E67732F7072696E74657253657474696E6773312E62696E504B01022D0014000600080000002100797693AFD2010000AC0300001400000000000000000000000000A92F0000786C2F7461626C65732F7461626C65312E786D6C504B01022D00140006000800000021001C207FF1BB010000A40300001000000000000000000000000000AD310000646F6350726F70732F6170702E786D6C504B01022D0014000600080000002100AEB5DF37450100005902000011000000000000000000000000009E340000646F6350726F70732F636F72652E786D6C504B01022D0014000600080000002100448F8762330100001502000014000000000000000000000000001A370000786C2F7461626C65732F7461626C65342E786D6C504B01022D0014000600080000002100A028E8913E0100003202000014000000000000000000000000007F380000786C2F7461626C65732F7461626C65322E786D6C504B0506000000001700170039060000EF3900000000)
GO
SET IDENTITY_INSERT [dbo].[EWIP_FILE_TEMP] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_GL_ACCOUNT] ON 
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (1, N'62009001', N'Supl Exp-Office supplies
', N'소모품비-사무용품')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (2, N'62009002', N'Supl Exp-Welfare 
', N'소모품비-후생용품
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (3, N'62009003', N'Supl Exp-Development
', N'소모품비-개발용품
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (4, N'62009004', N'Supl Exp-Mould
', N'소모품비-금형류
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (5, N'62009005', N'Supl Exp-Jig
', N'소모품비-지그류
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (6, N'62009006', N'Supl Exp-Environment
', N'소모품비-환경안전
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (7, N'62009007', N'Supl Exp-Chemical
', N'소모품비-약품류
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (8, N'62009008', N'Supl Exp-Tools
', N'소모품비-소모공구
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (9, N'62009009', N'Supl Exp-Lamp
', N'소모품비-Lamp
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (10, N'62009010', N'Supl Exp-Gas
', N'소모품비-Gas
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (11, N'62009011', N'Supl Exp-Probe
', N'소모품비-Probe card
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (12, N'62009012', N'Supl Exp-Mask
', N'소모품비-마스크
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (13, N'62009014', N'Supl Exp-PCB
', N'소모품비-PCB
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (14, N'62009015', N'Supl Exp-Wafer
', N'소모품비-WAFER
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (15, N'62009016', N'Supl Exp-IC
', N'소모품비-IC
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (16, N'62009017', N'Supl Exp-Spare
', N'소모품비-Spare Part
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (17, N'62009018', N'Supl Exp-Reflow
', N'소모품비-재연마
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (18, N'63004009', N'Exp Sub-material
', N'부재료비
')
GO
INSERT [dbo].[EWIP_GL_ACCOUNT] ([ID], [GL_ACCOUNT], [SHORT_TEXT_VN], [SHORT_TEXT_KR]) VALUES (19, N'93000030', N'Investor Temporary account
', N'설비 투자
')
GO
SET IDENTITY_INSERT [dbo].[EWIP_GL_ACCOUNT] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_HISTORY_INVENTORY] ON 
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (10, N'03078556-01', 1, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-07-09' AS Date), 7, 2021, N'IN', N'15A9D9E6-D41D-4F5E-8D43-77192ACC68C1', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (13, N'CP-0002', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'7DD0DC00-C74F-4215-B22B-916E257F1B4F', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (14, N'CP-0007', 2, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'C33C936A-8DC9-4DB6-AC71-17AAB3FDDC4B', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (15, N'00359505-02', 1, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'8FB3946A-231B-4FDA-99C8-C6F785A41FDC', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (16, N'CP-0007', 18, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'00023564-B747-4D4C-B1A6-F1EC9713549C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (17, N'CP-0002', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'12ED711D-A54A-4A22-8A97-04515054B130', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (20, N'CP-0005', 80, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'IN', N'3DD257E2-D21C-42AB-8C3D-42FF4701E292', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (21, N'CP-0005', 4, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'3D43F90B-4FE0-42AB-AF3B-CB98777B6C71', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (22, N'CP-0002', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'6FE4137C-9F90-4ADD-BF99-53BC7E05774B', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (23, N'CP-0003', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'F1CDAB9F-78EC-4C2F-8A0A-CFC440648F46', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (24, N'CP-0003', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'1D5E49CF-18E7-40D9-8CED-461E16D59A80', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (25, N'CP-0004', 10, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'1A886BAD-CD1E-4D44-8022-485566C30F36', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (26, N'CP-0027', 3, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'16E92CA2-8519-4FC1-8CE0-3D70625F4943', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (27, N'CP-0005', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'B4A58B22-47DC-4F2E-8CCD-2FE1B2CDDD3A', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (28, N'CP-0008', 4, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'9D0D364E-191C-4500-BC7A-B7759B82F2AA', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (29, N'CP-0007', 3, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'193B359C-B5C8-4688-9A04-26E7B11EC987', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (30, N'N78/ MATYPM CDH 9300083', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'8DF7AF3F-E3F3-4A11-8098-888C76D300F3', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (31, N'CP-0002', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'CA1C3F44-3553-4306-9CF0-524D58679D23', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (32, N'CP-0004', 10, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'DE2258C3-87A3-4C62-A429-5BAF85599525', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (33, N'CP-0003', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'CCCC3949-8DE5-4785-BA74-B40DCE99FE9C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (34, N'CP-0003', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'726336E2-A9CB-4611-A481-C2CC85BDAA19', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (35, N'CP-0003', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'D7FF4052-42F4-4CA9-8E2C-837966EE8039', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (36, N'CP-0007', 4, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'9B8EAFEC-8EAF-4EEB-8994-EEA28DC1B9E1', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (37, N'CP-0002', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'2BA0FD18-D1F4-44DC-A55A-A6D5899FACDF', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (38, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'8B688015-48C9-4BAB-B4DF-A603181B3C00', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (39, N'CP-0004', 5, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'C6C88538-9457-4CE0-B68C-153209C7F810', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (40, N'CP-0012', 1, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'1C28AA6F-FBC7-4053-A2AF-6BF9D32D8E17', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (41, N'CP-0024', 3, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'31F8095B-F284-439C-8834-4394FBDE1238', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (42, N'CP-0032', 1, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'6B1DFF5A-08B0-4F72-A96B-B7515C06B192', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (43, N'CP-0034', 1, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'D37D779F-C466-49A8-9217-2E68902ECF79', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (44, N'CP-0035', 3, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'B32055A1-4270-46E1-89A0-65F2A2D7B589', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (45, N'CP-0040', 1, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'A80CD30B-34F6-4A44-9E01-2A4D884E1B36', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (46, N'CP-0045', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'EE519D2E-3B6B-40D0-AA9F-675AD28C0FA2', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (47, N'CP-0046', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'2F15E315-B1A6-4A6E-960E-6AE061E07630', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (48, N'CP-0007', 1.5, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'AFD8F3F8-0B0D-46EA-AA7E-C28D87494DCB', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (49, N'PL-108AL', 8, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'E1040F87-EAD1-49B3-A143-83622C063F2B', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (50, N'CP-0022', 14, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'67E7C22B-8ECE-4DAC-BFCC-226119F0D6D1', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (51, N'CP-0008', 5, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'0E458DB1-3603-46B3-A562-B20206CA0C3D', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (52, N'CP-0002', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'03A2B5AF-345E-44BE-990A-4D7358E75319', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (53, N'CP-0004', 4, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'93A0625C-484D-4CE4-9678-C6030F9A524B', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (54, N'CP-0004', 5, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'00F72B34-10B9-41DB-AC9E-7BA3AFF84D41', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (55, N'CP-0007', 42, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'41ABBDD3-1872-4DE1-B887-CAD8B7C8A8B9', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (56, N'CP-0005', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'891D1205-5953-4BFA-AD70-1D1163DA2850', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (57, N'N78/ MATYPM CDH 9300083', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'F23E0F85-F5B0-437A-8F0A-361B04728D4B', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (58, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'F425209D-0963-4AA2-A5D8-4E0C62CB5365', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (59, N'CP-0002', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'5E683C30-CDE9-4792-AC42-B0570522FE0C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (60, N'CP-0027', 1, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'6BDDEC51-5451-4646-A769-D5EC9B57AE98', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (61, N'CP-0005', 6, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'962446B1-C09D-4776-B90F-259C23F24456', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (62, N'N78/ MATYPM CDH 9300083', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'CFFE5E28-87AC-473B-9022-23AC037A4B99', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (63, N'CP-0002', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'FF43662E-7B1E-4236-9BA2-91182E4BCEE1', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (64, N'CP-0003', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'F3AFB85C-2C6A-4277-995C-23C2E2942FFA', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (65, N'CP-0004', 5, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'D2302362-EBDA-4457-8BB4-5B61998B194B', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (66, N'CP-0007', 4, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'1E38E89C-036F-4F7A-B7B8-90131B18DAB6', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (67, N'PL-108AL', 2, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'299F6A30-A707-4A5A-80FE-7702683170CA', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (68, N'CP-0020', 1, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'3BA777BD-A0A4-481D-8947-AEAC73BA805E', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (69, N'CP-0007', 2.5, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'E4EE53F1-2B5F-4515-ACBA-68C6637B9FFD', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (70, N'CP-0002', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'9C6B5F4A-BBC3-4C2C-A6EF-4954BF34ABA5', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (71, N'N78/ MATYPM CDH 9300083', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'2D5DEE08-48B8-4994-8309-BAF9C9B7CCA7', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (72, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'D00D0F1B-00C1-4969-BB6B-2D94AEE8A629', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (73, N'CP-0008', 4, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'50EC8888-A7A8-4AD3-9FA9-F2D94D94F433', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (74, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'AA97A3B4-6C1C-49AC-A491-6CB70413185C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (75, N'CP-0004', 10, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'00AB4E0C-7C4E-4AD0-803B-75464CA6A931', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (76, N'NMS50-AO', 3, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'1DCDA67C-D05D-48B7-AF5F-91C5AF1D33AE', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (77, N'CP-0007', 2.5, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'9E59D75C-260F-414B-805A-7C8911EE33AC', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (78, N'CP-0008', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'8A0F42CF-0576-430D-835C-7FBB83D6E4C4', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (79, N'CP-0005', 5, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'003EB8A1-AEC0-4049-A2E5-B29C8C3DDA27', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (80, N'CP-0002', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'347AB072-33F5-43E1-81F4-217DB4D832AB', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (81, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'6B262325-0F06-4C0C-8796-35D2279E3177', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (82, N'CP-0004', 5, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'7F261E0C-A6E9-40DF-B332-B10263489784', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (83, N'CP-0007', 1.5, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'C9F9EAD4-F442-448E-93D2-739C7E8AB994', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (84, N'CP-0027', 1, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'2128090E-C8A2-4509-9825-B9FBF8CEABD1', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (85, N'00359505-02', 1, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'C230B7DA-4DB6-44F1-979A-91F8416A311C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (86, N'CP-0007', 3, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'87D82DAE-EF2F-4BFD-AA37-E765BDBBC2F0', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (87, N'CP-0002', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'C80296A2-7894-4761-AA23-9047D8761DFE', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (88, N'PL-108AL', 4, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'FADF0759-B153-4F5D-9450-6AF5098AF60C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (89, N'CP-0003', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'1861EE36-82E2-46EA-9953-AD1802B4CF60', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (90, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'7F11AC3D-6232-4E9F-9748-7CFF71680DCE', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (91, N'CP-0002', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'0C3AB13D-0DA6-4798-8127-820B918332AD', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (92, N'N78/ MATYPM CDH 9300083', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'39C48878-5446-4BB1-A24A-810E98E18C37', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (95, N'CP-0007', 2, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'7900C584-80BE-40C9-B447-25EDACD7EA41', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (96, N'03103553-01', 15, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'7774C7AF-7052-4418-800E-A6FC8D376581', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (97, N'03101981-01', 10, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'225F28B6-79D6-4A9C-A792-54EA646589DF', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (98, N'PL-108AL', 10, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'2A4B4699-DE84-429E-9F16-0EAD824C7636', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (99, N'CP-0003', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'FBF03CBA-1C11-47FF-A4A5-6DA3646A563B', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (100, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'OUT', N'037C6EA6-CF98-4B32-88C7-492F7276C360', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (101, N'CP-0003', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'IN', N'5102BE03-9EA2-491C-960E-D95515E57C15', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (102, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, N'IN', N'DD033B08-E683-47F6-AD31-7DFF581ED6C0', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (103, N'CP-0007', 1, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'20D40E60-A628-4DA9-AF6C-9F7E3226A6A2', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (104, N'CP-0004', 5, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'D283E3F0-EBD2-4477-A70F-32124F3D6F4C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (105, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'C5ECF72B-BA8A-4E9F-A4A0-D78D04E431C5', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (106, N'CP-0027', 4, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'EC2AC6DE-ED70-45E2-9D11-AB49AF85A056', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (107, N'CP-0030', 2, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'EA08BB92-B9DB-44D0-A2FD-E7E3E8B00B95', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (108, N'CP-0007', 4.5, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'498AFCAA-4054-4A5C-852A-02E9720DAF70', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (109, N'CP-0002', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'CB1A9B50-5864-4CF6-8010-800040265E8D', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (110, N'CP-0022', 42, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'5EAFA986-7E01-4B6F-96B5-278585E3D966', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (111, N'CP-0022', 14, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'9209C7DD-8DC3-431D-9542-68213B7A375E', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (112, N'CP-0004', 10, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'E417EA10-BB8A-423F-9D89-FCFA70979E0F', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (113, N'CP-0004', 10, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'7C3124BE-8031-4B47-9398-50E8447FE9C0', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (114, N'CP-0005', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'6CD7B533-A743-423C-A7E5-DA297471546E', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (115, N'CP-0005', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'EC70D572-D90B-4211-8EE7-A188B81C719F', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (116, N'PL-108AL', 4, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'660FB9A8-F6F0-4A05-9756-044C4766C5CE', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (117, N'N78/ MATYPM CDH 9300083', 4, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'FCFA4533-0D0E-4023-BC5D-2F76D500C215', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (118, N'CP-0008', 12, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'A24D21E1-F6B0-4521-9F9B-CE0C47E79D00', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (119, N'CP-0008', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'570176E9-C12A-4425-8EF4-44A29BAED646', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (120, N'CP-0012', 2, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, N'OUT', N'4962F79D-E978-4EF7-B241-EECE4031190C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (121, N'CP-0008', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-13' AS Date), 7, 2021, N'OUT', N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (122, N'CP-0005', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-13' AS Date), 7, 2021, N'OUT', N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (123, N'CP-0003', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-13' AS Date), 7, 2021, N'OUT', N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (124, N'CP-0002', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-13' AS Date), 7, 2021, N'OUT', N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (125, N'CP-0007', 3, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-13' AS Date), 7, 2021, N'OUT', N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (126, N'N78/ MATYPM CDH 9300083', 4, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-13' AS Date), 7, 2021, N'OUT', N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (127, N'CP-0007', 0.5, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-13' AS Date), 7, 2021, N'OUT', N'3D947D0E-D49F-4FAF-8523-4D0970E9E434', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (128, N'CP-0004', 15, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-13' AS Date), 7, 2021, N'OUT', N'3D947D0E-D49F-4FAF-8523-4D0970E9E434', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (130, N'CP-0007', 62.5, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-14' AS Date), 7, 2021, N'OUT', N'84081660-BD92-4C6A-B442-27DEDBACD911', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (131, N'N78/ MATYPM CDH 9300083', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-14' AS Date), 7, 2021, N'OUT', N'84081660-BD92-4C6A-B442-27DEDBACD911', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (132, N'CP-0002', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-14' AS Date), 7, 2021, N'OUT', N'84081660-BD92-4C6A-B442-27DEDBACD911', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (133, N'CP-0027', 50, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-14' AS Date), 7, 2021, N'IN', N'9A6A343C-0670-4FB2-9797-D5A1CAF35BDB', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (134, N'CP-0007', 3.5, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-14' AS Date), 7, 2021, N'OUT', N'1F572961-2BB8-42AE-B781-B01E88B34509', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (135, N'CP-0002', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-14' AS Date), 7, 2021, N'OUT', N'1F572961-2BB8-42AE-B781-B01E88B34509', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (136, N'CP-0002', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-14' AS Date), 7, 2021, N'IN', N'C13E476E-0B0D-43D3-B84D-9F39526BAE9C', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (139, N'CP-0008', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, N'OUT', N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (140, N'CP-0005', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, N'OUT', N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (141, N'CP-0003', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, N'OUT', N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (142, N'CP-0002', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, N'OUT', N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (143, N'CP-0004', 10, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, N'OUT', N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (144, N'CP-0007', 5.5, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, N'OUT', N'B7193AB5-93B6-491E-AB19-C87CBA72A429', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (145, N'PL-108AL', 10, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, N'OUT', N'B7193AB5-93B6-491E-AB19-C87CBA72A429', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (146, N'CP-0004', 477, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-13' AS Date), 7, 2021, N'IN', N'B2B5D67D-FF79-44A5-B1FB-3C0D64644442', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (148, N'N78/ MATYPM CDH 9300083', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, N'OUT', N'665ECC8F-FEC4-4764-A9D2-18C5AC52BEBA', N'COMPLETE')
GO
INSERT [dbo].[EWIP_HISTORY_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [IN_OUT], [STOCK_IN_OUT_CODE], [STATUS]) VALUES (150, N'PL-108AL', 150, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-17' AS Date), 7, 2021, N'IN', N'269F5272-6166-4691-BDA0-7ACCCE905E87', N'COMPLETE')
GO
SET IDENTITY_INSERT [dbo].[EWIP_HISTORY_INVENTORY] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ON 
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (1, N'00343774-03', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 1)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (2, N'00359505-02', 10, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 10)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (3, N'03015840-03', 40, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 40)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (4, N'03015854-03', 14, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 14)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (5, N'03015869-03', 64, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 64)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (6, N'03054812-02', 8, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 8)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (7, N'03099720-01', 67, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 67)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (8, N'03101981-01', 92, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 92)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (9, N'03102344-01', 176, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 176)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (10, N'03102457-01', 102, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 102)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (11, N'03102459-01', 35, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 35)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (12, N'03102963-01', 42, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 42)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (13, N'03103544-01', 27, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 27)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (14, N'03103553-01', 99, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 99)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (15, N'03105714-01', 8, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 8)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (16, N'03107579-01', 5, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 5)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (17, N'03115821-01', 43, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 43)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (18, N'03115853-01', 23, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 23)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (19, N'03133662-01', 34, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 34)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (20, N'CP-0002', 182, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 182)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (21, N'CP-0003', 213, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 213)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (22, N'CP-0004', 429, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 429)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (23, N'CP-0005', 24, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 24)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (24, N'CP-0006', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 1)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (25, N'CP-0007', 29.025000000000002, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 29.025000000000002)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (26, N'CP-0008', 96, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 96)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (27, N'CP-0009', 16, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 16)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (28, N'CP-0010', 0.33333333333333331, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 0.33333333333333331)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (29, N'CP-0011', 34, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 34)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (30, N'CP-0012', 0.5, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 0.5)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (31, N'CP-0013', 2.5, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 2.5)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (32, N'CP-0014', 1.3333333333333333, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 1.3333333333333333)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (33, N'CP-0015', 1.3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 1.3)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (34, N'CP-0016', 2.333333333333333, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 2.333333333333333)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (35, N'CP-0017', 2, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 2)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (36, N'CP-0018', 0.30000000000000004, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 0.30000000000000004)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (37, N'CP-0019', 6.833333333333333, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 6.833333333333333)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (38, N'CP-0020', 7.833333333333333, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 7.833333333333333)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (39, N'CP-0021', 6, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 6)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (40, N'CP-0022', 5.24, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 5.24)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (41, N'CP-0023', 4, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 4)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (42, N'CP-0024', 3.1666666666666665, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 3.1666666666666665)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (43, N'CP-0025', 29, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 29)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (44, N'CP-0026', 5, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 5)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (45, N'CP-0027', 12, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 12)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (46, N'CP-0028', 7, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 7)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (47, N'CP-0029', 4, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 4)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (48, N'CP-0030', 21, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 21)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (49, N'CP-0031', 6, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 6)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (50, N'CP-0032', 20, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 20)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (51, N'CP-0033', 5, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 5)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (52, N'CP-0034', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 3)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (53, N'CP-0035', 44, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 44)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (54, N'CP-0036', 6, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 6)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (55, N'CP-0039', 16, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 16)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (56, N'CP-0040', 13, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 13)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (57, N'CP-0041', 35, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 35)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (58, N'CP-0042', 1.8, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 1.8)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (59, N'CP-0043', 4, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 4)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (60, N'CP-0044', 29, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 29)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (61, N'CP-0045', 8, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 8)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (62, N'CP-0046', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 3)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (63, N'CP-0047', 5, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 5)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (64, N'CP-0048', 10, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 10)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (65, N'CP-0049', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 3)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (66, N'CP-0050', 5, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 5)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (67, N'CP-0051', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 1)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (68, N'CP-0052', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 1)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (69, N'CP-0053', 100, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 100)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (70, N'CP-0054', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 1)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (71, N'CP-0055', 11.200000000000001, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 11.200000000000001)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (72, N'CP-0056', 3, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 3)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (73, N'N78/ MATYPM CDH 9300083', 99, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 99)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (74, N'Pentel NMS50', 22, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 22)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (75, N'PL-108AL', 57, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 57)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (76, N'SP-0004', 8, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 8)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (77, N'2-8999-810-00-0', 0, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-07-09' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (78, N'03071039-01', 0, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-07-09' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (79, N'03078556-01', 1, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-07-09' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (80, N'2-8999-735-00-0', 0, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-07-09' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (81, N'CP-0002', 153, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (82, N'CP-0007', 414, N'LIT', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (83, N'00359505-02', 8, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (84, N'CP-0005', 74, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (85, N'CP-0003', 188, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (86, N'CP-0004', 802, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (87, N'CP-0027', 53, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-14' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (88, N'CP-0008', 62, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (89, N'N78/ MATYPM CDH 9300083', 79, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-15' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (90, N'CP-0012', 0, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (91, N'CP-0024', 16, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (92, N'CP-0032', 19, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (93, N'CP-0034', 2, N'REEL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (94, N'CP-0035', 41, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (95, N'CP-0040', 12, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (96, N'CP-0045', 7, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (97, N'CP-0046', 1, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (98, N'PL-108AL', 169, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-17' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (99, N'CP-0022', 192, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (100, N'CP-0020', 46, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (101, N'NMS50-AO', 19, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (102, N'03103553-01', 84, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (103, N'03101981-01', 82, N'PACK', N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), 7, 2021, NULL)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (104, N'P/N 85-150-500', 10, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 10)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (105, N'P/N 90-150-705', 3, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 3)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (106, N'P/N 180-100-50', 5, N'EA', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 5)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (107, N'NMS50-AO', 22, N'BOX', N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), 6, 2021, 22)
GO
INSERT [dbo].[EWIP_INVENTORY_BY_TIME] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT], [DEPT_CODE], [STOCK_CODE], [DATE], [MONTH], [YEAR], [QUANTITY_REAL]) VALUES (108, N'CP-0030', 19, N'ROLL', N'SMT', N'SMT_K1', CAST(N'2021-07-12' AS Date), 7, 2021, NULL)
GO
SET IDENTITY_INSERT [dbo].[EWIP_INVENTORY_BY_TIME] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ON 
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (7, N'15A9D9E6-D41D-4F5E-8D43-77192ACC68C1', CAST(N'2021-07-09' AS Date), N'IN', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (10, N'7DD0DC00-C74F-4215-B22B-916E257F1B4F', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (11, N'C33C936A-8DC9-4DB6-AC71-17AAB3FDDC4B', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (12, N'8FB3946A-231B-4FDA-99C8-C6F785A41FDC', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (13, N'00023564-B747-4D4C-B1A6-F1EC9713549C', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (14, N'12ED711D-A54A-4A22-8A97-04515054B130', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (17, N'3DD257E2-D21C-42AB-8C3D-42FF4701E292', CAST(N'2021-07-10' AS Date), N'IN', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (18, N'3D43F90B-4FE0-42AB-AF3B-CB98777B6C71', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (19, N'6FE4137C-9F90-4ADD-BF99-53BC7E05774B', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (20, N'F1CDAB9F-78EC-4C2F-8A0A-CFC440648F46', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (21, N'1D5E49CF-18E7-40D9-8CED-461E16D59A80', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (22, N'1A886BAD-CD1E-4D44-8022-485566C30F36', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (23, N'16E92CA2-8519-4FC1-8CE0-3D70625F4943', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (24, N'B4A58B22-47DC-4F2E-8CCD-2FE1B2CDDD3A', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (25, N'9D0D364E-191C-4500-BC7A-B7759B82F2AA', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (26, N'193B359C-B5C8-4688-9A04-26E7B11EC987', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (27, N'8DF7AF3F-E3F3-4A11-8098-888C76D300F3', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (28, N'CA1C3F44-3553-4306-9CF0-524D58679D23', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (29, N'DE2258C3-87A3-4C62-A429-5BAF85599525', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (30, N'CCCC3949-8DE5-4785-BA74-B40DCE99FE9C', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (31, N'726336E2-A9CB-4611-A481-C2CC85BDAA19', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (32, N'D7FF4052-42F4-4CA9-8E2C-837966EE8039', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (33, N'9B8EAFEC-8EAF-4EEB-8994-EEA28DC1B9E1', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (34, N'2BA0FD18-D1F4-44DC-A55A-A6D5899FACDF', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (35, N'8B688015-48C9-4BAB-B4DF-A603181B3C00', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (36, N'C6C88538-9457-4CE0-B68C-153209C7F810', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (37, N'1C28AA6F-FBC7-4053-A2AF-6BF9D32D8E17', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (38, N'31F8095B-F284-439C-8834-4394FBDE1238', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (39, N'6B1DFF5A-08B0-4F72-A96B-B7515C06B192', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (40, N'D37D779F-C466-49A8-9217-2E68902ECF79', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (41, N'B32055A1-4270-46E1-89A0-65F2A2D7B589', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (42, N'A80CD30B-34F6-4A44-9E01-2A4D884E1B36', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (43, N'EE519D2E-3B6B-40D0-AA9F-675AD28C0FA2', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (44, N'2F15E315-B1A6-4A6E-960E-6AE061E07630', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (45, N'AFD8F3F8-0B0D-46EA-AA7E-C28D87494DCB', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (46, N'E1040F87-EAD1-49B3-A143-83622C063F2B', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (47, N'67E7C22B-8ECE-4DAC-BFCC-226119F0D6D1', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (48, N'0E458DB1-3603-46B3-A562-B20206CA0C3D', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (49, N'03A2B5AF-345E-44BE-990A-4D7358E75319', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (50, N'93A0625C-484D-4CE4-9678-C6030F9A524B', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (51, N'00F72B34-10B9-41DB-AC9E-7BA3AFF84D41', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (52, N'41ABBDD3-1872-4DE1-B887-CAD8B7C8A8B9', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (53, N'891D1205-5953-4BFA-AD70-1D1163DA2850', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (54, N'F23E0F85-F5B0-437A-8F0A-361B04728D4B', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (55, N'F425209D-0963-4AA2-A5D8-4E0C62CB5365', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (56, N'5E683C30-CDE9-4792-AC42-B0570522FE0C', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (57, N'6BDDEC51-5451-4646-A769-D5EC9B57AE98', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (58, N'962446B1-C09D-4776-B90F-259C23F24456', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (59, N'CFFE5E28-87AC-473B-9022-23AC037A4B99', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (60, N'FF43662E-7B1E-4236-9BA2-91182E4BCEE1', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (61, N'F3AFB85C-2C6A-4277-995C-23C2E2942FFA', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (62, N'D2302362-EBDA-4457-8BB4-5B61998B194B', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (63, N'1E38E89C-036F-4F7A-B7B8-90131B18DAB6', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (64, N'299F6A30-A707-4A5A-80FE-7702683170CA', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (65, N'3BA777BD-A0A4-481D-8947-AEAC73BA805E', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (66, N'E4EE53F1-2B5F-4515-ACBA-68C6637B9FFD', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (67, N'9C6B5F4A-BBC3-4C2C-A6EF-4954BF34ABA5', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (68, N'2D5DEE08-48B8-4994-8309-BAF9C9B7CCA7', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (69, N'D00D0F1B-00C1-4969-BB6B-2D94AEE8A629', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (70, N'50EC8888-A7A8-4AD3-9FA9-F2D94D94F433', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (71, N'AA97A3B4-6C1C-49AC-A491-6CB70413185C', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (72, N'00AB4E0C-7C4E-4AD0-803B-75464CA6A931', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (73, N'1DCDA67C-D05D-48B7-AF5F-91C5AF1D33AE', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (74, N'9E59D75C-260F-414B-805A-7C8911EE33AC', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (75, N'8A0F42CF-0576-430D-835C-7FBB83D6E4C4', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (76, N'003EB8A1-AEC0-4049-A2E5-B29C8C3DDA27', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (77, N'347AB072-33F5-43E1-81F4-217DB4D832AB', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (78, N'6B262325-0F06-4C0C-8796-35D2279E3177', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (79, N'7F261E0C-A6E9-40DF-B332-B10263489784', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (80, N'C9F9EAD4-F442-448E-93D2-739C7E8AB994', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (81, N'2128090E-C8A2-4509-9825-B9FBF8CEABD1', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (82, N'C230B7DA-4DB6-44F1-979A-91F8416A311C', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (83, N'87D82DAE-EF2F-4BFD-AA37-E765BDBBC2F0', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (84, N'C80296A2-7894-4761-AA23-9047D8761DFE', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (85, N'FADF0759-B153-4F5D-9450-6AF5098AF60C', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (86, N'1861EE36-82E2-46EA-9953-AD1802B4CF60', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (87, N'7F11AC3D-6232-4E9F-9748-7CFF71680DCE', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (88, N'0C3AB13D-0DA6-4798-8127-820B918332AD', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (89, N'39C48878-5446-4BB1-A24A-810E98E18C37', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (92, N'7900C584-80BE-40C9-B447-25EDACD7EA41', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (93, N'7774C7AF-7052-4418-800E-A6FC8D376581', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (94, N'225F28B6-79D6-4A9C-A792-54EA646589DF', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (95, N'2A4B4699-DE84-429E-9F16-0EAD824C7636', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (96, N'FBF03CBA-1C11-47FF-A4A5-6DA3646A563B', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (97, N'037C6EA6-CF98-4B32-88C7-492F7276C360', CAST(N'2021-07-10' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (98, N'5102BE03-9EA2-491C-960E-D95515E57C15', CAST(N'2021-07-10' AS Date), N'IN', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (99, N'DD033B08-E683-47F6-AD31-7DFF581ED6C0', CAST(N'2021-07-10' AS Date), N'IN', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (100, N'20D40E60-A628-4DA9-AF6C-9F7E3226A6A2', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (101, N'D283E3F0-EBD2-4477-A70F-32124F3D6F4C', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (102, N'C5ECF72B-BA8A-4E9F-A4A0-D78D04E431C5', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (103, N'EC2AC6DE-ED70-45E2-9D11-AB49AF85A056', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (104, N'EA08BB92-B9DB-44D0-A2FD-E7E3E8B00B95', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (105, N'498AFCAA-4054-4A5C-852A-02E9720DAF70', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (106, N'CB1A9B50-5864-4CF6-8010-800040265E8D', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (107, N'5EAFA986-7E01-4B6F-96B5-278585E3D966', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (108, N'9209C7DD-8DC3-431D-9542-68213B7A375E', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (109, N'E417EA10-BB8A-423F-9D89-FCFA70979E0F', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (110, N'7C3124BE-8031-4B47-9398-50E8447FE9C0', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (111, N'6CD7B533-A743-423C-A7E5-DA297471546E', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (112, N'EC70D572-D90B-4211-8EE7-A188B81C719F', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (113, N'660FB9A8-F6F0-4A05-9756-044C4766C5CE', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (114, N'FCFA4533-0D0E-4023-BC5D-2F76D500C215', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (115, N'A24D21E1-F6B0-4521-9F9B-CE0C47E79D00', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (116, N'570176E9-C12A-4425-8EF4-44A29BAED646', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (117, N'4962F79D-E978-4EF7-B241-EECE4031190C', CAST(N'2021-07-12' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (118, N'087ADB92-A953-4860-85C8-9C164C96FD6C', CAST(N'2021-07-13' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (119, N'3D947D0E-D49F-4FAF-8523-4D0970E9E434', CAST(N'2021-07-13' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (121, N'84081660-BD92-4C6A-B442-27DEDBACD911', CAST(N'2021-07-14' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (122, N'9A6A343C-0670-4FB2-9797-D5A1CAF35BDB', CAST(N'2021-07-14' AS Date), N'IN', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (123, N'1F572961-2BB8-42AE-B781-B01E88B34509', CAST(N'2021-07-14' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (124, N'C13E476E-0B0D-43D3-B84D-9F39526BAE9C', CAST(N'2021-07-14' AS Date), N'IN', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (127, N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', CAST(N'2021-07-15' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (128, N'B7193AB5-93B6-491E-AB19-C87CBA72A429', CAST(N'2021-07-15' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (129, N'B2B5D67D-FF79-44A5-B1FB-3C0D64644442', CAST(N'2021-07-13' AS Date), N'IN', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (131, N'665ECC8F-FEC4-4764-A9D2-18C5AC52BEBA', CAST(N'2021-07-15' AS Date), N'OUT', N'SMT_K1', N'SMT', N'', N'H2105001', N'', N'COMPLETE', N'')
GO
INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ([ID], [CODE_NO], [DATE], [IN_OUT], [STOCK_CODE], [DEPT_CODE], [USER_CREATE], [USER_SYS], [ORDER_CODE], [STATUS], [DELIVERET_RECEIVER]) VALUES (133, N'269F5272-6166-4691-BDA0-7ACCCE905E87', CAST(N'2021-07-17' AS Date), N'IN', N'SMT_K1', N'SMT', N'H2105001', N'H2105001', N'', N'COMPLETE', N'')
GO
SET IDENTITY_INSERT [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] OFF
GO
INSERT [dbo].[EWIP_LABEL] ([CODE], [LABEL], [DESC]) VALUES (N'BARCODE_128', N'<?xml version="1.0" encoding="utf-8"?>
<XtraReportsLayoutSerializer SerializerVersion="19.2.3.0" Ref="0" ControlType="DevExpress.XtraReports.UI.XtraReport, DevExpress.XtraReports.v19.2, Version=19.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Name="FF_OUT_BOX" Margins="0, 0, 2, 52" PaperKind="Custom" PageWidth="346" PageHeight="1803" Version="19.2" ShowPrintStatusDialog="false" ShowPrintMarginsWarning="false">
  <Bands>
    <Item1 Ref="1" ControlType="TopMarginBand" Name="TopMargin" HeightF="2" />
    <Item2 Ref="2" ControlType="DetailBand" Name="Detail" HeightF="146.250015">
      <Controls>
        <Item1 Ref="3" ControlType="XRBarCode" Name="barCode1" Text="$BARCODE$" SizeF="129.166672,136.250015" LocationFloat="206.833389, 10.0000067" Font="Times New Roman, 0.75pt" Padding="10,10,0,0,100">
          <Symbology Ref="4" Name="QRCode" />
          <StylePriority Ref="5" UseFont="false" />
        </Item1>
        <Item2 Ref="6" ControlType="XRLabel" Name="label1" Multiline="true" Text="$BARCODE$" SizeF="143.75,23.0000019" LocationFloat="63.0833931, 22.5000057" Font="Courier New, 11.75pt, style=Bold" Padding="2,2,0,0,100">
          <StylePriority Ref="7" UseFont="false" />
        </Item2>
      </Controls>
    </Item2>
    <Item3 Ref="8" ControlType="BottomMarginBand" Name="BottomMargin" HeightF="52" />
  </Bands>
</XtraReportsLayoutSerializer>', NULL)
GO
INSERT [dbo].[EWIP_LABEL] ([CODE], [LABEL], [DESC]) VALUES (N'QRCODE', N'<?xml version="1.0" encoding="utf-8"?>
<XtraReportsLayoutSerializer SerializerVersion="19.2.3.0" Ref="0" ControlType="DevExpress.XtraReports.UI.XtraReport, DevExpress.XtraReports.v19.2, Version=19.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Name="FF_OUT_BOX" Margins="0, 0, 2, 0" PaperKind="Custom" PageWidth="346" PageHeight="1803" Version="19.2" ShowPrintStatusDialog="false" ShowPrintMarginsWarning="false">
  <Bands>
    <Item1 Ref="1" ControlType="TopMarginBand" Name="TopMargin" HeightF="2" />
    <Item2 Ref="2" ControlType="DetailBand" Name="Detail" HeightF="146.250015">
      <Controls>
        <Item1 Ref="3" ControlType="XRLabel" Name="label2" Multiline="true" Text="$POSITION$" TextAlignment="TopCenter" SizeF="143.75,23" LocationFloat="1.62490082, 24.0000076" Font="Courier New, 11.75pt, style=Bold" Padding="2,2,0,0,100">
          <StylePriority Ref="4" UseFont="false" UseTextAlignment="false" />
        </Item1>
        <Item2 Ref="5" ControlType="XRBarCode" Name="barCode1" Text="$BARCODE$" SizeF="90.625,61.5000076" LocationFloat="145.375, 1.00000668" Font="Times New Roman, 0.75pt" Padding="10,10,0,0,100">
          <Symbology Ref="6" Name="QRCode" />
          <StylePriority Ref="7" UseFont="false" />
        </Item2>
        <Item3 Ref="8" ControlType="XRLabel" Name="label1" Multiline="true" Text="$CODE$" TextAlignment="TopCenter" SizeF="143.75,23.0000019" LocationFloat="1.62490082, 1.00000668" Font="Courier New, 11.75pt, style=Bold" Padding="2,2,0,0,100">
          <StylePriority Ref="9" UseFont="false" UseTextAlignment="false" />
        </Item3>
      </Controls>
    </Item2>
    <Item3 Ref="10" ControlType="BottomMarginBand" Name="BottomMargin" HeightF="0" />
  </Bands>
</XtraReportsLayoutSerializer>', NULL)
GO
INSERT [dbo].[EWIP_LABEL] ([CODE], [LABEL], [DESC]) VALUES (N'QRCODE_UPDATE', N'<?xml version="1.0" encoding="utf-8"?>
<XtraReportsLayoutSerializer SerializerVersion="19.2.3.0" Ref="0" ControlType="DevExpress.XtraReports.UI.XtraReport, DevExpress.XtraReports.v19.2, Version=19.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Name="FF_OUT_BOX" Margins="0, 0, 2, 0" PaperKind="Custom" PageWidth="346" PageHeight="1803" Version="19.2" ShowPrintStatusDialog="false" ShowPrintMarginsWarning="false">
  <Bands>
    <Item1 Ref="1" ControlType="TopMarginBand" Name="TopMargin" HeightF="2" />
    <Item2 Ref="2" ControlType="DetailBand" Name="Detail" HeightF="146.250015">
      <Controls>
        <Item1 Ref="3" ControlType="XRLabel" Name="label3" Multiline="true" Text="$EXP_DATE$" TextAlignment="TopLeft" SizeF="132.291672,16.9166565" LocationFloat="0.999999046, 32.166687" Font="Courier New, 7.75pt, style=Bold" Padding="2,2,0,0,100">
          <StylePriority Ref="4" UseFont="false" UseTextAlignment="false" />
        </Item1>
        <Item2 Ref="5" ControlType="XRLabel" Name="label2" Multiline="true" Text="$POSITION$" TextAlignment="TopLeft" SizeF="132.291672,15.5833321" LocationFloat="0.999999046, 16.5833473" Font="Courier New, 8.75pt, style=Bold" Padding="2,2,0,0,100">
          <StylePriority Ref="6" UseFont="false" UseTextAlignment="false" />
        </Item2>
        <Item3 Ref="7" ControlType="XRBarCode" Name="barCode1" Text="$BARCODE$" SizeF="90.625,61.5000076" LocationFloat="133.291672, 1.00000668" Font="Times New Roman, 0.75pt" Padding="5,10,0,0,100">
          <Symbology Ref="8" Name="QRCode" />
          <StylePriority Ref="9" UseFont="false" UsePadding="false" />
        </Item3>
        <Item4 Ref="10" ControlType="XRLabel" Name="label1" Multiline="true" Text="$CODE$" TextAlignment="TopLeft" SizeF="132.291672,15.5833406" LocationFloat="0.999999046, 1.000007" Font="Courier New, 8.75pt, style=Bold" Padding="0,0,0,0,100">
          <StylePriority Ref="11" UseFont="false" UsePadding="false" UseTextAlignment="false" />
        </Item4>
      </Controls>
    </Item2>
    <Item3 Ref="12" ControlType="BottomMarginBand" Name="BottomMargin" HeightF="0" />
  </Bands>
</XtraReportsLayoutSerializer>', NULL)
GO
SET IDENTITY_INSERT [dbo].[EWIP_LOCATIONS] ON 
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (961, N'01-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (962, N'01-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (963, N'01-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (964, N'01-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (965, N'01-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (966, N'01-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (967, N'01-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (968, N'01-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (969, N'01-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (970, N'01-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (977, N'02-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (978, N'02-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (979, N'02-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (980, N'02-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (981, N'02-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (982, N'02-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (983, N'02-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (984, N'02-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (985, N'02-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (986, N'02-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (993, N'03-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (994, N'03-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (995, N'03-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (996, N'03-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (997, N'03-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (998, N'03-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (999, N'03-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1000, N'03-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1001, N'03-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1002, N'03-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1009, N'04-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1025, N'05-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1026, N'05-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1027, N'05-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1028, N'05-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1029, N'05-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1030, N'05-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1031, N'05-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1032, N'05-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1033, N'05-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1034, N'05-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1041, N'06-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1042, N'06-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1043, N'06-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1044, N'06-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1045, N'06-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1046, N'06-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1047, N'06-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1048, N'06-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1049, N'06-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1050, N'06-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1057, N'07-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1058, N'07-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1059, N'07-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1060, N'07-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1061, N'07-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1062, N'07-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1063, N'07-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1064, N'07-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1065, N'07-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1066, N'07-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1073, N'08-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1088, N'08-16', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1089, N'09-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1090, N'09-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1091, N'09-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1092, N'09-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1093, N'09-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1094, N'09-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1095, N'09-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1096, N'09-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1097, N'09-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1098, N'09-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1105, N'10-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1106, N'10-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1107, N'10-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1108, N'10-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1109, N'10-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1110, N'10-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1111, N'10-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1112, N'10-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1113, N'10-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1114, N'10-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1121, N'11-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1137, N'12-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1153, N'13-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1154, N'13-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1155, N'13-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1156, N'13-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1157, N'13-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1158, N'13-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1159, N'13-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1160, N'13-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1161, N'13-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1162, N'13-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1169, N'14-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1185, N'15-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1201, N'16-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1218, N'17-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1219, N'17-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1220, N'17-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1221, N'17-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1222, N'17-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1223, N'17-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1224, N'17-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1225, N'17-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1226, N'17-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1227, N'17-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1228, N'18-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1229, N'18-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1230, N'18-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1231, N'18-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1232, N'18-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1233, N'18-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1234, N'18-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1235, N'18-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1236, N'18-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1239, N'18-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1241, N'18-11', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1243, N'18-12', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1244, N'18-13', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1245, N'18-14', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1246, N'18-15', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1247, N'19-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1248, N'19-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1249, N'19-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1250, N'19-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1251, N'19-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1252, N'19-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1253, N'19-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1254, N'19-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1255, N'19-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1256, N'19-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1257, N'19-11', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1258, N'19-12', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1259, N'19-13', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1260, N'19-14', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1261, N'19-15', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1262, N'20-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1263, N'20-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1264, N'20-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1265, N'20-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1266, N'20-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1267, N'20-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1268, N'20-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1269, N'20-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1270, N'20-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1271, N'20-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1272, N'20-11', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1273, N'20-12', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1274, N'20-13', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1275, N'20-14', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1276, N'20-15', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1278, N'21-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1279, N'21-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1280, N'21-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1281, N'21-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1282, N'21-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1283, N'21-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1284, N'21-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1285, N'21-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1286, N'21-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1287, N'21-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1288, N'22-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1289, N'22-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1290, N'22-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1291, N'22-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1292, N'22-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1293, N'22-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1294, N'22-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1295, N'22-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1296, N'22-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1297, N'22-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1298, N'22-11', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1299, N'22-12', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1300, N'22-13', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1301, N'22-14', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1302, N'22-15', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1303, N'23-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1304, N'23-02', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1305, N'23-03', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1306, N'23-04', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1307, N'23-05', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1308, N'23-06', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1309, N'23-07', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1310, N'23-08', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1311, N'23-09', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1312, N'23-10', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1313, N'23-11', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1314, N'23-12', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1315, N'23-13', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1316, N'23-14', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1317, N'23-15', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1318, N'24-01', N'SMT_K1', N'SMT', NULL)
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1319, N'24-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1320, N'24-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1321, N'24-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1322, N'24-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1323, N'24-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1324, N'24-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1325, N'24-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1326, N'24-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1327, N'24-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1328, N'24-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1329, N'24-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1330, N'24-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1331, N'24-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1332, N'24-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1333, N'25-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1334, N'25-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1335, N'25-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1336, N'25-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1337, N'25-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1338, N'25-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1339, N'25-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1340, N'25-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1341, N'25-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1342, N'25-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1346, N'26-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1347, N'26-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1348, N'26-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1349, N'26-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1350, N'26-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1351, N'26-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1352, N'26-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1353, N'26-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1354, N'26-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1355, N'26-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1356, N'26-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1357, N'26-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1358, N'26-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1359, N'26-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1360, N'26-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1361, N'27-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1362, N'27-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1363, N'27-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1364, N'27-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1365, N'27-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1366, N'27-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1367, N'27-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1368, N'27-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1369, N'27-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1370, N'27-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1376, N'28-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1377, N'28-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1378, N'28-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1379, N'28-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1380, N'28-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1381, N'28-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1382, N'28-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1383, N'28-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1384, N'28-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1385, N'28-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1386, N'29-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1387, N'29-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1388, N'29-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1389, N'29-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1390, N'29-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1391, N'29-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1392, N'29-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1393, N'29-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1394, N'29-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1395, N'29-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1396, N'30-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1397, N'30-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1398, N'30-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1399, N'30-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1400, N'30-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1401, N'30-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1402, N'30-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1403, N'30-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1404, N'30-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1405, N'30-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1406, N'31-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1407, N'31-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1408, N'31-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1409, N'31-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1410, N'31-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1411, N'31-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1412, N'31-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1413, N'31-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1414, N'31-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1415, N'31-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1416, N'32-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1417, N'33-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1418, N'33-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1419, N'33-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1420, N'33-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1421, N'33-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1422, N'33-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1423, N'33-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1424, N'33-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1425, N'33-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1426, N'33-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1427, N'34-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1428, N'34-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1429, N'34-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1430, N'34-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1431, N'34-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1432, N'34-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1433, N'34-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1434, N'34-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1435, N'34-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1436, N'34-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1437, N'34-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1438, N'34-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1439, N'34-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1440, N'34-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1441, N'34-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1442, N'35-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1443, N'35-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1444, N'35-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1445, N'35-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1446, N'35-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1447, N'35-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1448, N'35-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1449, N'35-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1450, N'35-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1451, N'35-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1452, N'35-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1453, N'35-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1454, N'35-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1455, N'35-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1456, N'35-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1457, N'36-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1458, N'36-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1459, N'36-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1460, N'36-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1461, N'36-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1462, N'36-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1463, N'36-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1464, N'36-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1465, N'36-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1466, N'36-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1467, N'36-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1468, N'36-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1469, N'36-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1470, N'36-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1471, N'36-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1472, N'37-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1473, N'37-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1474, N'37-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1475, N'37-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1476, N'37-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1477, N'37-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1478, N'37-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1479, N'37-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1480, N'37-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1481, N'37-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1482, N'38-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1483, N'38-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1484, N'38-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1485, N'38-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1486, N'38-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1487, N'38-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1488, N'38-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1489, N'38-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1490, N'38-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1491, N'38-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1492, N'38-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1493, N'38-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1494, N'38-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1495, N'38-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1496, N'38-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1497, N'39-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1498, N'39-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1499, N'39-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1500, N'39-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1501, N'39-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1502, N'39-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1503, N'39-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1504, N'39-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1505, N'39-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1507, N'39-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1508, N'39-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1509, N'39-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1510, N'39-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1511, N'39-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1512, N'39-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1513, N'40-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1514, N'40-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1515, N'40-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1516, N'40-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1517, N'40-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1518, N'40-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1519, N'40-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1520, N'40-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1521, N'40-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1522, N'40-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1523, N'40-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1524, N'40-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1525, N'40-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1526, N'40-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1527, N'40-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1528, N'41-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1529, N'41-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1530, N'41-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1531, N'41-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1532, N'41-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1533, N'41-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1534, N'41-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1535, N'41-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1536, N'41-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1537, N'41-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1538, N'42-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1539, N'42-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1540, N'42-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1541, N'42-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1542, N'42-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1543, N'42-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1544, N'42-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1545, N'42-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1546, N'42-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1547, N'42-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1548, N'42-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1549, N'42-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1550, N'42-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1551, N'42-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1552, N'42-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1553, N'43-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1554, N'43-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1555, N'43-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1556, N'43-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1557, N'43-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1558, N'43-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1559, N'43-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1560, N'43-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1561, N'43-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1562, N'43-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1563, N'43-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1564, N'43-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1565, N'43-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1566, N'43-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1567, N'43-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1568, N'44-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1569, N'44-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1570, N'44-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1571, N'44-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1572, N'44-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1573, N'44-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1574, N'44-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1575, N'44-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1576, N'44-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1577, N'44-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1578, N'44-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1579, N'44-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1580, N'44-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1581, N'44-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1582, N'44-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1583, N'45-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1584, N'45-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1585, N'45-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1586, N'45-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1587, N'45-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1588, N'45-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1589, N'45-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1590, N'45-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1591, N'45-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1592, N'45-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1593, N'46-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1594, N'46-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1595, N'46-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1596, N'46-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1597, N'46-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1598, N'46-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1599, N'46-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1600, N'46-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1601, N'46-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1602, N'46-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1603, N'46-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1604, N'46-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1605, N'46-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1606, N'46-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1607, N'46-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1608, N'47-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1609, N'47-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1610, N'47-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1611, N'47-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1612, N'47-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1613, N'47-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1614, N'47-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1615, N'47-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1616, N'47-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1617, N'47-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1618, N'47-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1619, N'47-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1620, N'47-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1621, N'47-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1622, N'47-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1623, N'48-01', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1624, N'48-02', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1625, N'48-03', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1626, N'48-04', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1627, N'48-05', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1628, N'48-06', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1629, N'48-07', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1630, N'48-08', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1631, N'48-09', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1632, N'48-10', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1633, N'48-11', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1634, N'48-12', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1635, N'48-13', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1636, N'48-14', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
INSERT [dbo].[EWIP_LOCATIONS] ([ID], [CODE], [STOCK_CODE], [DEPT_CODE], [UPDATE_DATE]) VALUES (1637, N'48-15', N'SMT_K1', N'SMT', CAST(N'2021-06-24' AS Date))
GO
SET IDENTITY_INSERT [dbo].[EWIP_LOCATIONS] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_SP_STOCKIN] ON 
GO
INSERT [dbo].[EWIP_SP_STOCKIN] ([ID], [SPARE_PART_CODE], [STOCK_IN_CODE], [QUANTITY], [PRICE_VN], [UNIT_CODE], [VENDER_ID], [STOCK_CODE], [CAUSE], [DEPT_CODE], [DATE_IN], [USER_ID], [AMOUNT_US], [AMOUNT_VN], [NOTE], [YEAR], [MONTH], [PRICE_US], [TYPE_IN_CODE]) VALUES (8, N'03078556-01', N'15A9D9E6-D41D-4F5E-8D43-77192ACC68C1', 1, 0, N'EA', N'ASM', N'SMT_K1', N'', N'SMT', CAST(N'2021-07-09' AS Date), N'', 0, 0, N'', 2021, 7, 0, N'1')
GO
INSERT [dbo].[EWIP_SP_STOCKIN] ([ID], [SPARE_PART_CODE], [STOCK_IN_CODE], [QUANTITY], [PRICE_VN], [UNIT_CODE], [VENDER_ID], [STOCK_CODE], [CAUSE], [DEPT_CODE], [DATE_IN], [USER_ID], [AMOUNT_US], [AMOUNT_VN], [NOTE], [YEAR], [MONTH], [PRICE_US], [TYPE_IN_CODE]) VALUES (12, N'CP-0005', N'3DD257E2-D21C-42AB-8C3D-42FF4701E292', 80, 0, N'PACK', N'BANICO', N'SMT_K1', N'', N'SMT', CAST(N'2021-07-10' AS Date), N'', 0, 0, N'', 2021, 7, 0, N'1')
GO
INSERT [dbo].[EWIP_SP_STOCKIN] ([ID], [SPARE_PART_CODE], [STOCK_IN_CODE], [QUANTITY], [PRICE_VN], [UNIT_CODE], [VENDER_ID], [STOCK_CODE], [CAUSE], [DEPT_CODE], [DATE_IN], [USER_ID], [AMOUNT_US], [AMOUNT_VN], [NOTE], [YEAR], [MONTH], [PRICE_US], [TYPE_IN_CODE]) VALUES (13, N'CP-0003', N'5102BE03-9EA2-491C-960E-D95515E57C15', 2, 0, N'PACK', N'TOANTHINH', N'SMT_K1', N'', N'SMT', CAST(N'2021-07-10' AS Date), N'', 0, 0, N'', 2021, 7, 0, N'1')
GO
INSERT [dbo].[EWIP_SP_STOCKIN] ([ID], [SPARE_PART_CODE], [STOCK_IN_CODE], [QUANTITY], [PRICE_VN], [UNIT_CODE], [VENDER_ID], [STOCK_CODE], [CAUSE], [DEPT_CODE], [DATE_IN], [USER_ID], [AMOUNT_US], [AMOUNT_VN], [NOTE], [YEAR], [MONTH], [PRICE_US], [TYPE_IN_CODE]) VALUES (14, N'CP-0003', N'DD033B08-E683-47F6-AD31-7DFF581ED6C0', 1, 0, N'PACK', N'TOANTHINH', N'SMT_K1', N'', N'SMT', CAST(N'2021-07-10' AS Date), N'', 0, 0, N'', 2021, 7, 0, N'1')
GO
INSERT [dbo].[EWIP_SP_STOCKIN] ([ID], [SPARE_PART_CODE], [STOCK_IN_CODE], [QUANTITY], [PRICE_VN], [UNIT_CODE], [VENDER_ID], [STOCK_CODE], [CAUSE], [DEPT_CODE], [DATE_IN], [USER_ID], [AMOUNT_US], [AMOUNT_VN], [NOTE], [YEAR], [MONTH], [PRICE_US], [TYPE_IN_CODE]) VALUES (16, N'CP-0027', N'9A6A343C-0670-4FB2-9797-D5A1CAF35BDB', 50, 0, N'REEL', N'COSMO', N'SMT_K1', N'', N'SMT', CAST(N'2021-07-14' AS Date), N'', 0, 0, N'', 2021, 7, 0, N'1')
GO
INSERT [dbo].[EWIP_SP_STOCKIN] ([ID], [SPARE_PART_CODE], [STOCK_IN_CODE], [QUANTITY], [PRICE_VN], [UNIT_CODE], [VENDER_ID], [STOCK_CODE], [CAUSE], [DEPT_CODE], [DATE_IN], [USER_ID], [AMOUNT_US], [AMOUNT_VN], [NOTE], [YEAR], [MONTH], [PRICE_US], [TYPE_IN_CODE]) VALUES (17, N'CP-0002', N'C13E476E-0B0D-43D3-B84D-9F39526BAE9C', 1, 0, N'PACK', N'TOANTHINH', N'SMT_K1', N'', N'SMT', CAST(N'2021-07-14' AS Date), N'', 0, 0, N'', 2021, 7, 0, N'1')
GO
INSERT [dbo].[EWIP_SP_STOCKIN] ([ID], [SPARE_PART_CODE], [STOCK_IN_CODE], [QUANTITY], [PRICE_VN], [UNIT_CODE], [VENDER_ID], [STOCK_CODE], [CAUSE], [DEPT_CODE], [DATE_IN], [USER_ID], [AMOUNT_US], [AMOUNT_VN], [NOTE], [YEAR], [MONTH], [PRICE_US], [TYPE_IN_CODE]) VALUES (20, N'CP-0004', N'B2B5D67D-FF79-44A5-B1FB-3C0D64644442', 477, 0, N'ROLL', N'LORIOT', N'SMT_K1', N'', N'SMT', CAST(N'2021-07-13' AS Date), N'', 0, 0, N'', 2021, 7, 0, N'1')
GO
INSERT [dbo].[EWIP_SP_STOCKIN] ([ID], [SPARE_PART_CODE], [STOCK_IN_CODE], [QUANTITY], [PRICE_VN], [UNIT_CODE], [VENDER_ID], [STOCK_CODE], [CAUSE], [DEPT_CODE], [DATE_IN], [USER_ID], [AMOUNT_US], [AMOUNT_VN], [NOTE], [YEAR], [MONTH], [PRICE_US], [TYPE_IN_CODE]) VALUES (21, N'PL-108AL', N'269F5272-6166-4691-BDA0-7ACCCE905E87', 150, 0, N'BOX', N'INTRADING', N'SMT_K1', N'', N'SMT', CAST(N'2021-07-17' AS Date), N'H2105001', 0, 0, N'', 2021, 7, 0, N'1')
GO
SET IDENTITY_INSERT [dbo].[EWIP_SP_STOCKIN] OFF
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'00328369', N'212101')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'00334073-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'00343774-03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'00355386-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'00359505-02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'00388764-03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'0041017S03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03002898-02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03007696-02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03013018S01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03013091S02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03013307-03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03015840-03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03015854-03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03015869-03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03034148-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03039368-03', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03042001S02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03046348-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03054812-02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03056499-03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03058627S06', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03060794S01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03067289S02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03068745', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03071039-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03071883-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03072785-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03078556-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03078561-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03079145-03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03098748-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03099720-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03101402S01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03101981-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03102344-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03102457-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03102459-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03102963-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03103544-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03103553-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03104247S02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03105714-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03106244-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03106620-02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03107579-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03115821-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03115853-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03121197-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03133662-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03149490S02', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03149630-03', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03153682S04', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03157505S01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'03215882-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'1016013-04', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5002-458-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5004-257-02-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5004-281-02-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5004-299-02-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5004-312-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5004-316-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5006-158-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5006-159-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5006-160-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5008-473-01-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5008-511-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5026-056-00-1', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5026-171-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5041-208-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5051-180-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5059-039-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5999-337-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-5999-339-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-6002-002-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8015-197-06-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-240-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-320-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-486-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-609-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-735-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-736-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-739-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-740-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-744-01-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-744-03-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-770-01-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2-8999-810-00-0', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'2W-250-25', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'3322K', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'33967', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'3863K', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'4491K', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'57017605', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'5749K', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'5775K', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'581328', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'593556', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'594533', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'59485302', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'602012-000010', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'7179K', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'7448K', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'8002562', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'8237K', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'825-0019-2R D', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'A1D00388590-01', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'AQ2B20-10D', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'ARJ210-M5BG', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'BEN10M-TFR2', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'BEN5M-MFR', N'212101')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'BYD3M-TDT1', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CDM2B20-400AZ', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CM2B20-15', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0002', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0003', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0004', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0005', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0006', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0007', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0008', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0009', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0010', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0011', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0012', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0013', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0014', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0015', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0016', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0017', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0018', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0019', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0020', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0021', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0022', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0023', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0024', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0026', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0027', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0028', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0029', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0030', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0031', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0032', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0033', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0034', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0035', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0037', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0038', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0039', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0040', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0041', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0042', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0043', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0044', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0045', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0046', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0047', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0051', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0052', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0053', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0054', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0055', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0056', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0068', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0069', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0070', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0071', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0072', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0073', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0074', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0078', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0080', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0081', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0082', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0083', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0084', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0085', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0086', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0087', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0089', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0090', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0094', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0095', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0096', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0097', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0098', N'212101')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0099', N'212101')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0100', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0101', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0102', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0103', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CP-0104', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CSP4-900-023-A', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'CSP8-290-011-A', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'D-A73', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'D-A93', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'DMF-45125 SH', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'DP-100', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'DS6878-SR20007WR', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'E3S-LS3N', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'E3T-SL11', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'FP0-E32T', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'ICR620S-T11503', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'KGT - M8895 - 00', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'KHY-M7151-032', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'LS2208-SR20007R-UR', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'MY 1B 1G-350-CJJM1667', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'N78/ MATYPM CDH 9300083', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'NMS50-AO', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'OIK3GN-D', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'OP-0001', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'P/N 180-100-50', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'P/N 85-150-500', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'P/N 90-150-705', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'PL-108AL', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'PM-Y44P-C3GL21', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'RT-3700', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SF210-IP', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0004', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0005', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0007', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0009', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0012', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0013', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0014', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0015', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0024', N'212101')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0025', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0026', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0028', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0029', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0030', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0031', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0032', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0033', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0034', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0035', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0036', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0037', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0038', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0039', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0040', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0041', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0042', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0043', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0044', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0045', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0046', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0047', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0048', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0049', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0050', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0051', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0052', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0053', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0054', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0055', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0056', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0057', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0058', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0059', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0060', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0061', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0062', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0063', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SP-0064', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'SZR-LY2-N1', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'TG-3269', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'TL-T70', N'211001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'TZE2312PK', N'212001')
GO
INSERT [dbo].[EWIP_SPARE_PART_DEPT] ([DEPT_CODE], [SPARE_PART_CODE], [COST_CTR]) VALUES (N'SMT', N'UF-12A23', N'211001')
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_CONDITION] ON 
GO
INSERT [dbo].[EWIP_SPAREPART_CONDITION] ([ID], [CODE], [NAME]) VALUES (1, N'OK', N'OK')
GO
INSERT [dbo].[EWIP_SPAREPART_CONDITION] ([ID], [CODE], [NAME]) VALUES (2, N'NG', N'NG')
GO
INSERT [dbo].[EWIP_SPAREPART_CONDITION] ([ID], [CODE], [NAME]) VALUES (3, N'NEW', N'NEW')
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_CONDITION] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ON 
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (1, N'00343774-03', 1, N'PACK', 1, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (2, N'00359505-02', 8, N'REEL', 10, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (3, N'03015840-03', 40, N'PACK', 40, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (4, N'03015854-03', 14, N'PACK', 14, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (5, N'03015869-03', 64, N'PACK', 64, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (6, N'03054812-02', 8, N'PACK', 8, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (7, N'03099720-01', 67, N'PACK', 67, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (8, N'03101981-01', 82, N'PACK', 92, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (9, N'03102344-01', 176, N'PACK', 176, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (10, N'03102457-01', 102, N'PACK', 102, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (11, N'03102459-01', 35, N'PACK', 35, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (12, N'03102963-01', 42, N'PACK', 42, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (13, N'03103544-01', 27, N'PACK', 27, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (14, N'03103553-01', 84, N'PACK', 99, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (15, N'03105714-01', 8, N'PACK', 8, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (16, N'03107579-01', 5, N'PACK', 5, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (17, N'03115821-01', 43, N'PACK', 43, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (18, N'03115853-01', 23, N'PACK', 23, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (19, N'03133662-01', 34, N'PACK', 34, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (20, N'CP-0002', 153, N'PACK', 182, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-15' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (21, N'CP-0003', 188, N'PACK', 213, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-15' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (22, N'CP-0004', 802, N'ROLL', 429, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-15' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (23, N'CP-0005', 74, N'PACK', 24, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-15' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (24, N'CP-0006', 1, N'PACK', 1, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (25, N'CP-0007', 414, N'LIT', 580.5, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-15' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (26, N'CP-0008', 62, N'PACK', 96, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-15' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (27, N'CP-0009', 16, N'PACK', 16, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (28, N'CP-0010', 0.33333333333333331, N'PACK', 0.33333333333333331, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (29, N'CP-0011', 34, N'PACK', 34, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (30, N'CP-0012', 0, N'ROLL', 3, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-12' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (31, N'CP-0013', 2.5, N'PACK', 2.5, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (32, N'CP-0014', 1.3333333333333333, N'PACK', 1.3333333333333333, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (33, N'CP-0015', 1.3, N'PACK', 1.3, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (34, N'CP-0016', 2.333333333333333, N'PACK', 2.333333333333333, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (35, N'CP-0017', 2, N'PACK', 2, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (36, N'CP-0018', 0.30000000000000004, N'PACK', 0.30000000000000004, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (37, N'CP-0019', 6.833333333333333, N'PACK', 6.833333333333333, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (38, N'CP-0020', 46, N'ROLL', 47, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (39, N'CP-0021', 6, N'PACK', 6, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (40, N'CP-0022', 192, N'ROLL', 262, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-12' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (41, N'CP-0023', 4, N'PACK', 4, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (42, N'CP-0024', 16, N'ROLL', 19, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (43, N'CP-0025', 29, N'PACK', 29, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (44, N'CP-0026', 5, N'PACK', 5, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (45, N'CP-0027', 53, N'REEL', 12, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-14' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (46, N'CP-0028', 7, N'PACK', 7, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (47, N'CP-0029', 4, N'PACK', 4, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (48, N'CP-0030', 19, N'ROLL', 21, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-12' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (49, N'CP-0031', 6, N'PACK', 6, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (50, N'CP-0032', 19, N'REEL', 20, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (51, N'CP-0033', 5, N'PACK', 5, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (52, N'CP-0034', 2, N'REEL', 3, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (53, N'CP-0035', 41, N'EA', 44, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (54, N'CP-0036', 6, N'PACK', 6, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (55, N'CP-0039', 16, N'PACK', 16, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (56, N'CP-0040', 12, N'EA', 13, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (57, N'CP-0041', 35, N'PACK', 35, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (58, N'CP-0042', 1.8, N'PACK', 1.8, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (59, N'CP-0043', 4, N'PACK', 4, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (60, N'CP-0044', 29, N'PACK', 29, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (61, N'CP-0045', 7, N'PACK', 8, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (62, N'CP-0046', 1, N'PACK', 3, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-10' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (63, N'CP-0047', 5, N'PACK', 5, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (64, N'CP-0048', 10, N'PACK', 10, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (65, N'CP-0049', 3, N'PACK', 3, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (66, N'CP-0050', 5, N'PACK', 5, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (67, N'CP-0051', 1, N'PACK', 1, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (68, N'CP-0052', 1, N'PACK', 1, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (69, N'CP-0053', 100, N'PACK', 100, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (70, N'CP-0054', 1, N'PACK', 1, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (71, N'CP-0055', 11.200000000000001, N'PACK', 11.200000000000001, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (72, N'CP-0056', 3, N'PACK', 3, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (73, N'N78/ MATYPM CDH 9300083', 79, N'PACK', 99, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-15' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (74, N'Pentel NMS50', 22, N'PACK', 22, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (75, N'PL-108AL', 169, N'BOX', 57, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), CAST(N'2021-07-17' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (76, N'SP-0004', 8, N'PACK', 8, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (77, N'2-8999-810-00-0', 0, N'EA', NULL, N'SMT', N'SMT_K1', CAST(N'2021-07-09' AS Date), CAST(N'2021-07-09' AS Date), N'H1506001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (78, N'03071039-01', 0, N'EA', NULL, N'SMT', N'SMT_K1', CAST(N'2021-07-09' AS Date), CAST(N'2021-07-09' AS Date), N'')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (79, N'03078556-01', 1, N'EA', NULL, N'SMT', N'SMT_K1', CAST(N'2021-07-09' AS Date), CAST(N'2021-07-09' AS Date), N'H1506001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (80, N'2-8999-735-00-0', 0, N'EA', NULL, N'SMT', N'SMT_K1', CAST(N'2021-07-09' AS Date), CAST(N'2021-07-09' AS Date), N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (81, N'NMS50-AO', 19, N'BOX', NULL, N'SMT', N'SMT_K1', CAST(N'2021-07-10' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (83, N'P/N 85-150-500', 10, N'EA', 10, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (84, N'P/N 90-150-705', 3, N'EA', 3, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
INSERT [dbo].[EWIP_SPAREPART_INVENTORY] ([ID], [SPARE_PART_CODE], [QUANTITY], [UNIT_IN_CODE], [QUANTITY_REAL], [DEPT_CODE], [STOCK_CODE], [CREATE_DATE], [UPDATE_DATE], [USER_UPDATE]) VALUES (85, N'P/N 180-100-50', 5, N'EA', 5, N'SMT', N'SMT_K1', CAST(N'2021-06-30' AS Date), NULL, N'H2105001')
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_INVENTORY] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_LOCATION] ON 
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (1, N'CP-0002', N'21-01', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (2, N'CP-0002', N'21-02', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (3, N'CP-0002', N'21-03', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (4, N'CP-0002', N'21-04', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (5, N'CP-0002', N'21-05', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (6, N'CP-0002', N'21-06', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (7, N'CP-0002', N'21-07', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (8, N'CP-0002', N'21-08', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-08', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (9, N'CP-0002', N'21-09', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-09', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (10, N'CP-0002', N'21-10', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.21-10', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (11, N'CP-0002', N'22-01', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (12, N'CP-0002', N'22-02', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (13, N'CP-0002', N'22-03', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (14, N'CP-0002', N'22-04', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (15, N'CP-0002', N'22-05', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (16, N'CP-0002', N'22-06', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (17, N'CP-0002', N'22-07', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (18, N'CP-0002', N'22-08', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-08', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (19, N'CP-0002', N'22-09', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-09', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (20, N'CP-0002', N'22-10', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-10', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (21, N'CP-0002', N'22-11', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-11', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (22, N'CP-0002', N'22-12', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-12', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (23, N'CP-0002', N'22-13', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-13', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (24, N'CP-0002', N'22-14', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-14', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (25, N'CP-0002', N'22-15', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.22-15', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (26, N'CP-0002', N'23-01', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.23-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (27, N'CP-0002', N'23-02', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.23-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (28, N'CP-0002', N'23-03', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.23-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (29, N'CP-0002', N'23-04', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.23-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (30, N'CP-0002', N'23-05', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0002.23-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (31, N'CP-0002', N'23-06', N'OK', 0, 0, N'SMT', N'SMT_K1', N'CP-0002.23-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (32, N'CP-0002', N'23-07', N'OK', 0, 1, N'SMT', N'SMT_K1', N'CP-0002.23-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (33, N'CP-0002', N'23-08', N'OK', 0, 1, N'SMT', N'SMT_K1', N'CP-0002.23-08', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (34, N'CP-0002', N'23-09', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.23-09', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (35, N'CP-0002', N'23-10', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.23-10', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (36, N'CP-0002', N'23-11', N'OK', 0, 0, N'SMT', N'SMT_K1', N'CP-0002.23-11', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (37, N'CP-0002', N'23-12', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0002.23-12', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (38, N'CP-0002', N'23-13', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.23-13', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (39, N'CP-0002', N'23-14', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.23-14', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (40, N'CP-0002', N'23-15', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.23-15', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (41, N'CP-0002', N'24-01', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (42, N'CP-0002', N'24-02', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (43, N'CP-0002', N'24-03', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (44, N'CP-0002', N'24-04', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (45, N'CP-0002', N'24-05', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (46, N'CP-0002', N'24-06', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (47, N'CP-0002', N'24-07', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (48, N'CP-0002', N'24-08', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-08', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (49, N'CP-0002', N'24-09', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-09', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (50, N'CP-0002', N'24-10', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-10', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (51, N'CP-0002', N'24-11', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-11', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (52, N'CP-0002', N'24-12', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-12', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (53, N'CP-0002', N'24-13', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-13', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (54, N'CP-0002', N'24-14', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-14', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (55, N'CP-0002', N'24-15', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0002.24-15', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (57, N'CP-0003', N'17-01', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (58, N'CP-0003', N'17-02', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (59, N'CP-0003', N'17-03', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (60, N'CP-0003', N'17-04', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (61, N'CP-0003', N'17-05', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (62, N'CP-0003', N'17-06', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (63, N'CP-0003', N'17-07', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (64, N'CP-0003', N'17-08', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-08', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (65, N'CP-0003', N'17-09', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-09', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (66, N'CP-0003', N'17-10', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.17-10', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (67, N'CP-0003', N'18-01', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (68, N'CP-0003', N'18-02', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (69, N'CP-0003', N'18-03', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (70, N'CP-0003', N'18-04', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (72, N'CP-0003', N'18-06', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (73, N'CP-0003', N'18-07', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (74, N'CP-0003', N'18-08', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-08', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (75, N'CP-0003', N'18-09', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-09', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (77, N'CP-0003', N'18-11', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-11', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (78, N'CP-0003', N'18-12', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-12', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (79, N'CP-0003', N'18-13', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-13', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (80, N'CP-0003', N'18-14', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-14', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (81, N'CP-0003', N'18-15', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-15', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (82, N'CP-0003', N'19-01', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (83, N'CP-0003', N'19-02', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (84, N'CP-0003', N'19-03', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (85, N'CP-0003', N'19-04', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (86, N'CP-0003', N'19-05', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (87, N'CP-0003', N'19-06', N'OK', 0, 1, N'SMT', N'SMT_K1', N'CP-0003.19-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (88, N'CP-0003', N'19-07', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (89, N'CP-0003', N'19-08', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-08', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (90, N'CP-0003', N'19-09', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-09', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (91, N'CP-0003', N'19-10', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-10', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (92, N'CP-0003', N'19-11', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-11', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (93, N'CP-0003', N'19-12', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-12', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (94, N'CP-0003', N'19-13', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-13', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (95, N'CP-0003', N'19-14', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-14', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (96, N'CP-0003', N'19-15', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.19-15', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (97, N'CP-0003', N'20-01', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (98, N'CP-0003', N'20-02', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (99, N'CP-0003', N'20-03', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (100, N'CP-0003', N'20-04', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (101, N'CP-0003', N'20-05', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (102, N'CP-0003', N'20-06', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (103, N'CP-0003', N'20-07', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (104, N'CP-0003', N'20-08', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-08', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (105, N'CP-0003', N'20-09', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-09', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (106, N'CP-0003', N'20-10', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-10', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (107, N'CP-0003', N'20-11', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-11', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (108, N'CP-0003', N'20-12', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-12', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (109, N'CP-0003', N'20-13', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-13', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (110, N'CP-0003', N'20-14', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-14', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (111, N'CP-0003', N'20-15', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.20-15', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (112, N'CP-0003', N'', N'OK', 1, 79, N'SMT', N'SMT_K1', N'CP-0003', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (113, N'CP-0004', N'37-01', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-01', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (114, N'CP-0004', N'37-02', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (115, N'CP-0004', N'37-03', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-03', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (116, N'CP-0004', N'37-04', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-04', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (117, N'CP-0004', N'37-05', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (118, N'CP-0004', N'37-06', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (119, N'CP-0004', N'37-07', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-07', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (120, N'CP-0004', N'37-08', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (121, N'CP-0004', N'37-09', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (122, N'CP-0004', N'37-10', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.37-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (123, N'CP-0004', N'38-01', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-01', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (124, N'CP-0004', N'38-02', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (125, N'CP-0004', N'38-03', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-03', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (126, N'CP-0004', N'38-04', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-04', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (127, N'CP-0004', N'38-05', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (128, N'CP-0004', N'38-06', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (129, N'CP-0004', N'38-07', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-07', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (130, N'CP-0004', N'38-08', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (131, N'CP-0004', N'38-09', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (132, N'CP-0004', N'38-10', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (133, N'CP-0004', N'38-11', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-11', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (134, N'CP-0004', N'38-12', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-12', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (135, N'CP-0004', N'38-13', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-13', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (136, N'CP-0004', N'38-14', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-14', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (137, N'CP-0004', N'38-15', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.38-15', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (138, N'CP-0004', N'39-01', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-01', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (139, N'CP-0004', N'39-02', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (140, N'CP-0004', N'39-03', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-03', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (141, N'CP-0004', N'39-04', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-04', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (142, N'CP-0004', N'39-05', N'OK', 0, 7, N'SMT', N'SMT_K1', N'CP-0004.39-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (143, N'CP-0004', N'39-06', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (144, N'CP-0004', N'39-07', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-07', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (145, N'CP-0004', N'39-08', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (146, N'CP-0004', N'39-09', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (147, N'CP-0004', N'39-10', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (148, N'CP-0004', N'39-11', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-11', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (149, N'CP-0004', N'39-12', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-12', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (150, N'CP-0004', N'39-13', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-13', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (151, N'CP-0004', N'39-14', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-14', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (152, N'CP-0004', N'39-15', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.39-15', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (153, N'CP-0004', N'40-01', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-01', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (154, N'CP-0004', N'40-02', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (155, N'CP-0004', N'40-03', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-03', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (156, N'CP-0004', N'40-04', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-04', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (157, N'CP-0004', N'40-05', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (158, N'CP-0004', N'40-06', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (159, N'CP-0004', N'40-07', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-07', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (160, N'CP-0004', N'40-08', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (161, N'CP-0004', N'40-09', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (162, N'CP-0004', N'34-02', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (163, N'CP-0004', N'40-11', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-11', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (164, N'CP-0004', N'40-12', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-12', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (165, N'CP-0004', N'40-13', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-13', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (166, N'CP-0004', N'40-14', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-14', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (167, N'CP-0004', N'40-15', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-15', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (168, N'CP-0005', N'35-01', N'OK', 0, 30, N'SMT', N'SMT_K1', N'CP-0005.35-01', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (169, N'CP-0005', N'35-02', N'OK', 0, 0, N'SMT', N'SMT_K1', N'CP-0005.35-02', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (170, N'CP-0005', N'35-03', N'OK', 0, 0, N'SMT', N'SMT_K1', N'CP-0005.35-03', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (171, N'CP-0005', N'35-04', N'OK', 0, 50, N'SMT', N'SMT_K1', N'CP-0005.35-04', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (172, N'CP-0005', N'35-05', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-05', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (173, N'CP-0005', N'35-06', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-06', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (174, N'CP-0005', N'35-07', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-07', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (175, N'CP-0005', N'35-08', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-08', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (176, N'CP-0005', N'35-09', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-09', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (177, N'CP-0005', N'35-10', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-10', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (178, N'CP-0005', N'35-11', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-11', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (179, N'CP-0005', N'35-12', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-12', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (180, N'CP-0005', N'35-13', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-13', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (181, N'CP-0005', N'35-14', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-14', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (182, N'CP-0005', N'35-15', N'OK', 0, 60, N'SMT', N'SMT_K1', N'CP-0005.35-15', N'PAIR', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (183, N'PL-108AL', N'36-12', N'OK', 0, 12, N'SMT', N'SMT_K1', N'PL-108AL.36-12', N'BOX', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (184, N'PL-108AL', N'36-13', N'OK', 0, 0, N'SMT', N'SMT_K1', N'PL-108AL.36-13', N'BOX', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (185, N'PL-108AL', N'36-14', N'OK', 0, 0, N'SMT', N'SMT_K1', N'PL-108AL.36-14', N'BOX', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (186, N'PL-108AL', N'36-15', N'OK', 0, 7, N'SMT', N'SMT_K1', N'PL-108AL.36-15', N'BOX', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (187, N'CP-0006', N'33-04', N'OK', 0, 1000, N'SMT', N'SMT_K1', N'CP-0006.33-04', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (188, N'N78/ MATYPM CDH 9300083', N'36-01', N'OK', 0, 3, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (189, N'N78/ MATYPM CDH 9300083', N'36-02', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (190, N'N78/ MATYPM CDH 9300083', N'36-03', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (191, N'N78/ MATYPM CDH 9300083', N'36-04', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (192, N'N78/ MATYPM CDH 9300083', N'36-05', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (193, N'N78/ MATYPM CDH 9300083', N'36-06', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (194, N'N78/ MATYPM CDH 9300083', N'36-07', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (195, N'N78/ MATYPM CDH 9300083', N'36-08', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-08', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (196, N'N78/ MATYPM CDH 9300083', N'36-09', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-09', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (197, N'N78/ MATYPM CDH 9300083', N'36-10', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-10', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (198, N'N78/ MATYPM CDH 9300083', N'36-11', N'OK', 0, 6, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083.36-11', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (199, N'N78/ MATYPM CDH 9300083', N'', N'OK', 1, 16, N'SMT', N'SMT_K1', N'N78/ MATYPM CDH 9300083', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (200, N'CP-0007', NULL, N'OK', 1, 414, N'SMT', N'SMT_K1', N'CP-0007', N'LIT', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (201, N'CP-0008', N'26-01', N'OK', 0, 0, N'SMT', N'SMT_K1', N'CP-0008.26-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (202, N'CP-0008', N'26-02', N'OK', 0, 12, N'SMT', N'SMT_K1', N'CP-0008.26-02', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (203, N'CP-0008', N'26-03', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0008.26-03', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (204, N'CP-0008', N'26-04', N'OK', 0, 12, N'SMT', N'SMT_K1', N'CP-0008.26-04', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (205, N'CP-0008', N'26-05', N'OK', 0, 12, N'SMT', N'SMT_K1', N'CP-0008.26-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (206, N'CP-0008', N'26-06', N'OK', 0, 12, N'SMT', N'SMT_K1', N'CP-0008.26-06', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (207, N'CP-0008', N'26-07', N'OK', 0, 12, N'SMT', N'SMT_K1', N'CP-0008.26-07', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (208, N'CP-0008', N'27-01', N'OK', 0, 0, N'SMT', N'SMT_K1', N'CP-0008.27-01', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (209, N'CP-0009', N'42-10', N'OK', 0, 16, N'SMT', N'SMT_K1', N'CP-0009.42-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (210, N'CP-0010', N'44-12', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0010.44-12', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (211, N'CP-0011', N'42-01', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.42-01', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (212, N'CP-0011', N'42-02', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.42-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (213, N'CP-0011', N'42-03', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.42-03', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (214, N'CP-0011', N'42-04', N'OK', 0, 5, N'SMT', N'SMT_K1', N'CP-0011.42-04', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (215, N'CP-0011', N'42-05', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.42-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (216, N'CP-0011', N'42-06', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0011.42-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (217, N'CP-0011', N'43-01', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-01', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (218, N'CP-0011', N'43-02', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (219, N'CP-0011', N'43-03', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0011.43-03', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (220, N'CP-0011', N'43-04', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-04', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (221, N'CP-0011', N'43-05', N'OK', 0, 0, N'SMT', N'SMT_K1', N'CP-0011.43-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (222, N'CP-0011', N'43-06', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (223, N'CP-0011', N'43-07', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-07', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (224, N'CP-0011', N'43-08', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (225, N'CP-0011', N'43-09', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0011.43-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (226, N'CP-0011', N'43-10', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (227, N'CP-0011', N'43-11', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-11', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (228, N'CP-0011', N'43-12', N'OK', 0, 0, N'SMT', N'SMT_K1', N'CP-0011.43-12', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (229, N'CP-0011', N'43-13', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-13', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (230, N'CP-0011', N'43-14', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-14', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (231, N'CP-0011', N'43-15', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0011.43-15', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (232, N'CP-0012', N'44-13', N'OK', 0, 0, N'SMT', N'SMT_K1', N'CP-0012.44-13', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (233, N'CP-0013', N'41-10', N'OK', 0, 15, N'SMT', N'SMT_K1', N'CP-0013.41-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (234, N'CP-0014', N'41-09', N'OK', 0, 4, N'SMT', N'SMT_K1', N'CP-0014.41-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (235, N'CP-0015', N'42-10', N'OK', 0, 13, N'SMT', N'SMT_K1', N'CP-0015.42-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (236, N'CP-0016', N'42-13', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0016.42-13', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (237, N'CP-0016', N'42-14', N'OK', 0, 11, N'SMT', N'SMT_K1', N'CP-0016.42-14', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (238, N'CP-0017', N'42-15', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0017.42-15', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (239, N'CP-0018', N'42-10', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0018.42-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (240, N'CP-0019', N'41-05', N'OK', 0, 16, N'SMT', N'SMT_K1', N'CP-0019.41-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (241, N'CP-0019', N'41-06', N'OK', 0, 17, N'SMT', N'SMT_K1', N'CP-0019.41-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (242, N'CP-0019', N'41-07', N'OK', 0, 8, N'SMT', N'SMT_K1', N'CP-0019.41-07', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (243, N'CP-0020', N'41-03', N'OK', 0, 8, N'SMT', N'SMT_K1', N'CP-0020.41-03', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (244, N'CP-0020', N'41-04', N'OK', 0, 13, N'SMT', N'SMT_K1', N'CP-0020.41-04', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (245, N'CP-0020', N'41-01', N'OK', 0, 14, N'SMT', N'SMT_K1', N'CP-0020.41-01', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (246, N'CP-0020', N'41-02', N'OK', 0, 11, N'SMT', N'SMT_K1', N'CP-0020.41-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (247, N'CP-0021', N'44-10', N'OK', 0, 1, N'SMT', N'SMT_K1', N'CP-0021.44-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (248, N'CP-0021', N'44-11', N'OK', 0, 5, N'SMT', N'SMT_K1', N'CP-0021.44-11', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (249, N'CP-0022', N'44-07', N'OK', 0, 28, N'SMT', N'SMT_K1', N'CP-0022.44-07', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (250, N'CP-0022', N'44-08', N'OK', 0, 28, N'SMT', N'SMT_K1', N'CP-0022.44-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (251, N'CP-0022', N'44-09', N'OK', 0, 56, N'SMT', N'SMT_K1', N'CP-0022.44-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (252, N'CP-0022', N'44-06', N'OK', 0, 80, N'SMT', N'SMT_K1', N'CP-0022.44-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (253, N'CP-0023', N'42-07', N'OK', 0, 4, N'SMT', N'SMT_K1', N'CP-0023.42-07', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (254, N'CP-0023', N'42-08', N'OK', 0, 15, N'SMT', N'SMT_K1', N'CP-0023.42-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (255, N'CP-0023', N'42-09', N'OK', 0, 5, N'SMT', N'SMT_K1', N'CP-0023.42-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (256, N'CP-0024', N'42-12', N'OK', 0, 16, N'SMT', N'SMT_K1', N'CP-0024.42-12', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (257, N'KGT - M8895 - 00', N'42-11', N'OK', 0, 29, N'SMT', N'SMT_K1', N'CP-0025.42-11', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (258, N'00343774-03', N'03-06', N'OK', 0, 1, N'SMT', N'SMT_K1', N'00343774-03.03-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (259, N'NMS50-AO', N'46-11', N'OK', 0, 19, N'SMT', N'SMT_K1', N'NMS50-AO.46-11', N'BOX', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (260, N'CP-0026', N'41-08', N'OK', 0, 5, N'SMT', N'SMT_K1', N'CP-0026.41-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (261, N'CP-0027', N'46-04', N'OK', 0, 9, N'SMT', N'SMT_K1', N'CP-0027.46-04', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (262, N'CP-0027', N'46-05', N'OK', 0, 9, N'SMT', N'SMT_K1', N'CP-0027.46-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (263, N'CP-0028', N'46-02', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0028.46-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (264, N'CP-0028', N'46-03', N'OK', 0, 4, N'SMT', N'SMT_K1', N'CP-0028.46-03', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (265, N'CP-0029', N'26-08', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0029.26-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (266, N'CP-0029', N'26-09', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0029.26-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (267, N'CP-0030', N'47-05', N'OK', 0, 1, N'SMT', N'SMT_K1', N'CP-0030.47-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (268, N'CP-0030', N'47-06', N'OK', 0, 18, N'SMT', N'SMT_K1', N'CP-0030.47-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (269, N'CP-0031', N'46-01', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0031.46-01', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (270, N'CP-0032', N'33-02', N'OK', 0, 19, N'SMT', N'SMT_K1', N'CP-0032.33-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (271, N'CP-0033', N'33-02', N'OK', 0, 5, N'SMT', N'SMT_K1', N'CP-0033.33-02', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (272, N'CP-0034', NULL, N'OK', 1, 2, N'SMT', N'SMT_K1', N'CP-0034', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (273, N'CP-0035', N'33-07', N'OK', 0, 41, N'SMT', N'SMT_K1', N'CP-0035.33-07', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (274, N'TZE2312PK', N'33-09', N'OK', 0, 6, N'SMT', N'SMT_K1', N'CP-0036.33-09', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (275, N'CP-0039', N'33-10', N'OK', 0, 16, N'SMT', N'SMT_K1', N'CP-0039.33-10', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (276, N'CP-0040', N'26-14', N'OK', 0, 12, N'SMT', N'SMT_K1', N'CP-0040.26-14', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (277, N'CP-0041', N'45-01', N'OK', 0, 11, N'SMT', N'SMT_K1', N'CP-0041.45-01', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (278, N'CP-0041', N'45-02', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0041.45-02', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (279, N'CP-0041', N'45-04', N'OK', 0, 14, N'SMT', N'SMT_K1', N'CP-0041.45-04', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (280, N'CP-0042', N'25-04', N'OK', 0, 18, N'SMT', N'SMT_K1', N'CP-0042.25-04', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (281, N'CP-0043', N'25-01', N'OK', 0, 20, N'SMT', N'SMT_K1', N'CP-0043.25-01', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (282, N'CP-0043', N'25-02', N'OK', 0, 20, N'SMT', N'SMT_K1', N'CP-0043.25-02', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (283, N'CP-0044', N'09-04', N'OK', 0, 29, N'SMT', N'SMT_K1', N'CP-0044.09-04', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (284, N'CP-0045', N'47-13', N'OK', 0, 7, N'SMT', N'SMT_K1', N'CP-0045.47-13', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (285, N'CP-0046', N'47-14', N'OK', 0, 1, N'SMT', N'SMT_K1', N'CP-0046.47-14', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (286, N'CP-0047', N'47-15', N'OK', 0, 5, N'SMT', N'SMT_K1', N'CP-0047.47-15', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (287, N'P/N 85-150-500', N'47-08', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0048.47-08', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (288, N'P/N 90-150-705', N'47-08', N'OK', 0, 3, N'SMT', N'SMT_K1', N'CP-0049.47-08', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (289, N'P/N 180-100-50', N'47-08', N'OK', 0, 5, N'SMT', N'SMT_K1', N'CP-0050.47-08', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (290, N'CP-0051', N'47-09', N'OK', 0, 100, N'SMT', N'SMT_K1', N'CP-0051.47-09', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (291, N'CP-0052', N'47-09', N'OK', 0, 100, N'SMT', N'SMT_K1', N'CP-0052.47-09', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (292, N'CP-0053', N'47-08', N'OK', 0, 100, N'SMT', N'SMT_K1', N'CP-0053.47-08', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (293, N'CP-0054', N'47-09', N'OK', 0, 100, N'SMT', N'SMT_K1', N'CP-0054.47-09', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (294, N'CP-0055', NULL, N'OK', 1, 56, N'SMT', N'SMT_K1', N'CP-0055', N'EA', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (295, N'CP-0056', NULL, N'OK', 1, 3, N'SMT', N'SMT_K1', N'CP-0056', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (296, N'03015869-03', N'03-02', N'OK', 0, 64, N'SMT', N'SMT_K1', N'03015869-03.03-02', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (297, N'03015840-03', N'03-02', N'OK', 0, 40, N'SMT', N'SMT_K1', N'03015840-03.03-02', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (298, N'03015854-03', N'03-01', N'OK', 0, 14, N'SMT', N'SMT_K1', N'03015854-03.03-01', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (299, N'03054812-02', N'03-02', N'OK', 0, 8, N'SMT', N'SMT_K1', N'03054812-03.03-02', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (300, N'03099720-01', N'03-02', N'OK', 0, 67, N'SMT', N'SMT_K1', N'03099720-01.03-02', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (301, N'03102963-01', N'03-02', N'OK', 0, 42, N'SMT', N'SMT_K1', N'03102963-01.03-02', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (302, N'03107579-01', N'03-01', N'OK', 0, 5, N'SMT', N'SMT_K1', N'03107579-01.03-01', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (303, N'03115821-01', N'03-01', N'OK', 0, 43, N'SMT', N'SMT_K1', N'03115821-01.03-01', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (304, N'03105714-01', N'03-04', N'OK', 0, 8, N'SMT', N'SMT_K1', N'03105714-01.03-04', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (305, N'SP-0004', N'03-02', N'OK', 0, 8, N'SMT', N'SMT_K1', N'SP-0004.03-02', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (306, N'03133662-01', N'03-01', N'OK', 0, 34, N'SMT', N'SMT_K1', N'03133662-01.03-01', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (307, N'03101981-01', N'03-01', N'OK', 0, 82, N'SMT', N'SMT_K1', N'03101981-01.03-01', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (308, N'03102457-01', N'03-04', N'OK', 0, 102, N'SMT', N'SMT_K1', N'03102457-01.03-04', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (309, N'03102459-01', N'03-05', N'OK', 0, 35, N'SMT', N'SMT_K1', N'03102459-01.03-05', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (310, N'03102344-01', N'03-03', N'OK', 0, 176, N'SMT', N'SMT_K1', N'03102344-01.03-03', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (311, N'03103544-01', N'03-05', N'OK', 0, 27, N'SMT', N'SMT_K1', N'03103544-01.03-05', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (312, N'03103553-01', N'03-04', N'OK', 0, 84, N'SMT', N'SMT_K1', N'03103553-01.03-04', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (313, N'03115853-01', N'03-02', N'OK', 0, 23, N'SMT', N'SMT_K1', N'03115853-01.03-02', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (314, N'00359505-02', N'03-06', N'OK', 0, 8, N'SMT', N'SMT_K1', N'00359505-02.03-06', N'PAC', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (315, N'03078556-01', N'02-05', N'OK', 0, 1, N'SMT', N'SMT_K1', N'03078556-01.02-05', N'EA', CAST(N'2022-09-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (316, N'CP-0003', N'18-10', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-10', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (317, N'CP-0004', N'34-03', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-03', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (318, N'CP-0004', N'40-10', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.40-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (319, N'CP-0004', N'34-01', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-01', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (320, N'CP-0004', N'34-04', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-04', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (321, N'CP-0004', N'34-05', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-05', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (322, N'CP-0004', N'34-06', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-06', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (323, N'CP-0004', N'34-07', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-07', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (324, N'CP-0004', N'34-08', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-08', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (325, N'CP-0004', N'34-09', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-09', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (326, N'CP-0004', N'34-10', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-10', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (327, N'CP-0004', N'34-11', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-11', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (328, N'CP-0004', N'34-12', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-12', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (329, N'CP-0004', N'34-13', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-13', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (330, N'CP-0004', N'34-14', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-14', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (331, N'CP-0004', N'34-15', N'OK', 0, 10, N'SMT', N'SMT_K1', N'CP-0004.34-15', N'ROLL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (332, N'CP-0003', N'18-05', N'OK', 0, 2, N'SMT', N'SMT_K1', N'CP-0003.18-05', N'PACK', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (333, N'CP-0027', N'46-06', N'OK', 0, 9, N'SMT', N'SMT_K1', N'CP-0027.46-06', N'REEL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
INSERT [dbo].[EWIP_SPAREPART_LOCATION] ([ID], [SPARE_PART_CODE], [LOCATION_CODE], [CONDITION_CODE], [IS_WAITE], [QUANTITY], [DEPT_CODE], [STOCK_CODE], [BARCODE], [UNIT_ID], [EXPIRED_DATE], [TIME_IN]) VALUES (334, N'CP-0027', N'46-07', N'OK', 0, 9, N'SMT', N'SMT_K1', N'CP-0027.46-07', N'REEL', CAST(N'2199-01-01' AS Date), CAST(N'2021-06-30' AS Date))
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_LOCATION] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_TYPE] ON 
GO
INSERT [dbo].[EWIP_SPAREPART_TYPE] ([ID], [CODE], [NAME], [DEPT_CODE]) VALUES (1, N'1', N'Consumable part', N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_TYPE] ([ID], [CODE], [NAME], [DEPT_CODE]) VALUES (2, N'2', N'Spare part', N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_TYPE] ([ID], [CODE], [NAME], [DEPT_CODE]) VALUES (3, N'3', N'Other', N'SMT')
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_TYPE] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_UNIT] ON 
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (10, N'CP-0001', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (151, N'CP-0037', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (152, N'CP-0037', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (153, N'CP-0038', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (154, N'CP-0038', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (159, N'PL-108AL', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (160, N'PL-108AL', N'PACK', N'EA', 250, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (161, N'PL-108AL', N'BOX', N'EA', 250, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (164, N'N78/ MATYPM CDH 9300083', N'PAIR', N'PAIR', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (165, N'N78/ MATYPM CDH 9300083', N'PACK', N'PAIR', 50, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (168, N'CP-0003', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (169, N'CP-0003', N'PACK', N'EA', 300, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (172, N'CP-0002', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (173, N'CP-0002', N'PACK', N'EA', 150, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (174, N'CP-0007', N'LIT', N'LIT', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (175, N'CP-0007', N'PACK', N'LIT', 20, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (176, N'CP-0022', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (177, N'CP-0022', N'PACK', N'ROLL', 50, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (178, N'CP-0021', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (179, N'CP-0021', N'PACK', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (180, N'CP-0012', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (181, N'CP-0012', N'PACK', N'ROLL', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (182, N'CP-0010', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (183, N'CP-0010', N'PACK', N'ROLL', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (184, N'CP-0011', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (185, N'CP-0011', N'PACK', N'ROLL', 3, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (186, N'CP-0004', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (187, N'CP-0004', N'PACK', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (190, N'CP-0019', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (191, N'CP-0019', N'PACK', N'ROLL', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (192, N'CP-0016', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (193, N'CP-0016', N'PACK', N'ROLL', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (199, N'CP-0008', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (200, N'CP-0008', N'PACK', N'EA', 50, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (203, N'CP-0041', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (204, N'CP-0041', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (227, N'CP-0005', N'PAIR', N'PAIR', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (228, N'CP-0005', N'PACK', N'PAIR', 10, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (462, N'CP-0029', N'REEL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (463, N'CP-0029', N'PACK', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (464, N'CP-0026', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (465, N'CP-0026', N'PACK', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (466, N'CP-0013', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (467, N'CP-0013', N'PACK', N'ROLL', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (468, N'CP-0009', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (469, N'CP-0009', N'PACK', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (470, N'CP-0020', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (471, N'CP-0020', N'PACK', N'ROLL', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (472, N'CP-0014', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (473, N'CP-0014', N'PACK', N'ROLL', 3, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (478, N'NMS50-AO', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (479, N'NMS50-AO', N'PACK', N'EA', 12, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (480, N'NMS50-AO', N'BOX', N'EA', 12, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (483, N'CP-0040', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (484, N'CP-0040', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (487, N'CP-0031', N'REEL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (488, N'CP-0031', N'PACK', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (491, N'CP-0015', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (492, N'CP-0015', N'PACK', N'ROLL', 10, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (493, N'CP-0023', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (494, N'CP-0023', N'PACK', N'ROLL', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (495, N'CP-0030', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (496, N'CP-0030', N'PACK', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (511, N'CP-0042', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (512, N'CP-0042', N'PACK', N'EA', 10, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (513, N'CP-0043', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (514, N'CP-0043', N'PACK', N'EA', 10, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (515, N'CP-0034', N'REEL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (516, N'CP-0034', N'PACK', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (517, N'CP-0044', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (518, N'CP-0044', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (535, N'CP-0045', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (536, N'CP-0045', N'PACK', N'EA', 500, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (537, N'CP-0047', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (538, N'CP-0047', N'PACK', N'EA', 250, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (539, N'CP-0046', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (540, N'CP-0046', N'PACK', N'EA', 250, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (602, N'CP-0070', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (603, N'CP-0070', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (604, N'CP-0071', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (605, N'CP-0071', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (606, N'CP-0072', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (607, N'CP-0072', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (608, N'CP-0073', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (609, N'CP-0073', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (610, N'CP-0074', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (611, N'CP-0074', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (644, N'CP-0089', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (645, N'CP-0089', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (646, N'CP-0090', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (647, N'CP-0090', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (706, N'CP-0082', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (707, N'CP-0082', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (708, N'CP-0083', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (709, N'CP-0083', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (710, N'CP-0084', N'METER', N'METER', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (711, N'CP-0084', N'PACK', N'METER', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (712, N'CP-0085', N'METER', N'METER', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (713, N'CP-0085', N'PACK', N'METER', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (714, N'CP-0086', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (715, N'CP-0086', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (716, N'CP-0087', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (717, N'CP-0087', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (724, N'CP-0006', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (725, N'CP-0006', N'PACK', N'EA', 1000, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (747, N'03072785-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (748, N'03072785-01', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (749, N'03106620-02', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (750, N'03106620-02', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (753, N'03013091S02', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (754, N'03013091S02', N'PACK', N'EA', 20, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (755, N'03013091S02', N'PAC', N'EA', 20, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (756, N'03042001S02', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (757, N'03042001S02', N'PACK', N'EA', 100, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (758, N'03042001S02', N'BOX', N'EA', 100, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (761, N'CP-0055', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (762, N'CP-0055', N'PACK', N'EA', 5, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (763, N'CP-0055', N'BOX', N'EA', 10, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (768, N'KGT - M8895 - 00', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (769, N'KGT - M8895 - 00', N'PACK', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (775, N'CP-0024', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (776, N'CP-0024', N'PACK', N'ROLL', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (780, N'CP-0018', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (781, N'CP-0018', N'PACK', N'ROLL', 10, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (784, N'TZE2312PK', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (785, N'TZE2312PK', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (803, N'00343774-03', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (804, N'00343774-03', N'PACK', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (810, N'CP-0069', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (811, N'CP-0069', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (812, N'CP-0017', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (813, N'CP-0017', N'PACK', N'ROLL', 3, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (814, N'CP-0056', N'METER', N'METER', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (815, N'CP-0056', N'PACK', N'METER', 10, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (816, N'CP-0056', N'ROLL', N'METER', 10, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (822, N'00388764-03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (823, N'00388764-03', N'PACK', N'EA', 500, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (824, N'00388764-03', N'PAC', N'EA', 500, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (840, N'', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (844, N'SP-0007', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (845, N'SP-0007', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (849, N'03002898-02', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (850, N'03002898-02', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (855, N'P/N 85-150-500', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (856, N'P/N 85-150-500', N'PACK', N'EA', 10, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (857, N'P/N 90-150-705', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (858, N'P/N 90-150-705', N'PACK', N'EA', 5, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (859, N'P/N 180-100-50', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (860, N'P/N 180-100-50', N'PACK', N'EA', 5, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (864, N'03046348-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (865, N'03046348-01', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (871, N'03013018S01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (872, N'03013018S01', N'PACK', N'EA', 20, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (873, N'03013018S01', N'PAC', N'EA', 20, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (874, N'00355386-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (875, N'00355386-01', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (876, N'03039368-03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (877, N'03039368-03', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (878, N'03058627S06', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (879, N'03058627S06', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (880, N'03149490S02', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (881, N'03149490S02', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (882, N'03153682S04', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (883, N'03153682S04', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (888, N'00359505-02', N'REEL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (889, N'00359505-02', N'PACK', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (906, N'03071883-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (907, N'03071883-01', N'PACK', N'EA', 20, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (908, N'03071883-01', N'PAC', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (914, N'03157505S01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (915, N'03157505S01', N'PACK', N'EA', 20, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (918, N'00334073-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (919, N'00334073-01', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (920, N'03013307-03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (921, N'03013307-03', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (922, N'03013307-03', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (923, N'03015869-03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (924, N'03015869-03', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (925, N'03015869-03', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (926, N'03015840-03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (927, N'03015840-03', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (928, N'03015840-03', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (929, N'03056499-03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (930, N'03056499-03', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (931, N'03056499-03', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (932, N'03015854-03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (933, N'03015854-03', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (934, N'03015854-03', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (935, N'03054812-02', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (936, N'03054812-02', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (937, N'03054812-02', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (938, N'03099720-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (939, N'03099720-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (940, N'03099720-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (941, N'03102963-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (942, N'03102963-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (943, N'03102963-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (947, N'03107579-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (948, N'03107579-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (949, N'03107579-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (951, N'SP-0004', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (952, N'SP-0004', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (953, N'SP-0004', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (954, N'A1D00388590-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (955, N'03133662-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (956, N'03133662-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (957, N'03133662-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (958, N'03101981-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (959, N'03101981-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (960, N'03101981-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (961, N'03102457-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (962, N'03102457-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (963, N'03102457-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (964, N'03102459-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (965, N'03102459-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (966, N'03102459-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (967, N'03102344-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (968, N'03102344-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (969, N'03102344-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (970, N'03103544-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (971, N'03103544-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (972, N'03103544-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (973, N'03103553-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (974, N'03103553-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (975, N'03103553-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (976, N'03115853-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (977, N'03115853-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (978, N'03115853-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (979, N'03215882-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (980, N'03215882-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (981, N'03215882-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (982, N'03121197-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (983, N'03121197-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (984, N'03121197-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (985, N'03115821-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (986, N'03115821-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (987, N'03115821-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (991, N'03105714-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (992, N'03105714-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (993, N'03105714-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (994, N'03106244-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (995, N'03106244-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (996, N'03106244-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (997, N'SP-0005', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (998, N'SP-0005', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (999, N'SP-0005', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1002, N'03078561-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1003, N'03078561-01', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1010, N'03098748-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1011, N'03098748-01', N'PACK', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1012, N'03098748-01', N'PAC', N'EA', 6, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1013, N'03034148-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1014, N'03034148-01', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1018, N'03104247S02', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1019, N'03104247S02', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1020, N'CP-0051', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1021, N'CP-0051', N'PACK', N'EA', 100, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1022, N'CP-0052', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1023, N'CP-0052', N'PACK', N'EA', 100, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1026, N'CP-0054', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1027, N'CP-0054', N'PACK', N'EA', 100, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1028, N'CP-0053', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1029, N'CP-0053', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1030, N'CP-0035', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1031, N'CP-0035', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1032, N'CP-0035', N'BOX', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1033, N'CP-0039', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1034, N'CP-0039', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1037, N'33967', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1038, N'33967', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1039, N'SP-0025', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1040, N'SP-0025', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1041, N'BEN5M-MFR', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1042, N'BEN5M-MFR', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1043, N'03068745', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1044, N'03068745', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1047, N'CP-0098', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1048, N'CP-0098', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1049, N'00328369', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1050, N'00328369', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1051, N'CP-0099', N'BOX', N'BOX', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1052, N'CP-0099', N'PACK', N'BOX', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1053, N'2W-250-25', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1054, N'2W-250-25', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1055, N'ICR620S-T11503', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1056, N'LS2208-SR20007R-UR', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1057, N'DS6878-SR20007WR', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1058, N'825-0019-2R D', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1059, N'03078556-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1076, N'CP-0100', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1078, N'03101402S01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1079, N'03101402S01', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1080, N'SP-0009', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1081, N'SP-0009', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1084, N'03060794S01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1085, N'03060794S01', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1086, N'SP-0012', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1087, N'SP-0012', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1090, N'SP-0013', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1091, N'SP-0013', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1094, N'SP-0014', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1095, N'SP-0014', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1098, N'ARJ210-M5BG', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1099, N'ARJ210-M5BG', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1100, N'03067289S02', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1101, N'03067289S02', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1102, N'03007696-02', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1103, N'03007696-02', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1106, N'KHY-M7151-032', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1107, N'KHY-M7151-032', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1108, N'CP-0094', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1109, N'CP-0094', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1112, N'CP-0068', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1113, N'CP-0068', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1116, N'CP-0078', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1117, N'CP-0078', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1118, N'CP-0097', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1119, N'CP-0097', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1120, N'CP-0095', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1121, N'CP-0095', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1122, N'0041017S03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1123, N'0041017S03', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1124, N'SP-0026', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1125, N'593556', N'LIT', N'LIT', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1126, N'57017605', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1128, N'SP-0028', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1129, N'SP-0029', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1131, N'594533', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1132, N'SP-0030', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1133, N'SP-0024', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1134, N'SP-0024', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1135, N'SP-0031', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1136, N'CM2B20-15', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1137, N'SP-0032', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1138, N'SP-0033', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1139, N'SP-0034', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1140, N'MY 1B 1G-350-CJJM1667', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1141, N'AQ2B20-10D', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1142, N'SF210-IP', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1143, N'FP0-E32T', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1144, N'SP-0035', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1145, N'03079145-03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1146, N'03079145-03', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1149, N'DP-100', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1150, N'DP-100', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1151, N'1016013-04', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1152, N'2-8999-735-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1153, N'2-8999-739-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1154, N'2-8999-740-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1155, N'2-8999-744-01-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1156, N'2-8999-744-03-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1157, N'2-8999-770-01-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1158, N'2-8999-736-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1159, N'2-8999-810-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1160, N'2-8015-197-06-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1161, N'2-5002-458-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1162, N'8002562', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1165, N'D-A93', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1166, N'D-A93', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1167, N'03071039-01', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1168, N'03071039-01', N'PACK', N'EA', 20, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1169, N'03071039-01', N'PAC', N'EA', 20, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1170, N'D-A73', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1171, N'D-A73', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1172, N'CP-0096', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1173, N'CP-0096', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1174, N'CP-0081', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1175, N'CP-0081', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1176, N'SP-0036', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1178, N'7179K', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1179, N'581328', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1180, N'CP-0080', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1181, N'CP-0080', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1182, N'CP-0101', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1183, N'CP-0101', N'PACK', N'EA', 70, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1184, N'CP-0101', N'BOX', N'EA', 70, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1185, N'2-5059-039-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1186, N'2-5026-056-00-1', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1187, N'7448K', N'PACK', N'PACK', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1188, N'2-5004-316-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1189, N'2-5026-171-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1191, N'5749K', N'METER', N'METER', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1193, N'8237K', N'METER', N'METER', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1194, N'5775K', N'METER', N'METER', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1196, N'CP-0103', N'BINH', N'BINH', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1197, N'RT-3700', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1198, N'CP-0102', N'BINH', N'BINH', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1199, N'SP-0037', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1200, N'SP-0038', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1201, N'TL-T70', N'BOTTLE', N'BOTTLE', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1203, N'CP-0104', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1204, N'3322K', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1205, N'SP-0039', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1207, N'SP-0040', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1208, N'SP-0041', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1209, N'2-8999-320-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1210, N'2-8999-486-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1211, N'2-8999-240-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1212, N'2-8999-609-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1213, N'2-6002-002-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1214, N'2-5041-208-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1215, N'2-5004-257-02-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1216, N'2-5004-312-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1217, N'2-5004-299-02-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1218, N'SP-0042', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1220, N'2-5051-180-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1221, N'2-5999-337-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1222, N'SP-0043', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1223, N'2-5004-281-02-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1226, N'2-5006-159-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1227, N'2-5006-158-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1228, N'SP-0045', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1229, N'SP-0046', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1230, N'2-5006-160-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1231, N'2-5008-511-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1232, N'SP-0047', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1233, N'SP-0048', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1234, N'2-5008-473-01-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1235, N'SP-0049', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1236, N'2-5999-339-00-0', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1238, N'SP-0050', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1239, N'SP-0051', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1241, N'SP-0053', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1242, N'SP-0044', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1243, N'SP-0052', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1244, N'SP-0054', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1245, N'SP-0055', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1246, N'SP-0056', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1258, N'SP-0057', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1264, N'SP-0061', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1265, N'SP-0060', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1266, N'SP-0059', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1268, N'CSP8-290-011-A', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1269, N'OP-0001', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1270, N'602012-000010', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1271, N'SP-0058', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1272, N'CSP4-900-023-A', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1273, N'CP-0028', N'REEL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1274, N'CP-0028', N'PACK', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1275, N'CP-0028', N'ROLL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1276, N'CP-0027', N'REEL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1277, N'CP-0027', N'PACK', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1278, N'CP-0027', N'ROLL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1279, N'CP-0032', N'REEL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1280, N'CP-0032', N'PACK', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1281, N'CP-0032', N'ROLL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1282, N'CP-0033', N'REEL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1283, N'CP-0033', N'PACK', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1284, N'CP-0033', N'ROLL', N'REEL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1285, N'BEN10M-TFR2', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1286, N'BEN10M-TFR2', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1287, N'03149630-03', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1288, N'03149630-03', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1289, N'TG-3269', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1290, N'TG-3269', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1291, N'SZR-LY2-N1', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1292, N'SZR-LY2-N1', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1293, N'DMF-45125 SH', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1294, N'DMF-45125 SH', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1297, N'CDM2B20-400AZ', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1298, N'CDM2B20-400AZ', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1299, N'SP-0015', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1300, N'SP-0015', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1301, N'SP-0062', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1304, N'SP-0063', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1305, N'SP-0064', N'ROLL', N'ROLL', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1306, N'E3T-SL11', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1309, N'OIK3GN-D', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1310, N'OIK3GN-D', N'PACK', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1311, N'E3S-LS3N', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1312, N'PM-Y44P-C3GL21', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1314, N'BYD3M-TDT1', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1315, N'UF-12A23', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1316, N'3863K', N'METER', N'METER', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1317, N'59485302', N'EA', N'EA', 1, N'SMT')
GO
INSERT [dbo].[EWIP_SPAREPART_UNIT] ([ID], [SPARE_PART_CODE], [UNIT_CODE], [UNIT_CODE_MIN], [RATE], [DEPT_CODE]) VALUES (1318, N'4491K', N'EA', N'EA', 1, N'SMT')
GO
SET IDENTITY_INSERT [dbo].[EWIP_SPAREPART_UNIT] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_STOCK] ON 
GO
INSERT [dbo].[EWIP_STOCK] ([ID], [CODE], [NAME], [DEPT_CODE], [MANAGERMENT_EMAIL1], [MANAGERMENT_EMAIL2]) VALUES (1, N'SMT_K1', N'Kho SMT', N'SMT', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[EWIP_STOCK] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_STOCK_OUT] ON 
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (4, N'7DD0DC00-C74F-4215-B22B-916E257F1B4F', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'22-09_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (5, N'C33C936A-8DC9-4DB6-AC71-17AAB3FDDC4B', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'LIT', N'W_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (6, N'8FB3946A-231B-4FDA-99C8-C6F785A41FDC', N'00359505-02', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'REEL', N'03-06_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (7, N'00023564-B747-4D4C-B1A6-F1EC9713549C', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 18, N'4', NULL, N'LIT', N'W_18_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (8, N'12ED711D-A54A-4A22-8A97-04515054B130', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'23-03_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (9, N'3D43F90B-4FE0-42AB-AF3B-CB98777B6C71', N'CP-0005', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'PACK', N'35-05_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (10, N'6FE4137C-9F90-4ADD-BF99-53BC7E05774B', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'23-08_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (11, N'F1CDAB9F-78EC-4C2F-8A0A-CFC440648F46', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'19-15_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (12, N'1D5E49CF-18E7-40D9-8CED-461E16D59A80', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'19-12_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (13, N'1A886BAD-CD1E-4D44-8022-485566C30F36', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 10, N'4', NULL, N'ROLL', N'39-13_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (14, N'16E92CA2-8519-4FC1-8CE0-3D70625F4943', N'CP-0027', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'REEL', N'46-05_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (15, N'B4A58B22-47DC-4F2E-8CCD-2FE1B2CDDD3A', N'CP-0005', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'35-03_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (16, N'9D0D364E-191C-4500-BC7A-B7759B82F2AA', N'CP-0008', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'PACK', N'26-03_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (17, N'193B359C-B5C8-4688-9A04-26E7B11EC987', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'LIT', N'W_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (18, N'8DF7AF3F-E3F3-4A11-8098-888C76D300F3', N'N78/ MATYPM CDH 9300083', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'36-04_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (19, N'CA1C3F44-3553-4306-9CF0-524D58679D23', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'23-04_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (20, N'DE2258C3-87A3-4C62-A429-5BAF85599525', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 10, N'4', NULL, N'ROLL', N'38-06_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (21, N'CCCC3949-8DE5-4785-BA74-B40DCE99FE9C', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'18-02_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (22, N'726336E2-A9CB-4611-A481-C2CC85BDAA19', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'18-03_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (23, N'D7FF4052-42F4-4CA9-8E2C-837966EE8039', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'19-01_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (24, N'9B8EAFEC-8EAF-4EEB-8994-EEA28DC1B9E1', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'LIT', N'W_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (25, N'2BA0FD18-D1F4-44DC-A55A-A6D5899FACDF', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'23-05_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (26, N'8B688015-48C9-4BAB-B4DF-A603181B3C00', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'19-08_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (27, N'C6C88538-9457-4CE0-B68C-153209C7F810', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 5, N'4', NULL, N'ROLL', N'39-01_5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (28, N'1C28AA6F-FBC7-4053-A2AF-6BF9D32D8E17', N'CP-0012', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'ROLL', N'44-13_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (29, N'31F8095B-F284-439C-8834-4394FBDE1238', N'CP-0024', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'ROLL', N'42-12_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (30, N'6B1DFF5A-08B0-4F72-A96B-B7515C06B192', N'CP-0032', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'REEL', N'33-02_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (31, N'D37D779F-C466-49A8-9217-2E68902ECF79', N'CP-0034', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'REEL', N'W_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (32, N'B32055A1-4270-46E1-89A0-65F2A2D7B589', N'CP-0035', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'EA', N'33-07_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (33, N'A80CD30B-34F6-4A44-9E01-2A4D884E1B36', N'CP-0040', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'EA', N'26-14_1.0_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (34, N'EE519D2E-3B6B-40D0-AA9F-675AD28C0FA2', N'CP-0045', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'47-13_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (35, N'2F15E315-B1A6-4A6E-960E-6AE061E07630', N'CP-0046', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'47-14_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (36, N'AFD8F3F8-0B0D-46EA-AA7E-C28D87494DCB', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1.5, N'4', NULL, N'LIT', N'W_1.5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (37, N'E1040F87-EAD1-49B3-A143-83622C063F2B', N'PL-108AL', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 8, N'4', NULL, N'BOX', N'36-15_8_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (38, N'67E7C22B-8ECE-4DAC-BFCC-226119F0D6D1', N'CP-0022', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 14, N'4', NULL, N'ROLL', N'44-06_14_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (39, N'0E458DB1-3603-46B3-A562-B20206CA0C3D', N'CP-0008', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 5, N'4', NULL, N'PACK', N'26-01_5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (40, N'03A2B5AF-345E-44BE-990A-4D7358E75319', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'23-02_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (41, N'93A0625C-484D-4CE4-9678-C6030F9A524B', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'ROLL', N'39-01_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (42, N'00F72B34-10B9-41DB-AC9E-7BA3AFF84D41', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 5, N'4', NULL, N'ROLL', N'38-03_5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (43, N'41ABBDD3-1872-4DE1-B887-CAD8B7C8A8B9', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 42, N'4', NULL, N'LIT', N'W_42_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (44, N'891D1205-5953-4BFA-AD70-1D1163DA2850', N'CP-0005', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'35-04_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (45, N'F23E0F85-F5B0-437A-8F0A-361B04728D4B', N'N78/ MATYPM CDH 9300083', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'36-01_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (46, N'F425209D-0963-4AA2-A5D8-4E0C62CB5365', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'18-06_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (47, N'5E683C30-CDE9-4792-AC42-B0570522FE0C', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'22-06_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (48, N'6BDDEC51-5451-4646-A769-D5EC9B57AE98', N'CP-0027', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'REEL', N'46-04_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (49, N'962446B1-C09D-4776-B90F-259C23F24456', N'CP-0005', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 6, N'4', NULL, N'PACK', N'35-02_6_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (50, N'CFFE5E28-87AC-473B-9022-23AC037A4B99', N'N78/ MATYPM CDH 9300083', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'36-04_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (51, N'FF43662E-7B1E-4236-9BA2-91182E4BCEE1', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'23-06_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (52, N'F3AFB85C-2C6A-4277-995C-23C2E2942FFA', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'19-11_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (53, N'D2302362-EBDA-4457-8BB4-5B61998B194B', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 5, N'4', NULL, N'ROLL', N'38-03_5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (54, N'1E38E89C-036F-4F7A-B7B8-90131B18DAB6', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'LIT', N'W_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (55, N'299F6A30-A707-4A5A-80FE-7702683170CA', N'PL-108AL', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'BOX', N'36-15_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (56, N'3BA777BD-A0A4-481D-8947-AEAC73BA805E', N'CP-0020', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'ROLL', N'41-02_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (57, N'E4EE53F1-2B5F-4515-ACBA-68C6637B9FFD', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2.5, N'4', NULL, N'LIT', N'W_2.5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (58, N'9C6B5F4A-BBC3-4C2C-A6EF-4954BF34ABA5', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'23-01_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (59, N'2D5DEE08-48B8-4994-8309-BAF9C9B7CCA7', N'N78/ MATYPM CDH 9300083', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'36-01_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (60, N'D00D0F1B-00C1-4969-BB6B-2D94AEE8A629', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'18-06_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (61, N'50EC8888-A7A8-4AD3-9FA9-F2D94D94F433', N'CP-0008', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'PACK', N'26-01_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (62, N'AA97A3B4-6C1C-49AC-A491-6CB70413185C', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'18-09_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (63, N'00AB4E0C-7C4E-4AD0-803B-75464CA6A931', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 10, N'4', NULL, N'ROLL', N'38-12_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (64, N'1DCDA67C-D05D-48B7-AF5F-91C5AF1D33AE', N'NMS50-AO', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'BOX', N'46-11_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (65, N'9E59D75C-260F-414B-805A-7C8911EE33AC', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2.5, N'4', NULL, N'LIT', N'W_2.5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (66, N'8A0F42CF-0576-430D-835C-7FBB83D6E4C4', N'CP-0008', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'26-01_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (67, N'003EB8A1-AEC0-4049-A2E5-B29C8C3DDA27', N'CP-0005', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 5, N'4', NULL, N'PACK', N'35-03_5.0_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (68, N'347AB072-33F5-43E1-81F4-217DB4D832AB', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'23-11_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (69, N'6B262325-0F06-4C0C-8796-35D2279E3177', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'19-05_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (70, N'7F261E0C-A6E9-40DF-B332-B10263489784', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 5, N'4', NULL, N'ROLL', N'40-01_5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (71, N'C9F9EAD4-F442-448E-93D2-739C7E8AB994', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1.5, N'4', NULL, N'LIT', N'W_1.5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (72, N'2128090E-C8A2-4509-9825-B9FBF8CEABD1', N'CP-0027', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'REEL', N'46-04_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (73, N'C230B7DA-4DB6-44F1-979A-91F8416A311C', N'00359505-02', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'REEL', N'03-06_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (74, N'87D82DAE-EF2F-4BFD-AA37-E765BDBBC2F0', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'LIT', N'W_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (75, N'C80296A2-7894-4761-AA23-9047D8761DFE', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'22-06_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (76, N'FADF0759-B153-4F5D-9450-6AF5098AF60C', N'PL-108AL', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'BOX', N'36-15_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (77, N'1861EE36-82E2-46EA-9953-AD1802B4CF60', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'19-14_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (78, N'7F11AC3D-6232-4E9F-9748-7CFF71680DCE', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'18-15_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (79, N'0C3AB13D-0DA6-4798-8127-820B918332AD', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'23-08_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (80, N'39C48878-5446-4BB1-A24A-810E98E18C37', N'N78/ MATYPM CDH 9300083', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'36-08_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (83, N'7900C584-80BE-40C9-B447-25EDACD7EA41', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'LIT', N'W_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (84, N'7774C7AF-7052-4418-800E-A6FC8D376581', N'03103553-01', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 15, N'4', NULL, N'PACK', N'03-04_15_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (85, N'225F28B6-79D6-4A9C-A792-54EA646589DF', N'03101981-01', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 10, N'4', NULL, N'PACK', N'03-01_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (86, N'2A4B4699-DE84-429E-9F16-0EAD824C7636', N'PL-108AL', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 10, N'4', NULL, N'BOX', N'36-15_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (87, N'FBF03CBA-1C11-47FF-A4A5-6DA3646A563B', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'19-05_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (88, N'037C6EA6-CF98-4B32-88C7-492F7276C360', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-10' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'19-06_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (89, N'20D40E60-A628-4DA9-AF6C-9F7E3226A6A2', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'LIT', N'W_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (90, N'D283E3F0-EBD2-4477-A70F-32124F3D6F4C', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 5, N'4', NULL, N'ROLL', N'38-02_5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (91, N'C5ECF72B-BA8A-4E9F-A4A0-D78D04E431C5', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'18-05_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (92, N'EC2AC6DE-ED70-45E2-9D11-AB49AF85A056', N'CP-0027', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'REEL', N'46-04_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (93, N'EA08BB92-B9DB-44D0-A2FD-E7E3E8B00B95', N'CP-0030', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'ROLL', N'47-06_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (94, N'498AFCAA-4054-4A5C-852A-02E9720DAF70', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 4.5, N'4', NULL, N'LIT', N'W_4.5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (95, N'CB1A9B50-5864-4CF6-8010-800040265E8D', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'22-03_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (96, N'5EAFA986-7E01-4B6F-96B5-278585E3D966', N'CP-0022', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 42, N'4', NULL, N'ROLL', N'44-09_42_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (97, N'9209C7DD-8DC3-431D-9542-68213B7A375E', N'CP-0022', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 14, N'4', NULL, N'ROLL', N'44-09_14_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (98, N'E417EA10-BB8A-423F-9D89-FCFA70979E0F', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 10, N'4', NULL, N'ROLL', N'39-04_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (99, N'7C3124BE-8031-4B47-9398-50E8447FE9C0', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 10, N'4', NULL, N'ROLL', N'39-05_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (100, N'6CD7B533-A743-423C-A7E5-DA297471546E', N'CP-0005', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'35-01_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (101, N'EC70D572-D90B-4211-8EE7-A188B81C719F', N'CP-0005', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'35-04_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (102, N'660FB9A8-F6F0-4A05-9756-044C4766C5CE', N'PL-108AL', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'BOX', N'36-15_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (103, N'FCFA4533-0D0E-4023-BC5D-2F76D500C215', N'N78/ MATYPM CDH 9300083', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'PACK', N'36-02_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (104, N'A24D21E1-F6B0-4521-9F9B-CE0C47E79D00', N'CP-0008', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 12, N'4', NULL, N'PACK', N'27-01_12_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (105, N'570176E9-C12A-4425-8EF4-44A29BAED646', N'CP-0008', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'26-03_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (106, N'4962F79D-E978-4EF7-B241-EECE4031190C', N'CP-0012', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-12' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'ROLL', N'44-13_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (107, N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'CP-0008', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-13' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'26-03_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (108, N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'CP-0005', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-13' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'35-02_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (109, N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-13' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'19-05_2_OK_2199-01-01,19-06_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (110, N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-13' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'23-07_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (111, N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-13' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'LIT', N'W_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (112, N'087ADB92-A953-4860-85C8-9C164C96FD6C', N'N78/ MATYPM CDH 9300083', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-13' AS Date), 2021, 7, N'H2105001', 4, N'4', NULL, N'PACK', N'36-05_4_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (113, N'3D947D0E-D49F-4FAF-8523-4D0970E9E434', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-13' AS Date), 2021, 7, N'H2105001', 0.5, N'4', NULL, N'LIT', N'W_0.5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (114, N'3D947D0E-D49F-4FAF-8523-4D0970E9E434', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-13' AS Date), 2021, 7, N'H2105001', 15, N'4', NULL, N'ROLL', N'38-02_5_OK_2199-01-01,38-05_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (115, N'84081660-BD92-4C6A-B442-27DEDBACD911', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-14' AS Date), 2021, 7, N'H2105001', 62.5, N'4', NULL, N'LIT', N'W_62.5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (116, N'84081660-BD92-4C6A-B442-27DEDBACD911', N'N78/ MATYPM CDH 9300083', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-14' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'36-02_1_OK_2199-01-01,36-05_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (117, N'84081660-BD92-4C6A-B442-27DEDBACD911', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-14' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'23-12_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (118, N'1F572961-2BB8-42AE-B781-B01E88B34509', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-14' AS Date), 2021, 7, N'H2105001', 3.5, N'4', NULL, N'LIT', N'W_3.5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (119, N'1F572961-2BB8-42AE-B781-B01E88B34509', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-14' AS Date), 2021, 7, N'H2105001', 2, N'4', NULL, N'PACK', N'22-02_2_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (120, N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'CP-0008', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-15' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'26-03_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (121, N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'CP-0005', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-15' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'35-02_3_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (122, N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'CP-0003', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-15' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'19-06_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (123, N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'CP-0002', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-15' AS Date), 2021, 7, N'H2105001', 1, N'4', NULL, N'PACK', N'23-05_1_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (124, N'FBFDD8D7-0089-4C0D-9261-57D7CCF31966', N'CP-0004', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-15' AS Date), 2021, 7, N'H2105001', 10, N'4', NULL, N'ROLL', N'39-05_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (125, N'B7193AB5-93B6-491E-AB19-C87CBA72A429', N'CP-0007', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-15' AS Date), 2021, 7, N'H2105001', 5.5, N'4', NULL, N'LIT', N'W_5.5_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (126, N'B7193AB5-93B6-491E-AB19-C87CBA72A429', N'PL-108AL', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-15' AS Date), 2021, 7, N'H2105001', 10, N'4', NULL, N'BOX', N'36-15_10_OK_2199-01-01')
GO
INSERT [dbo].[EWIP_STOCK_OUT] ([ID], [STOCK_OUT_CODE], [SPARE_PART_CODE], [CAUSE], [STOCK_CODE], [DEPT_CODE], [DATE], [YEAR], [MONTH], [USER_ID], [QUANTITY], [TYPE_OUT_CODE], [RETURN_TIME], [UNIT_ID], [LOCATION]) VALUES (128, N'665ECC8F-FEC4-4764-A9D2-18C5AC52BEBA', N'N78/ MATYPM CDH 9300083', N'', N'SMT_K1', N'SMT', CAST(N'2021-07-15' AS Date), 2021, 7, N'H2105001', 3, N'4', NULL, N'PACK', N'36-01_3_OK_2199-01-01')
GO
SET IDENTITY_INSERT [dbo].[EWIP_STOCK_OUT] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_TYPE_IN_OUT] ON 
GO
INSERT [dbo].[EWIP_TYPE_IN_OUT] ([ID], [CODE], [NAME]) VALUES (1, N'1', N'Nhập kho mua hàng')
GO
INSERT [dbo].[EWIP_TYPE_IN_OUT] ([ID], [CODE], [NAME]) VALUES (2, N'2', N'Nhập kho trực tiếp')
GO
INSERT [dbo].[EWIP_TYPE_IN_OUT] ([ID], [CODE], [NAME]) VALUES (3, N'3', N'Xuất trả lại')
GO
INSERT [dbo].[EWIP_TYPE_IN_OUT] ([ID], [CODE], [NAME]) VALUES (4, N'4', N'Xuất không trả lại')
GO
SET IDENTITY_INSERT [dbo].[EWIP_TYPE_IN_OUT] OFF
GO
SET IDENTITY_INSERT [dbo].[EWIP_UNITS] ON 
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (2, N'PACK', N'Pack')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (3, N'REEL', N'Reel')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (4, N'PAIR', N'Pair')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (5, N'BOX', N'Box')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (6, N'EA', N'ea')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (7, N'BINH', N'Bình')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (8, N'BOTTLE', N'Bình')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (10, N'METER', N'Mét')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (11, N'LIT', N'Lít')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (12, N'PAC', N'Pac')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (13, N'ROLL', N'Roll')
GO
INSERT [dbo].[EWIP_UNITS] ([ID], [CODE], [NAME]) VALUES (14, N'pcs', N'pcs')
GO
SET IDENTITY_INSERT [dbo].[EWIP_UNITS] OFF
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'ACS', N'ACS', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'AEGIS', N'AEGIS', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'AR', N'AR', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'ARISOLTECH', N'ARISOL TECH', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'ASM', N'ASM', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'BANICO', N'Banico', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'COSMO', N'Cosmo', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'DRF', N'DRF', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'ECITECHNOLOGY', N'ECI TECHNOLOGY', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'EMS', N'EMS', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'FBS', N'FBS', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'FUJI', N'FUJI', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'HELLER', N'HELLER', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'INTRADING', N'Intrading', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'KHANHAN', N'Khánh An', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'KOHYOUNG', N'KOHYOUNG', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'LORIOT', N'Loriot', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'MESSER', N'MESSER', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'OSRAM', N'OSRAM', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'OTHER', N'Other', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'PHUONGANH', N'Phương Anh', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'REHL', N'REHL', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'S-VINA', N'S-VINA', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'SUSS', N'SUSS', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'TKC', N'TKC', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'TOANTHINH', N'Toàn Thịnh', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'TQ', N'TQ', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'UNILOCK', N'UNILOCK', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'Wisol-Korea', N'Wisol-Korea', NULL, NULL, NULL)
GO
INSERT [dbo].[EWIP_VENDER] ([VENDER_ID], [NAME], [ADDRESS], [PHONE], [EMAIL]) VALUES (N'Youngjin AST', N'Youngjin AST', NULL, NULL, NULL)
GO
ALTER TABLE [dbo].[ESYSMSTFORM] ADD  CONSTRAINT [DF_ESYSMSTFORM_USEFLAG]  DEFAULT ('Y') FOR [USEFLAG]
GO
ALTER TABLE [dbo].[ESYSMSTGLA] ADD  CONSTRAINT [DF_ESYSMSTGLA_DEPARTMENT]  DEFAULT ('ALL') FOR [DEPARTMENT]
GO
ALTER TABLE [dbo].[ESYSMSTGLA] ADD  CONSTRAINT [DF_ESYSMSTGLA_USE_FLAG]  DEFAULT ('N') FOR [USE_FLAG]
GO
ALTER TABLE [dbo].[ESYSMSTMEU] ADD  CONSTRAINT [DF_ESYSMSTMEU_DISPLAG]  DEFAULT ('Y') FOR [DISPFLAG]
GO
ALTER TABLE [dbo].[ESYSMSTMEU] ADD  CONSTRAINT [DF_ESYSMSTMEU_USEFLAG]  DEFAULT ('Y') FOR [USEFLAG]
GO
ALTER TABLE [dbo].[ESYSMSTMRO] ADD  CONSTRAINT [DF_ESYSMSTMRO_USEFLAG]  DEFAULT ('Y') FOR [USEFLAG]
GO
ALTER TABLE [dbo].[ESYSMSTROL] ADD  CONSTRAINT [DF_ESYSMSTROL_USEFLAG]  DEFAULT ('Y') FOR [USEFLAG]
GO
ALTER TABLE [dbo].[ESYSMSTUSR] ADD  CONSTRAINT [DF_ESYSMSTUSR_USEFLAG]  DEFAULT ('Y') FOR [USEFLAG]
GO
ALTER TABLE [dbo].[EWIP_SPAREPART_LOCATION] ADD  CONSTRAINT [DF_EWIP_SPAREPART_LOCATION_IS_WAITE]  DEFAULT ((0)) FOR [IS_WAITE]
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_BOM@INIT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_BOM@INIT](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT SP.CODE,SP.NAME_VI AS [NAME]
			FROM  [dbo].[EWIP_SPARE_PART] SP  
			INNER JOIN [dbo].[EWIP_SPARE_PART_DEPT] SD ON SP.CODE = SD.SPARE_PART_CODE
			WHERE SD.DEPT_CODE = @A_DEPARTMENT
			ORDER BY SP.ID

			SELECT CODE,NAME
			FROM [dbo].[EWIP_UNITS]

			SELECT SP.CODE,SP.NAME_VI,SP.NAME_KR,SU.RATE as QUANTITY_IN_PACK,SU.UNIT_CODE_MIN AS UNIT,BOM.WORKING_DAY_NUMBER,BOM.WORKING_LINE_NUMBER,BOM.WORKING_A_LINE,BOM.WORKING_A_LINE/SU.RATE as WORKING_A_LINE_PACK,BOM.WORKING_A_MONTH
			FROM [dbo].[EWIP_SPARE_PART] SP
			INNER JOIN [dbo].[EWIP_SPARE_PART_DEPT] SD ON SP.CODE = SD.SPARE_PART_CODE AND SD.DEPT_CODE = @A_DEPARTMENT
			INNER JOIN [dbo].[EWIP_SPAREPART_UNIT] SU ON SP.CODE = SU.SPARE_PART_CODE AND SU.DEPT_CODE = @A_DEPARTMENT AND SU.UNIT_CODE = 'PACK'
			LEFT JOIN [dbo].[EWIP_BOM] BOM ON SP.CODE = BOM.SPARE_PART_CODE AND BOM.DEPT_CODE = @A_DEPARTMENT

       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_BOM_SPAREPART@DELETE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_BOM_SPAREPART@DELETE](
@A_DEPARTMENT		NVARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			DELETE FROM [dbo].[EWIP_BOM]
			WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_BOM_SPAREPART@GET]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_BOM_SPAREPART@GET](
@A_DEPARTMENT		NVARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			
			SELECT SP.CODE,SP.NAME_VI,SP.NAME_KR,SU.RATE as QUANTITY_IN_PACK,SU.UNIT_CODE_MIN AS UNIT,BOM.WORKING_DAY_NUMBER,BOM.WORKING_LINE_NUMBER,BOM.WORKING_A_LINE,BOM.[WORKING_A_LINE_PACK],BOM.WORKING_A_MONTH
			FROM [dbo].[EWIP_SPARE_PART] SP
			INNER JOIN [dbo].[EWIP_SPARE_PART_DEPT] SD ON SP.CODE = SD.SPARE_PART_CODE AND SD.DEPT_CODE = @A_DEPARTMENT
			INNER JOIN [dbo].[EWIP_SPAREPART_UNIT] SU ON SP.CODE = SU.SPARE_PART_CODE AND SU.DEPT_CODE = @A_DEPARTMENT AND SU.UNIT_CODE = 'PACK'
			LEFT JOIN [dbo].[EWIP_BOM] BOM ON SP.CODE = BOM.SPARE_PART_CODE AND BOM.DEPT_CODE = @A_DEPARTMENT
			WHERE SP.CODE =@A_SPARE_PART_CODE

			SELECT UNIT_CODE AS CODE,UNIT_CODE AS [NAME] , sp.IMAGE  
			FROM [dbo].[EWIP_SPAREPART_UNIT] uni
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON sp.CODE = uni.SPARE_PART_CODE
			WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_BOM_SPAREPART@PUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_BOM_SPAREPART@PUT](
@A_DEPARTMENT		NVARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_QUANTITY_IN_PACK NVARCHAR(50),
@A_UNIT             NVARCHAR(50),
@A_WORKING_DAY      NVARCHAR(50),
@A_LINE             NVARCHAR(50),
@A_WORKING_A_LINE   NVARCHAR(50),
@A_WORKING_A_LINE_PACK NVARCHAR(50),
@A_MONTHLY_USING    NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			DELETE FROM [dbo].[EWIP_BOM]
			WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT

			INSERT INTO [dbo].[EWIP_BOM]
			VALUES(@A_SPARE_PART_CODE,@A_QUANTITY_IN_PACK,@A_UNIT,@A_WORKING_DAY,@A_LINE,@A_WORKING_A_LINE,@A_MONTHLY_USING,@A_DEPARTMENT,@A_WORKING_A_LINE_PACK)
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_CACULATOR_INVENTORY@CALL]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_CACULATOR_INVENTORY@CALL](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_UNIT             VARCHAR(20),
@A_DATE				NVARCHAR(50), -- 2021-06-15
@A_YEAR             NVARCHAR(4),
@A_MONTH			NVARCHAR(2),
@A_USER			    NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK1 int;
			DECLARE @CHECK2 int;
			DECLARE @TABLE_QUANTITY TABLE(QUANTITY float,IN_OUT NVARCHAR(50));

			BEGIN TRAN;
			SELECT @CHECK1 = COUNT(*) FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)

			SELECT @CHECK2 = COUNT(*) 
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			DECLARE @QUANTITY FLOAT;
			DECLARE @QUANTITY_IN FLOAT;
			DECLARE @QUANTITY_OUT FLOAT;

			-- GET quantity of pre month
			SELECT @QUANTITY =[dbo].[CONVERT_UNIT](UNIT,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)*QUANTITY 
			FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE  [SPARE_PART_CODE] = @A_SPARE_PART_CODE  AND [MONTH] = MONTH(DATEADD(month,-1,@A_DATE)) AND [YEAR] = YEAR(DATEADD(month,-1,@A_DATE)) AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			INSERT INTO @TABLE_QUANTITY
			SELECT SUM([dbo].[CONVERT_UNIT](UNIT,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)* [QUANTITY]) AS QUANTITY, IN_OUT
			FROM [dbo].[EWIP_HISTORY_INVENTORY] 
			WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE  AND [MONTH] =  CAST(@A_MONTH AS int) AND [YEAR] = CAST(@A_YEAR AS int) AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [STATUS] = 'COMPLETE'
			GROUP BY IN_OUT

			-- SO LUONG NHAP XUAT KHO
			SELECT @QUANTITY_IN = QUANTITY FROM @TABLE_QUANTITY WHERE IN_OUT = 'IN';
			SELECT @QUANTITY_OUT = QUANTITY FROM @TABLE_QUANTITY WHERE IN_OUT = 'OUT';

			IF(@QUANTITY IS NULL) SET @QUANTITY = 0;
			IF(@QUANTITY_IN IS NULL) SET @QUANTITY_IN = 0;
			IF(@QUANTITY_OUT IS NULL) SET @QUANTITY_OUT = 0;

			DECLARE @QUANTITY_MONTH FLOAT;

			-- TON KHO LY THUYET
			SET @QUANTITY_MONTH = @QUANTITY + @QUANTITY_IN - @QUANTITY_OUT;


			IF @CHECK1 > 0
					UPDATE [dbo].[EWIP_INVENTORY_BY_TIME] 
					SET QUANTITY_REAL = [dbo].[CONVERT_UNIT](UNIT,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)* QUANTITY_REAL,UNIT = @A_UNIT,[DATE] = CAST(@A_DATE AS date),[YEAR] = CAST(@A_YEAR AS int),[MONTH] = CAST(@A_MONTH AS int),QUANTITY = @QUANTITY_MONTH
					WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)
			ELSE
			    BEGIN
					INSERT INTO [dbo].[EWIP_INVENTORY_BY_TIME]
					VALUES(@A_SPARE_PART_CODE,@QUANTITY_MONTH,@A_UNIT,@A_DEPARTMENT,@A_STOCK,CAST(@A_DATE AS date),CAST(@A_MONTH AS int),CAST(@A_YEAR AS int),NULL)
				END

			IF @CHECK2 > 0
				IF YEAR(GETDATE()) = CAST(@A_YEAR AS int) AND MONTH(GETDATE()) = CAST(@A_MONTH AS int)
					UPDATE [dbo].[EWIP_SPAREPART_INVENTORY] 
					SET QUANTITY_REAL = [dbo].[CONVERT_UNIT](UNIT_IN_CODE,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)* QUANTITY_REAL,QUANTITY = @QUANTITY_MONTH,UPDATE_DATE = GETDATE(),UNIT_IN_CODE = @A_UNIT
					WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK
				else
					print 'exits';
			ELSE 
				INSERT INTO [dbo].[EWIP_SPAREPART_INVENTORY]
				VALUES(@A_SPARE_PART_CODE,@QUANTITY_MONTH,@A_UNIT,NULL,@A_DEPARTMENT,@A_STOCK,GETDATE(),NULL,@A_USER)
			    
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRAN;
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  ROLLBACK TRAN;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_FILE_TEMP@GET_FILE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_FILE_TEMP@GET_FILE](
@A_FILENAME			NVARCHAR(200),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
			SELECT [Name],[Data],[ContenType] FROM [dbo].[EWIP_FILE_TEMP] WHERE [Name] = @A_FILENAME
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_FILE_TEMP@INSERT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_FILE_TEMP@INSERT](
@A_FILENAME			NVARCHAR(200),
@A_CONTENT_TYPE		NVARCHAR(200),
@A_DATA             VARBINARY(MAX),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    DECLARE @CHECK int = 0;

			SELECT @CHECK = COUNT(*) FROM [dbo].[EWIP_FILE_TEMP] WHERE [Name] = @A_FILENAME 

			IF @CHECK > 0
			   DELETE FROM [dbo].[EWIP_FILE_TEMP] WHERE [Name] = @A_FILENAME 

			INSERT INTO [dbo].[EWIP_FILE_TEMP]
			VALUES(@A_FILENAME,@A_CONTENT_TYPE,@A_DATA)
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@DELETE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@DELETE](
@A_RECEIPT_ISSUE_CODE NVARCHAR(50),
@A_INOUT NVARCHAR(50),
@A_USER    NVARCHAR(50),
@A_STATUS  NVARCHAR(50),
@N_RETURN	int				OUTPUT,
@V_RETURN	NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			BEGIN TRAN;

					DECLARE @A_DATA GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE2;

					IF @A_STATUS = 'COMPLETE'
					  BEGIN
					     if @A_INOUT = 'IN'
						   BEGIN
								INSERT INTO @A_DATA
								SELECT 
									   IVR.CODE_NO AS RECEIPT_ISSUE_CODE,
									   HIS.[SPARE_PART_CODE],
									   '',
									   HIS.QUANTITY,
									   HIS.[UNIT],
									   SPT.PRICE_VN,
									   SPT.PRICE_US,
									   SPT.AMOUNT_VN,
									   SPT.AMOUNT_US,
									   SPT.CAUSE,
									   SPT.NOTE,
									   SPT.STOCK_CODE,
									   SPT.DEPT_CODE,
									   HIS.IN_OUT as INT_OUT,
									   IVR.DATE AS [CREATE_DATE],
									   IVR.[USER_CREATE],
									   IVR.USER_SYS,
									   IVR.ORDER_CODE,
									   IVR.STATUS,
									   '' AS [TYPE_IN_OUT_CODE],
									   '',
									   ''
								FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IVR 
								INNER JOIN [dbo].[EWIP_SP_STOCKIN]  SPT ON IVR.CODE_NO = SPT.STOCK_IN_CODE
								INNER JOIN [dbo].[EWIP_HISTORY_INVENTORY]  HIS ON IVR.CODE_NO = HIS.STOCK_IN_OUT_CODE
								WHERE IVR.CODE_NO = @A_RECEIPT_ISSUE_CODE
							END
						  ELSE
						    BEGIN
								INSERT INTO @A_DATA
								SELECT 
									   IVR.CODE_NO AS RECEIPT_ISSUE_CODE,
									   HIS.[SPARE_PART_CODE],
									   '',
									   HIS.QUANTITY,
									   HIS.[UNIT],
									   NULL,
									   NULL,
									   NULL,
									   NULL,
									   SPT.CAUSE,
									   NULL,
									   SPT.STOCK_CODE,
									   SPT.DEPT_CODE,
									   HIS.IN_OUT as INT_OUT,
									   IVR.DATE AS [CREATE_DATE],
									   IVR.[USER_CREATE],
									   IVR.USER_SYS,
									   IVR.ORDER_CODE,
									   IVR.STATUS,
									   '' AS [TYPE_IN_OUT_CODE],
									   '',
									   SPT.[LOCATION]
								FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IVR 
								INNER JOIN  [dbo].[EWIP_STOCK_OUT] SPT ON IVR.CODE_NO = SPT.[STOCK_OUT_CODE]
								INNER JOIN [dbo].[EWIP_HISTORY_INVENTORY]  HIS ON IVR.CODE_NO = HIS.STOCK_IN_OUT_CODE
								WHERE IVR.CODE_NO = @A_RECEIPT_ISSUE_CODE
							END
					 END

					DELETE FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] WHERE CODE_NO = @A_RECEIPT_ISSUE_CODE
					DELETE FROM [dbo].[EWIP_SP_STOCKIN]  WHERE STOCK_IN_CODE = @A_RECEIPT_ISSUE_CODE
					DELETE FROM [dbo].[EWIP_HISTORY_INVENTORY]  WHERE STOCK_IN_OUT_CODE = @A_RECEIPT_ISSUE_CODE
					DELETE FROM [dbo].[EWIP_STOCK_OUT] WHERE [STOCK_OUT_CODE] = @A_RECEIPT_ISSUE_CODE

					-- RECACULATOR INVENTORY : Tinh lai ton kho khi insert/update/delete
					IF @A_STATUS = 'COMPLETE'
					  BEGIN

							IF @A_INOUT = 'IN'
								BEGIN
									DELETE FROM [dbo].[EWIP_SPAREPART_PRICE] WHERE [STOCK_IN_CODE] = @A_RECEIPT_ISSUE_CODE
								END
							ELSE
								PRINT('NO DELETE PRICE')


						DECLARE @A_DATE DATE
						DECLARE @A_STOCK_CODE VARCHAR(50)
						DECLARE @A_DEPT_CODE NVARCHAR(100)
						DECLARE @A_USER_CREATE NVARCHAR(50)		
						DECLARE @A_SPARE_PART_CODE NVARCHAR(50)					
						DECLARE @A_UNIT NVARCHAR(50)
						DECLARE @A_YEAR int
						DECLARE @A_MONTH int
						DECLARE @A_LOCATION NVARCHAR(500)
					
						DECLARE cursorInventory CURSOR FOR
						SELECT [DEPT_CODE],[STOCK_CODE],[SPARE_PART_CODE],[UNIT],[CREATE_DATE],YEAR([CREATE_DATE]) AS [YEAR],MONTH([CREATE_DATE]) AS [MONTH],[USER_CREATE],[LOCATION]
						FROM @A_DATA

						OPEN cursorInventory

						FETCH NEXT FROM cursorInventory
						INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION

						IF @A_USER_CREATE = '' OR @A_USER_CREATE IS NULL 
							SET @A_USER_CREATE = @A_USER

						WHILE @@FETCH_STATUS = 0
							BEGIN

								IF(@A_DATE <= GETDATE())
									BEGIN
										DECLARE @CountMonth int = DATEDIFF(month,@A_DATE,GETDATE())

										WHILE @CountMonth >= 0
										  BEGIN TRY
										        DECLARE @newDate date = DATEADD(month,-@CountMonth,GETDATE())
												DECLARE @year nvarchar(4) = YEAR(@newDate)
												DECLARE @month nvarchar(2) = MONTH(@newDate)

												EXEC [dbo].[PKG_BUSINESS_CACULATOR_INVENTORY@CALL] 
													 @A_DEPARTMENT = @A_DEPT_CODE,
													 @A_STOCK = @A_STOCK_CODE,
													 @A_SPARE_PART_CODE = @A_SPARE_PART_CODE,
													 @A_UNIT = @A_UNIT,
													 @A_DATE = @newDate,
													 @A_YEAR = @year,
													 @A_MONTH = @month,
													 @A_USER = @A_USER_CREATE,
													 @N_RETURN =@N_RETURN OUT,
													 @V_RETURN = @V_RETURN OUT;

													 IF @N_RETURN <> 0 
														THROW @N_RETURN, @V_RETURN, 1;

												SET @CountMonth = @CountMonth - 1
										  END TRY
										  BEGIN CATCH
												THROW;
										  END CATCH

										  -- update so luong tai vi tri.
										  IF @A_INOUT = 'OUT'
										    BEGIN 
													DECLARE @A_TMP_LOCATION NVARCHAR(50)
													DECLARE locationCursor CURSOR FOR
													select value from string_split(@A_LOCATION,',')

													OPEN locationCursor

													FETCH NEXT FROM locationCursor
													INTO @A_TMP_LOCATION

													WHILE @@FETCH_STATUS = 0
														BEGIN
															UPDATE [dbo].[EWIP_SPAREPART_LOCATION]
																SET [QUANTITY] = CASE ISNULL(LOCATION_CODE,'')
																        WHEN ''
																		  THEN
																				 [QUANTITY] + [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE) * cast(SUBSTRING(@A_TMP_LOCATION,LEN('W')+2,LEN(@A_TMP_LOCATION) - 4 - LEN('W') - 11) as float) -- 11 IS LEN OF DATE 2020-01-01 AND -
																		  ELSE
																				 [QUANTITY] + [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE) * cast(SUBSTRING(@A_TMP_LOCATION,LEN(LOCATION_CODE)+2,LEN(@A_TMP_LOCATION) - 4 - LEN(LOCATION_CODE) - 11) as float)
																	END
																WHERE 
																	[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
																	[DEPT_CODE] = @A_DEPT_CODE AND 
																	[STOCK_CODE] = @A_STOCK_CODE AND 
																	 @A_TMP_LOCATION LIKE 
																	  (CASE 
																		  WHEN LOCATION_CODE = '' THEN   N'W_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar)
																		  WHEN LOCATION_CODE IS NULL THEN  N'W_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar)
																		  ELSE N'' + LOCATION_CODE +'_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar) 
																	  END) AND
																	[EXPIRED_DATE] = CAST(SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_LOCATION) - 9,10) AS date)

																	FETCH NEXT FROM locationCursor
																	INTO @A_TMP_LOCATION
														END

														CLOSE locationCursor
														DEALLOCATE locationCursor
													
											END
									END
								
								FETCH NEXT FROM cursorInventory
								INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION
							END

					CLOSE cursorInventory
					DEALLOCATE cursorInventory
				END

				
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRAN;
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  ROLLBACK TRAN;
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@INIT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@INIT](
@A_STOCK_INT_OUT_CODE NVARCHAR(50),
@A_DEPT_CODE NVARCHAR(50),
@A_STOCK_CODE NVARCHAR(50),
@A_INOUT      NVARCHAR(50),
@N_RETURN	int				OUTPUT,
@V_RETURN	NVARCHAR(50)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			IF @A_INOUT = 'IN'
			 BEGIN
				SELECT IDR.CODE_NO as RECEIPT_ISSUE_CODE,SPIN.SPARE_PART_CODE,SPIN.QUANTITY,SPIN.UNIT_CODE AS UNIT,SPIN.PRICE_VN,SPIN.PRICE_US,SPIN.AMOUNT_VN,SPIN.AMOUNT_US,SPIN.CAUSE,SPIN.NOTE,
			       SPIN.STOCK_CODE,IDR.DEPT_CODE,'' AS [LOCATION],NULL AS [RETURN_TIME],SPIN.TYPE_IN_CODE as TYPE_IN_OUT_CODE,IDR.DATE as CREATE_DATE,SP.NAME_VI
				FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR 
				INNER JOIN [dbo].[EWIP_SP_STOCKIN] SPIN ON IDR.CODE_NO = SPIN.STOCK_IN_CODE
				LEFT JOIN [dbo].[EWIP_SPARE_PART] SP ON SPIN.SPARE_PART_CODE = SP.CODE
				WHERE IDR.DEPT_CODE = @A_DEPT_CODE AND IDR.CODE_NO = @A_STOCK_INT_OUT_CODE AND IDR.STOCK_CODE = @A_STOCK_CODE

			
				SELECT IDR.STOCK_CODE,SPIN.TYPE_IN_CODE,IDR.ORDER_CODE,IDR.USER_CREATE,IDR.DATE,IDR.STATUS,IDR.[DELIVERET_RECEIVER]
				FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR  
				INNER JOIN [dbo].[EWIP_SP_STOCKIN] SPIN ON IDR.CODE_NO = SPIN.STOCK_IN_CODE
				WHERE IDR.DEPT_CODE = @A_DEPT_CODE AND IDR.CODE_NO = @A_STOCK_INT_OUT_CODE AND IDR.STOCK_CODE = @A_STOCK_CODE
			 END
			 ELSE
			   BEGIN
				   SELECT IDR.CODE_NO as RECEIPT_ISSUE_CODE,SPIN.SPARE_PART_CODE,SPIN.[QUANTITY],SPIN.[UNIT_ID] AS UNIT,NULL AS PRICE_VN,NULL AS PRICE_US,NULL AS AMOUNT_VN,NULL AS AMOUNT_US,SPIN.CAUSE,'' AS NOTE,
				       SPIN.STOCK_CODE,IDR.DEPT_CODE,SPIN.[LOCATION],[RETURN_TIME], SPIN.TYPE_OUT_CODE as TYPE_IN_OUT_CODE,IDR.DATE as CREATE_DATE,SP.NAME_VI
					FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR 
					INNER JOIN [dbo].[EWIP_STOCK_OUT] SPIN ON IDR.CODE_NO = SPIN.STOCK_OUT_CODE
					LEFT JOIN [dbo].[EWIP_SPARE_PART] SP ON SPIN.SPARE_PART_CODE = SP.CODE
					WHERE IDR.DEPT_CODE = @A_DEPT_CODE AND IDR.CODE_NO = @A_STOCK_INT_OUT_CODE AND IDR.STOCK_CODE = @A_STOCK_CODE

				
					SELECT IDR.STOCK_CODE,SPIN.TYPE_OUT_CODE as TYPE_IN_CODE,IDR.ORDER_CODE,IDR.USER_CREATE,IDR.DATE,IDR.STATUS,IDR.[DELIVERET_RECEIVER]
					FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR  
					INNER JOIN [dbo].[EWIP_STOCK_OUT] SPIN ON IDR.CODE_NO = SPIN.STOCK_OUT_CODE
					WHERE IDR.DEPT_CODE = @A_DEPT_CODE AND IDR.CODE_NO = @A_STOCK_INT_OUT_CODE AND IDR.STOCK_CODE = @A_STOCK_CODE
			   END
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@PUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@PUT](
@A_DATA   GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE2 READONLY,
@A_USER    NVARCHAR(50),
@A_DELIVER_RECEIVER NVARCHAR(100),
@A_MODE   NVARCHAR(20),
@N_RETURN	int				OUTPUT,
@V_RETURN	NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @A_RECEIPT_ISSUE_CODE NVARCHAR(50);
			DECLARE @A_STATUS NVARCHAR(50);
			DECLARE @A_INOUT NVARCHAR(50);

			SELECT @A_RECEIPT_ISSUE_CODE = [RECEIPT_ISSUE_CODE],@A_STATUS = [STATUS],@A_INOUT =[INT_OUT]  FROM @A_DATA GROUP BY [RECEIPT_ISSUE_CODE],[STATUS],[INT_OUT]

			BEGIN TRAN;
			    IF @A_RECEIPT_ISSUE_CODE = 'N'
					SET @A_RECEIPT_ISSUE_CODE = NEWID()
				ELSE
					BEGIN
						DELETE FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] WHERE CODE_NO = @A_RECEIPT_ISSUE_CODE
						DELETE FROM [dbo].[EWIP_HISTORY_INVENTORY]  WHERE STOCK_IN_OUT_CODE = @A_RECEIPT_ISSUE_CODE

						IF @A_INOUT = 'IN'
							DELETE FROM [dbo].[EWIP_SP_STOCKIN]  WHERE STOCK_IN_CODE = @A_RECEIPT_ISSUE_CODE
						ELSE 
							BEGIN
								DELETE FROM [dbo].[EWIP_STOCK_OUT]  WHERE [STOCK_OUT_CODE] = @A_RECEIPT_ISSUE_CODE
							END
					END
				  
					INSERT INTO [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING]
					SELECT @A_RECEIPT_ISSUE_CODE,[CREATE_DATE],[INT_OUT],[STOCK_CODE],[DEPT_CODE],[USER_CREATE],[USER_SYS],[ORDER_CODE],[STATUS],@A_DELIVER_RECEIVER AS [DELIVERET_RECEIVER]
					FROM @A_DATA
					GROUP BY [DEPT_CODE],[STOCK_CODE],[RECEIPT_ISSUE_CODE],[CREATE_DATE],[INT_OUT],[USER_SYS],[STATUS],[USER_CREATE],[ORDER_CODE]

					IF @A_INOUT = 'IN'
						BEGIN	
							INSERT INTO [dbo].[EWIP_SP_STOCKIN]
								SELECT 
								[SPARE_PART_CODE],
								@A_RECEIPT_ISSUE_CODE,
								[QUANTITY],
								[PRICE_VN],
								[UNIT],
								VENDER_ID,
								[STOCK_CODE],
								[CAUSE],
								[DEPT_CODE],
								[CREATE_DATE],
								[USER_CREATE],
								[AMOUNT_US],
								[AMOUNT_VN],
								[NOTE],
								YEAR([CREATE_DATE]),
								MONTH([CREATE_DATE]),
								[PRICE_US],
								[TYPE_IN_OUT_CODE]
								FROM @A_DATA
								LEFT JOIN [dbo].[EWIP_SPARE_PART] ON CODE = [SPARE_PART_CODE]
						END
					ELSE
					   BEGIN	
							INSERT INTO [dbo].[EWIP_STOCK_OUT]
								 SELECT 
									@A_RECEIPT_ISSUE_CODE,
									[SPARE_PART_CODE],
									[CAUSE],
									[STOCK_CODE],
									[DEPT_CODE],
									[CREATE_DATE],
									YEAR([CREATE_DATE]),
									MONTH([CREATE_DATE]),
									@A_USER,
									[QUANTITY],
									[TYPE_IN_OUT_CODE],
									case when [RETURN_TIME] = '' then null
									    else [RETURN_TIME]
									end,
									[UNIT],
									[LOCATION]
									FROM @A_DATA
						END
					

					INSERT INTO [dbo].[EWIP_HISTORY_INVENTORY]
					SELECT [SPARE_PART_CODE],[QUANTITY],[UNIT],[DEPT_CODE],[STOCK_CODE],[CREATE_DATE],MONTH([CREATE_DATE]),YEAR([CREATE_DATE]),[INT_OUT],@A_RECEIPT_ISSUE_CODE,[STATUS]
					FROM @A_DATA

					-- RECACULATOR INVENTORY : Tinh lai ton kho khi insert/update
					IF @A_STATUS = 'COMPLETE'
					  BEGIN

						IF @A_INOUT = 'IN'
								BEGIN
									DELETE FROM [dbo].[EWIP_SPAREPART_PRICE] WHERE [STOCK_IN_CODE] = @A_RECEIPT_ISSUE_CODE
								END
						 ELSE
						    PRINT('NO DELETE PRICE')

						DECLARE @A_DATE DATE
						DECLARE @A_STOCK_CODE VARCHAR(50)
						DECLARE @A_DEPT_CODE NVARCHAR(100)
						DECLARE @A_USER_CREATE NVARCHAR(50)		
						DECLARE @A_SPARE_PART_CODE NVARCHAR(50)					
						DECLARE @A_UNIT NVARCHAR(50)
						DECLARE @A_YEAR int
						DECLARE @A_MONTH int
						DECLARE @A_LOCATION NVARCHAR(500)
						DECLARE @A_PRICE_VN float
						DECLARE @A_PRICE_US float

					
						DECLARE cursorInventory CURSOR FOR
						SELECT [DEPT_CODE],[STOCK_CODE],[SPARE_PART_CODE],[UNIT],[CREATE_DATE],YEAR([CREATE_DATE]) AS [YEAR],MONTH([CREATE_DATE]) AS [MONTH],[USER_CREATE],[LOCATION],[PRICE_VN],[PRICE_US]
						FROM @A_DATA

						OPEN cursorInventory

						FETCH NEXT FROM cursorInventory
						INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION,@A_PRICE_VN,@A_PRICE_US

						IF @A_USER_CREATE = '' OR @A_USER_CREATE IS NULL 
							SET @A_USER_CREATE = @A_USER

						WHILE @@FETCH_STATUS = 0
							BEGIN

								IF @A_INOUT = 'IN' AND @A_PRICE_VN IS NOT NULL AND @A_PRICE_US IS NOT NULL AND @A_PRICE_VN > 0 AND @A_PRICE_US > 0
									BEGIN
										INSERT INTO  [dbo].[EWIP_SPAREPART_PRICE]
										 VALUES(@A_SPARE_PART_CODE,@A_RECEIPT_ISSUE_CODE,@A_PRICE_VN,@A_PRICE_US,@A_UNIT,@A_DEPT_CODE,@A_DATE)
									END
								 ELSE
									PRINT('NO INSERT PRICE')

								IF(@A_DATE <= GETDATE())
									BEGIN
										DECLARE @CountMonth int = DATEDIFF(month,@A_DATE,GETDATE())

										WHILE @CountMonth >= 0
										  BEGIN TRY
										        DECLARE @newDate date = DATEADD(month,-@CountMonth,GETDATE())
												DECLARE @year nvarchar(4) = YEAR(@newDate)
												DECLARE @month nvarchar(2) = MONTH(@newDate)

												EXEC [dbo].[PKG_BUSINESS_CACULATOR_INVENTORY@CALL] 
													 @A_DEPARTMENT = @A_DEPT_CODE,
													 @A_STOCK = @A_STOCK_CODE,
													 @A_SPARE_PART_CODE = @A_SPARE_PART_CODE,
													 @A_UNIT = @A_UNIT,
													 @A_DATE = @newDate,
													 @A_YEAR = @year,
													 @A_MONTH = @month,
													 @A_USER = @A_USER_CREATE,
													 @N_RETURN =@N_RETURN OUT,
													 @V_RETURN = @V_RETURN OUT;

													 IF @N_RETURN <> 0 
														THROW @N_RETURN, @V_RETURN, 1;

												SET @CountMonth = @CountMonth - 1
										  END TRY
										  BEGIN CATCH
												THROW;
										  END CATCH


										  -- update  so luong tai vi tri, khi tinh ton kho roi thi k cho update.
										  IF @A_INOUT = 'OUT'
										    BEGIN 
													DECLARE @A_TMP_LOCATION NVARCHAR(50)
													DECLARE locationCursor CURSOR FOR
													select value from string_split(@A_LOCATION,',') -- W_20_OK_2021-07-30,01-03_10_OK_2021-07-30

													OPEN locationCursor

													FETCH NEXT FROM locationCursor
													INTO @A_TMP_LOCATION

													PRINT(@A_TMP_LOCATION)

													WHILE @@FETCH_STATUS = 0
														BEGIN
																UPDATE [dbo].[EWIP_SPAREPART_LOCATION]
																SET [QUANTITY] = CASE ISNULL(LOCATION_CODE,'')
																        WHEN ''
																		  THEN
																				 [QUANTITY] - [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE) * cast(SUBSTRING(@A_TMP_LOCATION,LEN('W')+2,LEN(@A_TMP_LOCATION) - 4 - LEN('W') - 11) as float) -- 11 IS LEN OF DATE 2020-01-01 AND -
																		  ELSE
																				 [QUANTITY] - [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE) * cast(SUBSTRING(@A_TMP_LOCATION,LEN(LOCATION_CODE)+2,LEN(@A_TMP_LOCATION) - 4 - LEN(LOCATION_CODE) - 11) as float)
																	END
																WHERE 
																	[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
																	[DEPT_CODE] = @A_DEPT_CODE AND 
																	[STOCK_CODE] = @A_STOCK_CODE AND 
																	 @A_TMP_LOCATION LIKE 
																	  (CASE 
																		  WHEN LOCATION_CODE = '' THEN   N'W_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar)
																		  WHEN LOCATION_CODE IS NULL THEN  N'W_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar)
																		  ELSE N'' + LOCATION_CODE +'_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar) 
																	  END) AND
																	[EXPIRED_DATE] = CAST(SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_LOCATION) - 9,10) AS date)

																	FETCH NEXT FROM locationCursor
																	INTO @A_TMP_LOCATION
														END

														CLOSE locationCursor
														DEALLOCATE locationCursor
													
											END

									END
								
								FETCH NEXT FROM cursorInventory
								INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION,@A_PRICE_VN,@A_PRICE_US
							END

					CLOSE cursorInventory
					DEALLOCATE cursorInventory
				END
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRAN;
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  ROLLBACK TRAN;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@DELETE_QUANTITY_REAL]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@DELETE_QUANTITY_REAL](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_YEAR             NVARCHAR(4),
@A_MONTH			NVARCHAR(2),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK1 int;

			SELECT @CHECK1 = COUNT(*) 
			FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)

			IF @CHECK1 > 0
					DELETE FROM [dbo].[EWIP_INVENTORY_BY_TIME] WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)
			
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@GET_QUANTITY_REAL]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@GET_QUANTITY_REAL](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_YEAR             NVARCHAR(4),
@A_MONTH			NVARCHAR(2),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT [SPARE_PART_CODE],[QUANTITY],[QUANTITY_REAL],[UNIT]
			FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@PUT_QUANTITY_REAL]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@PUT_QUANTITY_REAL](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_QUANTITY_REAL    FLOAT,
@A_UNIT             VARCHAR(20),
@A_DATE				NVARCHAR(50), -- 2021-06-15
@A_YEAR             NVARCHAR(4),
@A_MONTH			NVARCHAR(2),
@A_QUANTITY         FLOAT,
@A_USER             NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK1 int;
			DECLARE @CHECK2 int;
			DECLARE @TABLE_QUANTITY TABLE(QUANTITY float,IN_OUT NVARCHAR(50));

			begin tran;
			SELECT @CHECK1 = COUNT(*) FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)

			SELECT @CHECK2 = COUNT(*) 
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			DECLARE @QUANTITY FLOAT;
			DECLARE @QUANTITY_IN FLOAT;
			DECLARE @QUANTITY_OUT FLOAT;

			-- GET quantity of pre month
			SELECT @QUANTITY =[dbo].[CONVERT_UNIT](UNIT,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)*QUANTITY 
			FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE  [SPARE_PART_CODE] = @A_SPARE_PART_CODE  AND [MONTH] = MONTH(DATEADD(month,-1,@A_DATE)) AND [YEAR] = YEAR(DATEADD(month,-1,@A_DATE)) AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			INSERT INTO @TABLE_QUANTITY
			SELECT SUM([dbo].[CONVERT_UNIT](UNIT,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)* [QUANTITY]) AS QUANTITY, IN_OUT
			FROM [dbo].[EWIP_HISTORY_INVENTORY] 
			WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE  AND [MONTH] =  CAST(@A_MONTH AS int) AND [YEAR] = CAST(@A_YEAR AS int) AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [STATUS] = 'COMPLETE'
			GROUP BY IN_OUT

			-- SO LUONG NHAP XUAT KHO
			SELECT @QUANTITY_IN = QUANTITY FROM @TABLE_QUANTITY WHERE IN_OUT = 'IN';
			SELECT @QUANTITY_OUT = QUANTITY FROM @TABLE_QUANTITY WHERE IN_OUT = 'OUT';

			IF(@QUANTITY IS NULL) SET @QUANTITY = 0;
			IF(@QUANTITY_IN IS NULL) SET @QUANTITY_IN = 0;
			IF(@QUANTITY_OUT IS NULL) SET @QUANTITY_OUT = 0;

			DECLARE @QUANTITY_MONTH FLOAT;

			-- TON KHO LY THUYET
			SET @QUANTITY_MONTH = @QUANTITY + @QUANTITY_IN - @QUANTITY_OUT;

			IF @A_QUANTITY IS NOT NULL AND @A_QUANTITY >= 0
					SET @QUANTITY_MONTH = @A_QUANTITY


			IF @CHECK1 > 0
					UPDATE [dbo].[EWIP_INVENTORY_BY_TIME] 
					SET QUANTITY_REAL = @A_QUANTITY_REAL,UNIT = @A_UNIT,[DATE] = CAST(@A_DATE AS date),[YEAR] = CAST(@A_YEAR AS int),[MONTH] = CAST(@A_MONTH AS int),QUANTITY = @QUANTITY_MONTH
					WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)
			ELSE
			    BEGIN
					INSERT INTO [dbo].[EWIP_INVENTORY_BY_TIME]
					VALUES(@A_SPARE_PART_CODE,@QUANTITY_MONTH,@A_UNIT,@A_DEPARTMENT,@A_STOCK,CAST(@A_DATE AS date),CAST(@A_MONTH AS int),CAST(@A_YEAR AS int),@A_QUANTITY_REAL)
				END


			IF @CHECK2 > 0
			  IF  YEAR(GETDATE()) = CAST(@A_YEAR AS int) AND MONTH(GETDATE()) = CAST(@A_MONTH AS int)
				BEGIN
					UPDATE [dbo].[EWIP_SPAREPART_INVENTORY] 
					SET QUANTITY_REAL = [dbo].[CONVERT_UNIT](@A_UNIT,UNIT_IN_CODE,@A_SPARE_PART_CODE,@A_DEPARTMENT)* @A_QUANTITY_REAL,UPDATE_DATE = GETDATE(),
					    QUANTITY = [dbo].[CONVERT_UNIT](@A_UNIT,UNIT_IN_CODE,@A_SPARE_PART_CODE,@A_DEPARTMENT)* @QUANTITY_MONTH
					WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK 
				END
			   ELSE
			     PRINT('EXIST')
			 ELSE
			   INSERT INTO [dbo].[EWIP_SPAREPART_INVENTORY] 
			   VALUES(@A_SPARE_PART_CODE,@QUANTITY_MONTH,@A_UNIT,@A_QUANTITY_REAL,@A_DEPARTMENT,@A_STOCK,GETDATE(),GETDATE(),@A_USER)
			    
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	Commit tran;
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  rollback tran;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_DELIVERY_RECEIVING@GET]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_DELIVERY_RECEIVING@GET](
@A_DEPT_CODE NVARCHAR(50),
@N_RETURN	int				OUTPUT,
@V_RETURN	NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		    SET NOCOUNT OFF;  
			SELECT * FROM
			(SELECT IDR.[IN_OUT],MONTH(IDR.[DATE]) AS [MONTH],YEAR(IDR.[DATE]) AS [YEAR],IDR.[DATE] AS CREATE_DATE,IDR.CODE_NO AS [STOCK_IN_OUT_CODE],IDR.[STOCK_CODE],INO.NAME,IDR.ORDER_CODE,IDR.USER_CREATE,IDR.[DELIVERET_RECEIVER],IDR.STATUS
			FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR 
			INNER join [dbo].[EWIP_SP_STOCKIN] SPIN ON IDR.CODE_NO = SPIN.STOCK_IN_CODE
			left join [dbo].[EWIP_TYPE_IN_OUT] INO ON SPIN.TYPE_IN_CODE = INO.CODE
			WHERE IDR.[DEPT_CODE] = @A_DEPT_CODE
			UNION
			SELECT IDR.[IN_OUT],MONTH(IDR.[DATE]) AS [MONTH],YEAR(IDR.[DATE]) AS [YEAR],IDR.[DATE] AS CREATE_DATE,IDR.CODE_NO AS [STOCK_IN_OUT_CODE],IDR.[STOCK_CODE],INO1.NAME,IDR.ORDER_CODE,IDR.USER_CREATE,IDR.[DELIVERET_RECEIVER],IDR.STATUS
			FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR 
			INNER join [dbo].[EWIP_STOCK_OUT] SO ON SO.STOCK_OUT_CODE = IDR.CODE_NO
			left join [dbo].[EWIP_TYPE_IN_OUT] INO1 ON SO.TYPE_OUT_CODE = INO1.CODE
			WHERE IDR.[DEPT_CODE] = @A_DEPT_CODE) AS SUB
			ORDER BY SUB.CREATE_DATE DESC

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_DELIVERY_RECEIVING@GET_BY_TIME]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_DELIVERY_RECEIVING@GET_BY_TIME](
@A_DEPT_CODE NVARCHAR(50),
@A_TIME_FROM NVARCHAR(50),
@A_TIME_TO  NVARCHAR(50),
@A_PHIEU NVARCHAR(10),
@A_STATUS NVARCHAR(50),
@N_RETURN	int				OUTPUT,
@V_RETURN	NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		    SET NOCOUNT OFF;  
			DECLARE @SQL NVARCHAR(4000);

			SET @SQL =  
						'SELECT * FROM 
						(SELECT IDR.[IN_OUT],IDR.[DATE] AS CREATE_DATE,IDR.CODE_NO AS [STOCK_IN_OUT_CODE],IDR.[STOCK_CODE],INO.NAME,IDR.ORDER_CODE,IDR.USER_CREATE,IDR.STATUS,MONTH(IDR.[DATE]) AS [MONTH],YEAR(IDR.[DATE]) AS [YEAR]
							FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR 
								INNER join [dbo].[EWIP_SP_STOCKIN] SPIN ON IDR.CODE_NO = SPIN.STOCK_IN_CODE
								left join [dbo].[EWIP_TYPE_IN_OUT] INO ON SPIN.TYPE_IN_CODE = INO.CODE
							WHERE IDR.[DEPT_CODE] = @A_DEPT_CODE AND 
						      IDR.[DATE] BETWEEN CAST(@A_TIME_FROM AS date) AND CAST(@A_TIME_TO AS date) AND
							  IDR.STATUS IN ('+@A_STATUS + ') AND IDR.[IN_OUT] IN ('+@A_PHIEU + ')
                         UNION
							SELECT IDR.[IN_OUT],IDR.[DATE] AS CREATE_DATE,IDR.CODE_NO AS [STOCK_IN_OUT_CODE],IDR.[STOCK_CODE],INO1.NAME,IDR.ORDER_CODE,IDR.USER_CREATE,IDR.STATUS,MONTH(IDR.[DATE]) AS [MONTH],YEAR(IDR.[DATE]) AS [YEAR]
								FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR 
								INNER join [dbo].[EWIP_STOCK_OUT] SO ON SO.STOCK_OUT_CODE = IDR.CODE_NO
								left join [dbo].[EWIP_TYPE_IN_OUT] INO1 ON SO.TYPE_OUT_CODE = INO1.CODE
							WHERE IDR.[DEPT_CODE] = @A_DEPT_CODE AND 
						      IDR.[DATE] BETWEEN CAST(@A_TIME_FROM AS date) AND CAST(@A_TIME_TO AS date) AND
							  IDR.STATUS IN ('+@A_STATUS + ') AND IDR.[IN_OUT] IN ('+@A_PHIEU + ')
						 
						) AS SUB
						ORDER BY SUB.CREATE_DATE DESC'
				EXEC sp_executesql @SQL ,N'@A_DEPT_CODE NVARCHAR(50),@A_TIME_FROM NVARCHAR(50),@A_TIME_TO NVARCHAR(50)', @A_DEPT_CODE = @A_DEPT_CODE,@A_TIME_FROM = @A_TIME_FROM,@A_TIME_TO = @A_TIME_TO

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_KHO@GET]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_KHO@GET](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT * FROM [dbo].[EWIP_STOCK] WHERE DEPT_CODE = @A_DEPARTMENT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LABEL@GET_TEMP]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LABEL@GET_TEMP](
@A_CODE_TEMP       NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
            SELECT LABEL  FROM [dbo].[EWIP_LABEL] WHERE CODE = @A_CODE_TEMP
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@DELETE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION@DELETE](
@A_CODE             NVARCHAR(50),
@A_DEPARTMENT       NVARCHAR(100),
@A_STOCK            VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
		    begin TRAN;
			DELETE FROM [dbo].[EWIP_LOCATIONS] WHERE CODE = @A_CODE AND STOCK_CODE = @A_STOCK AND DEPT_CODE = @A_DEPARTMENT
			DELETE FROM [dbo].[EWIP_SPAREPART_LOCATION]  WHERE [LOCATION_CODE] = @A_CODE AND STOCK_CODE = @A_STOCK AND DEPT_CODE = @A_DEPARTMENT
			COMMIT TRAN;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  ROLLBACK TRAN;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@GET]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION@GET](
@A_DEPARTMENT       NVARCHAR(100),
@A_STOCK            VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			SELECT CODE AS LOCATION,STOCK_CODE AS KHO FROM [EWIP_LOCATIONS] 
			WHERE DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE =@A_STOCK  

			SELECT  lc.[CODE] AS LOCATION,[SPARE_PART_CODE],sp.NAME_VI,spc.NAME AS CONDITION_NAME,spl.UNIT_ID as UNIT,spl.QUANTITY,lc.STOCK_CODE AS KHO,spl.ID AS STT,spl.BARCODE, 1 as QUANTITY_PRINT_LABEL,
			          (CASE 
					       WHEN spl.[EXPIRED_DATE] = '2199-01-01' THEN null 
						   ELSE spl.[EXPIRED_DATE] END) AS EXPIRED_DATE,
					  [TIME_IN]
			FROM [dbo].[EWIP_LOCATIONS] lc
			    RIGHT JOIN [dbo].[EWIP_SPAREPART_LOCATION] spl ON lc.CODE = spl.LOCATION_CODE AND lc.DEPT_CODE = spl.DEPT_CODE AND lc.STOCK_CODE = spl.STOCK_CODE
				LEFT JOIN [dbo].[EWIP_SPARE_PART] sp ON spl.SPARE_PART_CODE = sp.CODE AND spl.DEPT_CODE = sp.[SP_DEPT_CODE]
				LEFT JOIN [dbo].[EWIP_SPAREPART_CONDITION] spc ON spl.CONDITION_CODE = spc.CODE
			WHERE spl.DEPT_CODE = @A_DEPARTMENT AND spl.STOCK_CODE =@A_STOCK --AND spl.QUANTITY > 0
			ORDER BY lc.[CODE]
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@GET_SINGLE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION@GET_SINGLE](
@A_STT              INT,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT  lc.[CODE] AS LOCATION,[SPARE_PART_CODE],sp.NAME_VI,spc.CODE AS CONDITION_CODE,spl.QUANTITY,spl.UNIT_ID AS UNIT,lc.STOCK_CODE AS KHO
			FROM [dbo].[EWIP_LOCATIONS] lc
			    INNER JOIN [dbo].[EWIP_SPAREPART_LOCATION] spl ON lc.CODE = spl.LOCATION_CODE AND lc.DEPT_CODE = spl.DEPT_CODE AND lc.STOCK_CODE = spl.STOCK_CODE
				LEFT JOIN [dbo].[EWIP_SPARE_PART] sp ON spl.SPARE_PART_CODE = sp.CODE
				LEFT JOIN [dbo].[EWIP_SPAREPART_CONDITION] spc ON spl.CONDITION_CODE = spc.CODE
			WHERE spl.ID = @A_STT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@INSERT_BATCH]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION@INSERT_BATCH](
@A_LOCATION_TYPE   LOCATION_TYPE  READONLY,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @DEPART_MENT NVARCHAR(100);
			DECLARE @STOCK VARCHAR(50);
			SELECT DISTINCT @DEPART_MENT =[DEPT_CODE],@STOCK=[STOCK_CODE] FROM @A_LOCATION_TYPE
			INSERT INTO [dbo].[EWIP_LOCATIONS]
            SELECT CODE,[STOCK_CODE],[DEPT_CODE],GETDATE() FROM @A_LOCATION_TYPE WHERE CODE NOT IN (SELECT CODE FROM [dbo].[EWIP_LOCATIONS] WHERE [DEPT_CODE] = @DEPART_MENT AND [STOCK_CODE] = @STOCK)
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@INSERT_SINGLE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION@INSERT_SINGLE](
@A_CODE   NVARCHAR(50),
@A_STOCK_CODE VARCHAR(50),
@A_DEPT_CODE NVARCHAR(100),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			INSERT INTO [dbo].[EWIP_LOCATIONS]
            VALUES(@A_CODE,@A_STOCK_CODE,@A_DEPT_CODE,GETDATE())
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_INIT@GET]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_INIT@GET](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
			SELECT CODE FROM [dbo].[EWIP_LOCATIONS] WHERE DEPT_CODE = @A_DEPARTMENT
			SELECT CODE,NAME FROM [dbo].[EWIP_STOCK] WHERE DEPT_CODE = @A_DEPARTMENT
			SELECT CODE,NAME FROM [dbo].[EWIP_SPAREPART_CONDITION]
			SELECT CODE,NAME FROM [dbo].[EWIP_UNITS] 

			SELECT sp.CODE,sp.NAME_VI
			FROM EWIP_SPARE_PART sp 
			     INNER JOIN EWIP_SPARE_PART_DEPT spd ON sp.CODE = spd.SPARE_PART_CODE AND spd.DEPT_CODE = sp.[SP_DEPT_CODE]
			WHERE sp.[SP_DEPT_CODE] =  @A_DEPARTMENT
			ORDER BY SP.ID DESC;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@CACULAR_REMAIN_QUANTITY]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@CACULAR_REMAIN_QUANTITY](
@A_DEPARTMENT       NVARCHAR(100),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_UNIT             NVARCHAR(20),
@A_QUANTITY_INPUT   FLOAT,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			  DECLARE @QUANTIY_TOTAL float = 0;
			  DECLARE @QUANTIY_IN_POSITION float = 0;

			  SELECT @QUANTIY_IN_POSITION = SUM([dbo].[CONVERT_UNIT]([UNIT_ID],@A_UNIT,[SPARE_PART_CODE],[DEPT_CODE])*[QUANTITY])
			  FROM [dbo].[EWIP_SPAREPART_LOCATION]
			  WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK
			  GROUP BY [DEPT_CODE],[STOCK_CODE],[SPARE_PART_CODE]

			  SELECT @QUANTIY_TOTAL = [dbo].[CONVERT_UNIT]([UNIT_IN_CODE],@A_UNIT,[SPARE_PART_CODE],[DEPT_CODE])* [QUANTITY]
			  FROM [dbo].[EWIP_SPAREPART_INVENTORY]
			  WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			  SELECT (@QUANTIY_TOTAL - @QUANTIY_IN_POSITION - @A_QUANTITY_INPUT) as QUANTITY
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@DELETE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@DELETE](
@A_STT        INT,
@A_SPARE_PART_CODE NVARCHAR(50),
@A_LOCATION        NVARCHAR(50),
@A_CONDITION       VARCHAR(50),
@A_DEPART_MENT     VARCHAR(50),
@A_STOCK           VARCHAR(50),
@A_UNIT            VARCHAR(20),
@A_EXPIRED_DATE    NVARCHAR(50),
@A_TIME_IN         NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			DECLARE @CHECK int;
			DECLARE @CHECK1 int;
			DECLARE @STT INT;

			SELECT @CHECK = COUNT(*) FROM [EWIP_SPAREPART_LOCATION] WHERE ID = @A_STT
			SELECT @CHECK1 = COUNT(*) FROM [EWIP_SPAREPART_LOCATION] 
			WHERE LOCATION_CODE = @A_LOCATION 
					AND SPARE_PART_CODE = @A_SPARE_PART_CODE
					AND UNIT_ID = @A_UNIT 
					AND CONDITION_CODE = @A_CONDITION
			        AND DEPT_CODE =@A_DEPART_MENT 
					AND STOCK_CODE = @A_STOCK
					AND [EXPIRED_DATE] =  CAST(@A_EXPIRED_DATE AS date)
					AND TIME_IN = CAST(@A_TIME_IN AS date)

			IF @CHECK > 0 
				DELETE FROM [dbo].[EWIP_SPAREPART_LOCATION] 
				WHERE ID = @A_STT
			ELSE
			   IF @CHECK1 > 0
					 BEGIN
						SELECT @STT = ID FROM [EWIP_SPAREPART_LOCATION] 
						WHERE LOCATION_CODE = @A_LOCATION 
								AND SPARE_PART_CODE = @A_SPARE_PART_CODE 
								AND UNIT_ID = @A_UNIT 
								AND CONDITION_CODE = @A_CONDITION
								AND DEPT_CODE =@A_DEPART_MENT 
								AND STOCK_CODE = @A_STOCK
								AND [EXPIRED_DATE] =  CAST(@A_EXPIRED_DATE AS date)
								AND TIME_IN = CAST(@A_TIME_IN AS date)

						IF @STT  <> '' AND @STT IS NOT NULL
							DELETE FROM [dbo].[EWIP_SPAREPART_LOCATION] 
							WHERE ID = @STT
					END			
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@GET_LOCATION_BY_SPAREPART]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@GET_LOCATION_BY_SPAREPART](
@A_STOCK_CODE                VARCHAR(50),
@A_DEPT_CODE                 NVARCHAR(50),
@A_SPARE_PART_CODE           NVARCHAR(50),
@A_UNIT                      NVARCHAR(20),
@N_RETURN					 int OUTPUT,
@V_RETURN					 NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT [LOCATION_CODE] AS LOCATION,[CONDITION_CODE],[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPT_CODE) * QUANTITY AS QUANTITY,0.0 AS QUANTITY_GET,@A_UNIT as UNIT,CASE WHEN [EXPIRED_DATE] = '2199-01-01' THEN NULL ELSE [EXPIRED_DATE] END AS [EXPIRED_DATE],TIME_IN
			FROM [dbo].[EWIP_SPAREPART_LOCATION] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPT_CODE AND [STOCK_CODE] = @A_STOCK_CODE AND QUANTITY > 0
			ORDER BY [EXPIRED_DATE],TIME_IN ASC
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@GET_SINGLE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@GET_SINGLE](
@A_STT              INT,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT [LOCATION_CODE] AS LOCATION,[SPARE_PART_CODE],[CONDITION_CODE],QUANTITY,UNIT_ID AS UNIT,STOCK_CODE AS KHO,[EXPIRED_DATE],TIME_IN
			FROM [dbo].[EWIP_SPAREPART_LOCATION] 
			WHERE ID = @A_STT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_ BATCH]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_ BATCH](
@A_DEPARTMENT_CODE             NVARCHAR(50),
@A_STOCK                       VARCHAR(50),
@A_DATA                       SPAREPART_LOCATION_TYPE1 READONLY,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		 --   SET NOCOUNT OFF;  
			--INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
   --         SELECT 
			--	[SPARE_PART_CODE],
			--	[LOCATION_CODE],
			--	[CONDITION_CODE],
			--	CAST([IS_WAITE] AS bit),
			--	CAST([QUANTITY] AS INT),
			--	@A_DEPARTMENT_CODE AS [DEPT_CODE]
			--	,@A_STOCK AS [STOCK_CODE]
			--	,CASE 
			--	     WHEN [LOCATION_CODE] = '' OR [LOCATION_CODE] IS NULL THEN  CASE 
			--		                                                                WHEN [CONDITION_CODE] = 'NG' THEN [SPARE_PART_CODE]+'.NG'
			--																		ELSE [SPARE_PART_CODE]
			--																	END
			--		 ELSE 
			--		     CASE  
			--			      WHEN [CONDITION_CODE] = 'NG' THEN [SPARE_PART_CODE]+'.'+[LOCATION_CODE]+'.NG'
			--				  ELSE [SPARE_PART_CODE]+'.'+[LOCATION_CODE]
			--			END
			--	END
			--	,
			--	[UNIT_ID] 
			--FROM @A_DATA 


			MERGE [dbo].[EWIP_SPAREPART_LOCATION] AS TARGET
			USING @A_DATA AS SOURCE
			ON (
			    TARGET.[SPARE_PART_CODE] = SOURCE.SPARE_PART_CODE AND 
				TARGET.[DEPT_CODE] = @A_DEPARTMENT_CODE AND 
				TARGET.[STOCK_CODE] = @A_STOCK AND
				TARGET.[UNIT_ID] = SOURCE.[UNIT_ID] AND
				TARGET.[CONDITION_CODE] = SOURCE.[CONDITION_CODE] AND
				TARGET.[EXPIRED_DATE] = SOURCE.[EXPIRED_DATE] AND
				TARGET.TIME_IN = SOURCE.TIME_IN 
				)
			WHEN MATCHED AND (TARGET.[LOCATION_CODE] = SOURCE.[LOCATION_CODE] AND TARGET.[LOCATION_CODE] <> '') OR ((TARGET.[LOCATION_CODE] = '' OR TARGET.[LOCATION_CODE] IS NULL) AND (SOURCE.[LOCATION_CODE] = '' OR SOURCE.[LOCATION_CODE] IS NULL))
			   THEN UPDATE SET TARGET.[QUANTITY] = TARGET.[QUANTITY] + CAST(SOURCE.[QUANTITY] AS float)
			WHEN NOT MATCHED BY TARGET
			   THEN INSERT([SPARE_PART_CODE],[LOCATION_CODE],[CONDITION_CODE],[IS_WAITE],[QUANTITY],[DEPT_CODE],[STOCK_CODE],[BARCODE],[UNIT_ID],[EXPIRED_DATE],TIME_IN)
			        VALUES (SOURCE.[SPARE_PART_CODE],
					        SOURCE.[LOCATION_CODE],
							SOURCE.[CONDITION_CODE],
							CAST(SOURCE.[IS_WAITE] AS bit),
							CAST(SOURCE.[QUANTITY] AS float),
							@A_DEPARTMENT_CODE,
							@A_STOCK,
							[dbo].[GETBARCODE](SOURCE.[LOCATION_CODE],SOURCE.[SPARE_PART_CODE],SOURCE.[CONDITION_CODE]),
							SOURCE.[UNIT_ID], cast(SOURCE.[EXPIRED_DATE] as date),cast(SOURCE.[TIME_IN] as date));
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_SPAREPART]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_SPAREPART](
@A_STT        INT,
@A_SPARE_PART_CODE NVARCHAR(50),
@A_LOCATION        NVARCHAR(50),
@A_CONDITION       VARCHAR(50),
@A_ISWATE          BIT,
@A_QUANTITY        FLOAT,
@A_DEPART_MENT     NVARCHAR(50),
@A_STOCK           VARCHAR(50),
@A_BARCODE         NVARCHAR(100),
@A_UNIT            VARCHAR(20),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK int;
			DECLARE @CHECK1 int;
			DECLARE @STT INT;
			DECLARE @IS_WAITE BIT;
			DECLARE @QUANTITY INT;
			DECLARE @UNIT_OLD VARCHAR(20)

			SELECT @CHECK = COUNT(*) 
			FROM [EWIP_SPAREPART_LOCATION] 
			WHERE ID = @A_STT

			SELECT @CHECK1 = COUNT(*) 
			FROM [EWIP_SPAREPART_LOCATION] 
			WHERE
				LOCATION_CODE = @A_LOCATION 
				AND SPARE_PART_CODE = @A_SPARE_PART_CODE
				AND UNIT_ID = @A_UNIT 
				AND CONDITION_CODE = @A_CONDITION
				AND DEPT_CODE =@A_DEPART_MENT 
				AND STOCK_CODE = @A_STOCK

			IF @CHECK > 0 
			   BEGIN
			     SELECT @IS_WAITE = IS_WAITE,@QUANTITY = QUANTITY,@UNIT_OLD = UNIT_ID FROM [EWIP_SPAREPART_LOCATION] WHERE ID = @A_STT

				 IF @IS_WAITE = 'False'
							UPDATE [EWIP_SPAREPART_LOCATION]
							SET [LOCATION_CODE]=@A_LOCATION,[SPARE_PART_CODE] =@A_SPARE_PART_CODE , [CONDITION_CODE] =@A_CONDITION, [IS_WAITE] = @A_ISWATE,[QUANTITY] = @A_QUANTITY,UNIT_ID = @A_UNIT,BARCODE=@A_BARCODE
							WHERE ID = @A_STT
				 ELSE -- UPDATE FOR SPARE PART IS WAITE
				      BEGIN
							IF @A_LOCATION <> '' AND @A_LOCATION IS NOT NULL
								BEGIN
								      -- chuyen tu vi tri wait ra vi tri rack
								      IF @A_QUANTITY >= @QUANTITY * [dbo].[CONVERT_UNIT](@UNIT_OLD,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) -- chuyen toan bo
									   BEGIN
											DECLARE @Check3 int
											SELECT @Check3 = COUNT(*) FROM [EWIP_SPAREPART_LOCATION] WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND LOCATION_CODE = @A_LOCATION AND CONDITION_CODE = @A_CONDITION
											IF @Check3 > 0
											  BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION]
													SET
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														QUANTITY= QUANTITY * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT)+@A_QUANTITY
														WHERE  SPARE_PART_CODE = @A_SPARE_PART_CODE AND LOCATION_CODE = @A_LOCATION AND CONDITION_CODE = @A_CONDITION

													DELETE FROM [EWIP_SPAREPART_LOCATION]  WHERE ID = @A_STT
											  END
											ELSE
											   BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION]
													SET
													    LOCATION_CODE = @A_LOCATION,
														CONDITION_CODE = @A_CONDITION,
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														BARCODE=@A_BARCODE,
														QUANTITY= QUANTITY * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT)
													WHERE ID = @A_STT
												END
										 END
									  ELSE
									     BEGIN
										  -- chuyen 1 phan
										  -- update cho vi tri wait
											UPDATE [EWIP_SPAREPART_LOCATION]
											SET    QUANTITY = QUANTITY*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) - @A_QUANTITY,
												   [SPARE_PART_CODE] =@A_SPARE_PART_CODE , 
												   [CONDITION_CODE] =@A_CONDITION, 
												   UNIT_ID = @A_UNIT,
												   BARCODE=@A_BARCODE
											WHERE ID = @A_STT
											-- insert vao rack

											DECLARE @Check2 int
											SELECT @Check2 = COUNT(*) FROM [EWIP_SPAREPART_LOCATION] WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND LOCATION_CODE = @A_LOCATION AND CONDITION_CODE = @A_CONDITION
											IF @Check2 > 0
												BEGIN
														UPDATE [EWIP_SPAREPART_LOCATION]
														SET    QUANTITY = QUANTITY*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) + @A_QUANTITY,
																UNIT_ID = @A_UNIT
														WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND LOCATION_CODE = @A_LOCATION AND CONDITION_CODE = @A_CONDITION
												END
											ELSE
												BEGIN
													INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION](SPARE_PART_CODE,LOCATION_CODE,CONDITION_CODE,IS_WAITE,QUANTITY,DEPT_CODE,STOCK_CODE,BARCODE,UNIT_ID)
													VALUES(@A_SPARE_PART_CODE,@A_LOCATION,@A_CONDITION,@A_ISWATE,@A_QUANTITY,@A_DEPART_MENT,@A_STOCK,@A_BARCODE,@A_UNIT)
												END
                                         END
								END
						ELSE
									UPDATE [EWIP_SPAREPART_LOCATION]
									SET [LOCATION_CODE]=@A_LOCATION,[SPARE_PART_CODE] =@A_SPARE_PART_CODE , [CONDITION_CODE] =@A_CONDITION, [IS_WAITE] = @A_ISWATE,[QUANTITY] = @A_QUANTITY,UNIT_ID = @A_UNIT,BARCODE=@A_BARCODE
									WHERE ID = @A_STT
				   END
			    END
			ELSE 
			    IF @CHECK1 > 0
				   BEGIN
						SELECT @STT = ID 
						FROM [EWIP_SPAREPART_LOCATION] 
						WHERE LOCATION_CODE = @A_LOCATION 
								AND SPARE_PART_CODE = @A_SPARE_PART_CODE
								AND UNIT_ID = @A_UNIT 
								AND CONDITION_CODE = @A_CONDITION
								AND DEPT_CODE =@A_DEPART_MENT 
								AND STOCK_CODE = @A_STOCK
						IF @STT  <> '' AND @STT IS NOT NULL
							UPDATE [EWIP_SPAREPART_LOCATION]
							SET [LOCATION_CODE]=@A_LOCATION,[SPARE_PART_CODE] =@A_SPARE_PART_CODE , [CONDITION_CODE] =@A_CONDITION, [IS_WAITE] = @A_ISWATE,[QUANTITY] = @A_QUANTITY,UNIT_ID = @A_UNIT,BARCODE=@A_BARCODE
							WHERE ID = @STT;
					END				
				ELSE
			        INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION](SPARE_PART_CODE,LOCATION_CODE,CONDITION_CODE,IS_WAITE,QUANTITY,DEPT_CODE,STOCK_CODE,BARCODE,UNIT_ID)
				    VALUES(@A_SPARE_PART_CODE,@A_LOCATION,@A_CONDITION,@A_ISWATE,@A_QUANTITY,@A_DEPART_MENT,@A_STOCK,@A_BARCODE,@A_UNIT)
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_SPAREPART_EXPIRED]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_SPAREPART_EXPIRED](
@A_STT        INT,
@A_SPARE_PART_CODE NVARCHAR(50),
@A_LOCATION        NVARCHAR(50),
@A_CONDITION       VARCHAR(50),
@A_ISWATE          BIT,
@A_QUANTITY        FLOAT,
@A_DEPART_MENT     NVARCHAR(50),
@A_STOCK           VARCHAR(50),
@A_BARCODE         NVARCHAR(100),
@A_UNIT            VARCHAR(20),
@A_EXPIRED_DATE    NVARCHAR(50),
@A_TIME_IN         NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK int;
			DECLARE @CHECK1 int;
			DECLARE @STT INT;
			DECLARE @IS_WAITE BIT;
			DECLARE @QUANTITY INT;
			DECLARE @UNIT_OLD VARCHAR(20)

			SELECT @CHECK = COUNT(*) 
			FROM [EWIP_SPAREPART_LOCATION] 
			WHERE ID = @A_STT

			SELECT @CHECK1 = COUNT(*) 
			FROM [EWIP_SPAREPART_LOCATION] 
			WHERE
				LOCATION_CODE = @A_LOCATION 
				AND SPARE_PART_CODE = @A_SPARE_PART_CODE
				AND UNIT_ID = @A_UNIT 
				AND CONDITION_CODE = @A_CONDITION
				AND DEPT_CODE =@A_DEPART_MENT 
				AND STOCK_CODE = @A_STOCK
				AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date)
				AND [TIME_IN] = CAST(@A_TIME_IN as date)

			IF @CHECK > 0 
			   BEGIN
			     SELECT @IS_WAITE = IS_WAITE,@QUANTITY = QUANTITY,@UNIT_OLD = UNIT_ID FROM [EWIP_SPAREPART_LOCATION] WHERE ID = @A_STT

				 IF @IS_WAITE = 'False' -- DA CO VI TRI
				       BEGIN
							IF @A_ISWATE = 'True' -- chuyen tu rack ra vi tri wait
							  BEGIN
									IF @A_QUANTITY >= @QUANTITY * [dbo].[CONVERT_UNIT](@UNIT_OLD,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT)
										BEGIN
											DECLARE @Check4 int
											SELECT @Check4 = COUNT(*) 
											FROM [EWIP_SPAREPART_LOCATION]  
											WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND IS_WAITE = 'True' AND CONDITION_CODE = @A_CONDITION AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND [TIME_IN] = CAST(@A_TIME_IN as date)
											IF @Check4 > 0
											  BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION]
													SET
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														QUANTITY= QUANTITY * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT)+@A_QUANTITY,
														BARCODE = @A_BARCODE
														WHERE  SPARE_PART_CODE = @A_SPARE_PART_CODE AND IS_WAITE = 'True' AND CONDITION_CODE = @A_CONDITION AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND [TIME_IN] = CAST(@A_TIME_IN as date)

														DELETE FROM [EWIP_SPAREPART_LOCATION]  WHERE ID = @A_STT
											  END
											ELSE
											   BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION]
													SET
													    LOCATION_CODE = @A_LOCATION,
														CONDITION_CODE = @A_CONDITION,
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														BARCODE=@A_BARCODE,
														QUANTITY= QUANTITY * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT),
														[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date),
														[TIME_IN] = CAST(@A_TIME_IN as date)
													WHERE ID = @A_STT
												END
										END
									ELSE
									  BEGIN
										   -- chuyen 1 phan
										  -- update cho vi tri hien tai
											UPDATE [EWIP_SPAREPART_LOCATION]
											SET    QUANTITY = QUANTITY*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) - @A_QUANTITY,
												   UNIT_ID = @A_UNIT
											WHERE ID = @A_STT
											-- insert vao vi tri waite

											DECLARE @Check5 int
											SELECT @Check5 = COUNT(*) 
											FROM [EWIP_SPAREPART_LOCATION] 
											WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND IS_WAITE = 'True' AND CONDITION_CODE = @A_CONDITION AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND [TIME_IN] = CAST(@A_TIME_IN as date)

											IF @Check5 > 0
												BEGIN
														UPDATE [EWIP_SPAREPART_LOCATION]
														SET    QUANTITY = QUANTITY*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) + @A_QUANTITY,
																UNIT_ID = @A_UNIT
														WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND IS_WAITE = 'True' AND CONDITION_CODE = @A_CONDITION AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND [TIME_IN] = CAST(@A_TIME_IN as date)
												END
											ELSE
												BEGIN
													INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION](SPARE_PART_CODE,LOCATION_CODE,CONDITION_CODE,IS_WAITE,QUANTITY,DEPT_CODE,STOCK_CODE,BARCODE,UNIT_ID,[EXPIRED_DATE],TIME_IN)
													VALUES(@A_SPARE_PART_CODE,@A_LOCATION,@A_CONDITION,@A_ISWATE,@A_QUANTITY,@A_DEPART_MENT,@A_STOCK,@A_BARCODE,@A_UNIT, CAST(@A_EXPIRED_DATE AS date),CAST(@A_TIME_IN as date))
												END
									  END

							  END
							ELSE
							  UPDATE [EWIP_SPAREPART_LOCATION]
								SET [LOCATION_CODE]=@A_LOCATION,[SPARE_PART_CODE] =@A_SPARE_PART_CODE , [CONDITION_CODE] =@A_CONDITION, [IS_WAITE] = @A_ISWATE,[QUANTITY] = @A_QUANTITY,UNIT_ID = @A_UNIT,BARCODE=@A_BARCODE,[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) ,[TIME_IN] = CAST(@A_TIME_IN as date)
								WHERE ID = @A_STT
						END
				 ELSE -- UPDATE FOR SPARE PART IS WAITE
				      BEGIN
							IF @A_LOCATION <> '' AND @A_LOCATION IS NOT NULL
								BEGIN
								      -- chuyen tu vi tri wait ra vi tri rack
								      IF @A_QUANTITY >= @QUANTITY * [dbo].[CONVERT_UNIT](@UNIT_OLD,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) -- chuyen toan bo
									   BEGIN
											DECLARE @Check3 int
											SELECT @Check3 = COUNT(*) 
											FROM [EWIP_SPAREPART_LOCATION] 
											WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND LOCATION_CODE = @A_LOCATION AND CONDITION_CODE = @A_CONDITION AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND [TIME_IN] = CAST(@A_TIME_IN as date)
											IF @Check3 > 0
											  BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION]
													SET
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														QUANTITY= QUANTITY * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT)+@A_QUANTITY
														WHERE  SPARE_PART_CODE = @A_SPARE_PART_CODE AND LOCATION_CODE = @A_LOCATION AND CONDITION_CODE = @A_CONDITION AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND [TIME_IN] = CAST(@A_TIME_IN as date)

													DELETE FROM [EWIP_SPAREPART_LOCATION]  WHERE ID = @A_STT
											  END
											ELSE
											   BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION]
													SET
													    LOCATION_CODE = @A_LOCATION,
														CONDITION_CODE = @A_CONDITION,
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														BARCODE=@A_BARCODE,
														QUANTITY= QUANTITY * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT),
														[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date),
														[TIME_IN] = CAST(@A_TIME_IN as date)
													WHERE ID = @A_STT
												END
										 END
									  ELSE
									     BEGIN
										  -- chuyen 1 phan
										  -- update cho vi tri wait
											UPDATE [EWIP_SPAREPART_LOCATION]
											SET    QUANTITY = QUANTITY*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) - @A_QUANTITY,
												   UNIT_ID = @A_UNIT,
												   [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date),
												   [TIME_IN] = CAST(@A_TIME_IN as date)
											WHERE ID = @A_STT
											-- insert vao rack

											DECLARE @Check2 int
											SELECT @Check2 = COUNT(*) 
											FROM [EWIP_SPAREPART_LOCATION] 
											WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND LOCATION_CODE = @A_LOCATION AND CONDITION_CODE = @A_CONDITION AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND [TIME_IN] = CAST(@A_TIME_IN as date)

											IF @Check2 > 0
												BEGIN
														UPDATE [EWIP_SPAREPART_LOCATION]
														SET    QUANTITY = QUANTITY*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) + @A_QUANTITY,
																UNIT_ID = @A_UNIT
														WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND LOCATION_CODE = @A_LOCATION AND CONDITION_CODE = @A_CONDITION AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND [TIME_IN] = CAST(@A_TIME_IN as date)
												END
											ELSE
												BEGIN
													INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION](SPARE_PART_CODE,LOCATION_CODE,CONDITION_CODE,IS_WAITE,QUANTITY,DEPT_CODE,STOCK_CODE,BARCODE,UNIT_ID,[EXPIRED_DATE],TIME_IN)
													VALUES(@A_SPARE_PART_CODE,@A_LOCATION,@A_CONDITION,@A_ISWATE,@A_QUANTITY,@A_DEPART_MENT,@A_STOCK,@A_BARCODE,@A_UNIT, CAST(@A_EXPIRED_DATE AS date),CAST(@A_TIME_IN as date))
												END
                                         END
								END
						ELSE
									UPDATE [EWIP_SPAREPART_LOCATION]
									SET [LOCATION_CODE]=@A_LOCATION,[SPARE_PART_CODE] =@A_SPARE_PART_CODE , [CONDITION_CODE] =@A_CONDITION, [IS_WAITE] = @A_ISWATE,[QUANTITY] = @A_QUANTITY,UNIT_ID = @A_UNIT,BARCODE=@A_BARCODE,[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date), [TIME_IN] = CAST(@A_TIME_IN as date)
									WHERE ID = @A_STT
				   END
			    END
			ELSE 
			    IF @CHECK1 > 0
				   BEGIN
						SELECT @STT = ID 
						FROM [EWIP_SPAREPART_LOCATION] 
						WHERE LOCATION_CODE = @A_LOCATION 
								AND SPARE_PART_CODE = @A_SPARE_PART_CODE
								AND UNIT_ID = @A_UNIT 
								AND CONDITION_CODE = @A_CONDITION
								AND DEPT_CODE =@A_DEPART_MENT 
								AND STOCK_CODE = @A_STOCK
								AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date)
								AND [TIME_IN] = CAST(@A_TIME_IN as date)

						IF @STT  <> '' AND @STT IS NOT NULL
							UPDATE [EWIP_SPAREPART_LOCATION]
							SET [LOCATION_CODE]=@A_LOCATION,[SPARE_PART_CODE] =@A_SPARE_PART_CODE , [CONDITION_CODE] =@A_CONDITION, [IS_WAITE] = @A_ISWATE,[QUANTITY] = @A_QUANTITY,UNIT_ID = @A_UNIT,BARCODE=@A_BARCODE, [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) ,[TIME_IN] = CAST(@A_TIME_IN as date)
							WHERE ID = @STT;
					END				
				ELSE
			        INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION](SPARE_PART_CODE,LOCATION_CODE,CONDITION_CODE,IS_WAITE,QUANTITY,DEPT_CODE,STOCK_CODE,BARCODE,UNIT_ID,[EXPIRED_DATE],TIME_IN)
				    VALUES(@A_SPARE_PART_CODE,@A_LOCATION,@A_CONDITION,@A_ISWATE,@A_QUANTITY,@A_DEPART_MENT,@A_STOCK,@A_BARCODE,@A_UNIT,CAST(@A_EXPIRED_DATE AS date),CAST(@A_TIME_IN as date))
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@MOVE_SPARE_PART_TO_LOCATION]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@MOVE_SPARE_PART_TO_LOCATION](
@A_STT        INT,
@A_SPARE_PART_CODE NVARCHAR(50),
@A_LOCATION_OLD    NVARCHAR(50),
@A_LOCATION_NEW    NVARCHAR(50),
@A_CONDITION       VARCHAR(50),
@A_QUANTITY        FLOAT,
@A_DEPART_MENT     NVARCHAR(50),
@A_STOCK           VARCHAR(50),
@A_BARCODE         NVARCHAR(100),
@A_UNIT            VARCHAR(20),
@A_EXPIRED_DATE    NVARCHAR(50),
@A_TIME_IN         NVARCHAR(50),
@N_RETURN					 int OUTPUT,
@V_RETURN					 NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK int;
			DECLARE @CHECK1 int;
			DECLARE @IS_WAITE BIT;
			DECLARE @QUANTITY_OLD float;
			DECLARE @UNIT_OLD nvarchar(50);

			SELECT @CHECK = COUNT(*) 
			FROM [EWIP_SPAREPART_LOCATION] 
			WHERE ID = @A_STT

			SELECT @CHECK1 = COUNT(*) 
			FROM [EWIP_SPAREPART_LOCATION] 
			WHERE
				LOCATION_CODE = @A_LOCATION_NEW 
				AND SPARE_PART_CODE = @A_SPARE_PART_CODE
				AND CONDITION_CODE = @A_CONDITION
				AND DEPT_CODE =@A_DEPART_MENT 
				AND STOCK_CODE = @A_STOCK
				AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date)
				AND [TIME_IN] = CAST(@A_TIME_IN as date)

			SELECT @QUANTITY_OLD = QUANTITY,@UNIT_OLD = UNIT_ID FROM [EWIP_SPAREPART_LOCATION] WHERE ID = @A_STT

			IF [dbo].[CONVERT_UNIT](@A_UNIT,@UNIT_OLD,@A_SPARE_PART_CODE,@A_DEPART_MENT) * @A_QUANTITY <= @QUANTITY_OLD
			  BEGIN
					IF @CHECK > 0
						BEGIN
								-- update quantity in old location
								UPDATE [EWIP_SPAREPART_LOCATION]
								SET [QUANTITY] = [QUANTITY] - [dbo].[CONVERT_UNIT](@A_UNIT,UNIT_ID,@A_SPARE_PART_CODE,@A_DEPART_MENT) * @A_QUANTITY
								WHERE ID = @A_STT

								IF [dbo].[CONVERT_UNIT](@A_UNIT,@UNIT_OLD,@A_SPARE_PART_CODE,@A_DEPART_MENT) * @A_QUANTITY = @QUANTITY_OLD
								    BEGIN
											DELETE [EWIP_SPAREPART_LOCATION] WHERE ID = @A_STT
									END

								IF @CHECK1 > 0
										BEGIN
											UPDATE [EWIP_SPAREPART_LOCATION]
											SET [QUANTITY] = [QUANTITY] + [dbo].[CONVERT_UNIT](@A_UNIT,UNIT_ID,@A_SPARE_PART_CODE,@A_DEPART_MENT) * @A_QUANTITY
											WHERE
													LOCATION_CODE = @A_LOCATION_NEW 
													AND SPARE_PART_CODE = @A_SPARE_PART_CODE
													AND CONDITION_CODE = @A_CONDITION
													AND DEPT_CODE =@A_DEPART_MENT 
													AND STOCK_CODE = @A_STOCK
													AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date)
													AND [TIME_IN] = CAST(@A_TIME_IN as date)
										END
								ELSE 
										BEGIN
												IF @A_LOCATION_NEW = '' OR @A_LOCATION_NEW IS NULL
													set @IS_WAITE = 'True'
												ELSE 
													set @IS_WAITE = 'False' 

												INSERT INTO [EWIP_SPAREPART_LOCATION]
												VALUES(@A_SPARE_PART_CODE,@A_LOCATION_NEW,@A_CONDITION,@IS_WAITE,@A_QUANTITY,@A_DEPART_MENT,@A_STOCK,@A_BARCODE,@A_UNIT,CAST(@A_EXPIRED_DATE AS date),CAST(@A_TIME_IN as date))
										END
						END
			  END

		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@DELETE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@DELETE](
@A_CODE				VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
DECLARE @V_CHECK  TINYINT;

BEGIN TRY
	
	SELECT @V_CHECK = COUNT(*) FROM EWIP_SPARE_PART WHERE CODE = @A_CODE AND [SP_DEPT_CODE] = @A_DEPARTMENT

	IF @V_CHECK != 0
		BEGIN	    
		    DELETE [dbo].[EWIP_SPARE_PART] WHERE CODE = @A_CODE AND [SP_DEPT_CODE] = @A_DEPARTMENT
			DELETE [dbo].[EWIP_SPARE_PART_DEPT]  WHERE [SPARE_PART_CODE] = @A_CODE AND [DEPT_CODE] = @A_DEPARTMENT
            DELETE [dbo].[EWIP_SPAREPART_UNIT] WHERE [SPARE_PART_CODE] = @A_CODE AND [DEPT_CODE] = @A_DEPARTMENT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@GET]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@GET](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT sp.CODE,sp.NAME_VI,sp.NAME_KR,sp.SPECIFICATIONS AS SPECIFICATION,sp.GL_ACCOUNT,spd.COST_CTR,V.NAME as VENDER_NAME,u.CODE AS UNIT, T.NAME AS TYPENAME--,SP.DESCRIPTION
			FROM EWIP_SPARE_PART sp 
			     INNER JOIN EWIP_SPARE_PART_DEPT spd ON sp.CODE = spd.SPARE_PART_CODE AND sp.[SP_DEPT_CODE] = spd.DEPT_CODE
				 INNER JOIN EWIP_VENDER v ON SP.VENDER_ID = V.VENDER_ID
				 INNER JOIN EWIP_UNITS u ON SP.UNIT_ID = u.CODE
				 LEFT JOIN EWIP_SPAREPART_TYPE T ON SP.TYPE = T.CODE AND T.DEPT_CODE = @A_DEPARTMENT
			WHERE sp.[SP_DEPT_CODE] = @A_DEPARTMENT
			ORDER BY SP.ID ASC;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@GET_MAX_AUTO_CODE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@GET_MAX_AUTO_CODE](
@A_TYPE             NVARCHAR(50),
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT TOP 1 CODE,CAST(SUBSTRING(CODE, 4, 4) AS int) AS STT
			FROM EWIP_SPARE_PART 
			WHERE CODE LIKE @A_TYPE+'%' AND [SP_DEPT_CODE] = @A_DEPARTMENT
			ORDER BY STT DESC;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@INIT_PUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@INIT_PUT](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
	   SET NOCOUNT OFF;  
		BEGIN
			SELECT VENDER_ID, NAME FROM EWIP_VENDER
			SELECT CODE, NAME FROM EWIP_UNITS
			SELECT ID, COST_CTR FROM EWIP_COST_CTR 
			SELECT ID, GL_ACCOUNT FROM EWIP_GL_ACCOUNT
			SELECT CODE,NAME FROM EWIP_SPAREPART_TYPE WHERE DEPT_CODE = @A_DEPARTMENT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@ONLY_SHOW_SPAREPART]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@ONLY_SHOW_SPAREPART](
@A_DEPARTMENT		NVARCHAR(50),
@A_CODE				NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		BEGIN
			SELECT 
			   sp.CODE,
			   sp.NAME_VI,
			   sp.NAME_KR,
			   sp.VENDER_ID,
			   SP.GL_ACCOUNT,
			   SP.TYPE,
			   SP.MATERIAL,
			   SP.SIZE,
			   SP.WEIGHT,
			   SP.USES,
			   SP.EQUIPMENT_USED,
			   SP.SPECIFICATIONS as SPECIFICATION,
			   SP.UNIT_ID,
			   SP.DESCRIPTION,
			   '' AS COST_CTR,
			   SP.IMAGE,
			   sp.MIN_ORDER
			FROM EWIP_SPARE_PART sp 
			WHERE sp.CODE = @A_CODE AND sp.[SP_DEPT_CODE] = @A_DEPARTMENT;


			SELECT [UNIT_CODE],[UNIT_CODE_MIN],[RATE] 
			FROM [dbo].[EWIP_SPAREPART_UNIT] su
			     INNER JOIN EWIP_SPARE_PART sp ON su.SPARE_PART_CODE = sp.CODE AND sp.[SP_DEPT_CODE] = su.DEPT_CODE
			WHERE su.SPARE_PART_CODE = @A_CODE AND su.DEPT_CODE = @A_DEPARTMENT AND [UNIT_CODE] <> [UNIT_CODE_MIN]
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@PUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@PUT](
@A_CODE						NVARCHAR(50),
@A_NAME_VI					NVARCHAR(50),
@A_NAME_KR					NVARCHAR(50),
@A_CODE_VENDOR				NVARCHAR(50),
@A_GL_ACCOUNT				NVARCHAR(20),
@A_SP_TYPE                  VARCHAR(50),
@A_MATERIAL                 NVARCHAR(50),
@A_SIZE                     NVARCHAR(50),
@A_WEIGHT                   NVARCHAR(50),
@A_USES                     NVARCHAR(200),
@A_EQUIPMENT                NVARCHAR(200),
@A_SPECIFICATION            NVARCHAR(500),
@A_UNIT						NVARCHAR(20),
@A_DESC						NVARCHAR(1000),
@A_COST_CTR					NVARCHAR(10),
@A_DEPARTMENT				NVARCHAR(50),
@A_IMAGE					NVARCHAR(MAX),
@USER				        VARCHAR(50),

@A_UNIT1					NVARCHAR(20),
@A_UNIT2					NVARCHAR(20),
@A_UNIT3					NVARCHAR(20),
@A_UNIT4					NVARCHAR(20),

@A_RATE1					FLOAT,
@A_RATE2					FLOAT,
@A_RATE3					FLOAT,
@A_RATE4					FLOAT,

@A_MIN_ORDER				FLOAT,

@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE	@V_CHECK			TINYINT;
DECLARE	@V_CHECK1			TINYINT;

BEGIN TRY

	SET @V_CHECK = 0;
	SET @V_CHECK1 = 0;

	BEGIN TRAN;
	SELECT @V_CHECK = COUNT(*) FROM EWIP_SPARE_PART WHERE CODE = @A_CODE AND [SP_DEPT_CODE] = @A_DEPARTMENT 
	SELECT @V_CHECK1 = COUNT(*) FROM [EWIP_SPARE_PART_DEPT] WHERE [SPARE_PART_CODE] = @A_CODE AND [DEPT_CODE] = @A_DEPARTMENT 

	IF @V_CHECK != 0 
		BEGIN
			UPDATE EWIP_SPARE_PART 
			SET 
				VENDER_ID = @A_CODE_VENDOR,
				NAME_VI = @A_NAME_VI,
				NAME_KR = @A_NAME_KR,
				UNIT_ID = @A_UNIT,
				GL_ACCOUNT = @A_GL_ACCOUNT,
				[DESCRIPTION] = @A_DESC,
				[TYPE] = @A_SP_TYPE,
				[MATERIAL] =@A_MATERIAL,
				[USES]=@A_USES,
				[EQUIPMENT_USED]=@A_EQUIPMENT,
				[SPECIFICATIONS]=@A_SPECIFICATION,
				[SIZE] = @A_SIZE,
				[WEIGHT]= @A_WEIGHT,
				[UPDATE_BY] = @USER,
				UPDATED_AT = GETDATE(),
				IMAGE = @A_IMAGE,
				MIN_ORDER = @A_MIN_ORDER
			WHERE CODE = @A_CODE AND [SP_DEPT_CODE] = @A_DEPARTMENT 

			IF @V_CHECK1 != 0
				BEGIN
					UPDATE [dbo].[EWIP_SPARE_PART_DEPT]
					SET [COST_CTR] = @A_COST_CTR
					WHERE [SPARE_PART_CODE] = @A_CODE AND [DEPT_CODE] = @A_DEPARTMENT
				END
             ELSE
				INSERT INTO EWIP_SPARE_PART_DEPT([DEPT_CODE],[SPARE_PART_CODE],[COST_CTR])
				VALUES(@A_DEPARTMENT,@A_CODE,@A_COST_CTR)
		END
	ELSE
		BEGIN -- ADD NEW 
			INSERT INTO EWIP_SPARE_PART
			(
				CODE, 
				NAME_VI, 
				NAME_KR, 
				UNIT_ID, 
				GL_ACCOUNT,
				VENDER_ID,
				[IMAGE],
				[DESCRIPTION],
				[TYPE],
				[MATERIAL],
				[USES],
				[EQUIPMENT_USED],
				[SPECIFICATIONS],
				[SIZE],
				[WEIGHT],
				[CREATE_BY],
				[CREATED_AT],
				MIN_ORDER,[SP_DEPT_CODE])
			VALUES (
				@A_CODE, 
				@A_NAME_VI, 
				@A_NAME_KR, 
				@A_UNIT, 
				@A_GL_ACCOUNT,
				@A_CODE_VENDOR,
				@A_IMAGE,
				@A_DESC,
				@A_SP_TYPE,
				@A_MATERIAL,
				@A_USES,
				@A_EQUIPMENT,
				@A_SPECIFICATION,
				@A_SIZE,
				@A_WEIGHT,
				@USER,
				GETDATE(),
				@A_MIN_ORDER,
				@A_DEPARTMENT)

				INSERT INTO EWIP_SPARE_PART_DEPT([DEPT_CODE],[SPARE_PART_CODE],[COST_CTR])
				VALUES(@A_DEPARTMENT,@A_CODE,@A_COST_CTR)
		END

		-- INSERT UNIT FOR SPAREPART--
		 DELETE FROM [dbo].[EWIP_SPAREPART_UNIT] WHERE [SPARE_PART_CODE] = @A_CODE AND [DEPT_CODE] = @A_DEPARTMENT

		 INSERT INTO [dbo].[EWIP_SPAREPART_UNIT]
		 VALUES(@A_CODE,@A_UNIT,@A_UNIT,1,@A_DEPARTMENT)

		 IF @A_UNIT1 IS NOT NULL AND @A_UNIT1 <> ''
			INSERT INTO [dbo].[EWIP_SPAREPART_UNIT]
			VALUES(@A_CODE,@A_UNIT1,@A_UNIT,@A_RATE1,@A_DEPARTMENT)


	     IF @A_UNIT2 IS NOT NULL AND @A_UNIT2 <> ''
			INSERT INTO [dbo].[EWIP_SPAREPART_UNIT]
			VALUES(@A_CODE,@A_UNIT2,@A_UNIT,@A_RATE2,@A_DEPARTMENT)

		 IF @A_UNIT3 IS NOT NULL AND @A_UNIT3 <> ''
			INSERT INTO [dbo].[EWIP_SPAREPART_UNIT]
			VALUES(@A_CODE,@A_UNIT3,@A_UNIT,@A_RATE3,@A_DEPARTMENT)

		 IF @A_UNIT4 IS NOT NULL AND @A_UNIT4 <> ''
			INSERT INTO [dbo].[EWIP_SPAREPART_UNIT]
			VALUES(@A_CODE,@A_UNIT4,@A_UNIT,@A_RATE4,@A_DEPARTMENT)


	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRANSACTION;

	END TRY
	BEGIN CATCH
	SET @N_RETURN = ERROR_NUMBER();
	SET @V_RETURN = ERROR_MESSAGE();
	ROLLBACK TRANSACTION;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@SEARCH]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@SEARCH](
@A_DEPARTMENT		NVARCHAR(50),
@A_CODE             NVARCHAR(50), 
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT sp.CODE,sp.NAME_VI,sp.NAME_KR,SP.DESCRIPTION,sp.GL_ACCOUNT,spd.COST_CTR,V.NAME as VENDER_NAME,u.CODE AS UNIT, T.NAME AS TYPENAME
			FROM EWIP_SPARE_PART sp 
			     INNER JOIN EWIP_SPARE_PART_DEPT spd ON sp.CODE = spd.SPARE_PART_CODE AND spd.DEPT_CODE = @A_DEPARTMENT
				 INNER JOIN EWIP_VENDER v ON SP.VENDER_ID = V.VENDER_ID
				 INNER JOIN EWIP_UNITS u ON SP.UNIT_ID = u.CODE
				 LEFT JOIN EWIP_SPAREPART_TYPE T ON SP.TYPE = T.CODE AND T.DEPT_CODE = @A_DEPARTMENT
			WHERE sp.CODE = @A_CODE
			ORDER BY SP.ID DESC;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@SHOW]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@SHOW](
@A_DEPARTMENT		NVARCHAR(50),
@A_CODE				NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		BEGIN
			SELECT 
			   sp.CODE,
			   sp.NAME_VI,
			   sp.NAME_KR,
			   sp.VENDER_ID,
			   SP.GL_ACCOUNT,
			   SP.TYPE,
			   SP.MATERIAL,
			   SP.SIZE,
			   SP.WEIGHT,
			   SP.USES,
			   SP.EQUIPMENT_USED,
			   SP.SPECIFICATIONS as SPECIFICATION,
			   SP.UNIT_ID,
			   SP.DESCRIPTION,
			   spd.COST_CTR,
			   SP.IMAGE,
			   sp.MIN_ORDER
			FROM EWIP_SPARE_PART sp 
			     INNER JOIN EWIP_SPARE_PART_DEPT spd ON sp.CODE = spd.SPARE_PART_CODE AND spd.DEPT_CODE = @A_DEPARTMENT
				 INNER JOIN EWIP_VENDER v ON SP.VENDER_ID = V.VENDER_ID
				 INNER JOIN EWIP_UNITS u ON SP.UNIT_ID = u.CODE
				 LEFT JOIN EWIP_SPAREPART_TYPE T ON SP.TYPE = T.CODE AND T.DEPT_CODE = @A_DEPARTMENT
			WHERE SP.CODE = @A_CODE and sp.[SP_DEPT_CODE] = @A_DEPARTMENT;

			SELECT [UNIT_CODE],[UNIT_CODE_MIN],[RATE] 
			FROM [dbo].[EWIP_SPAREPART_UNIT] su
			     INNER JOIN EWIP_SPARE_PART sp ON su.SPARE_PART_CODE = sp.CODE
			WHERE su.SPARE_PART_CODE = @A_CODE AND su.DEPT_CODE = @A_DEPARTMENT AND [UNIT_CODE] <> [UNIT_CODE_MIN] and sp.[SP_DEPT_CODE] = @A_DEPARTMENT;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@UPDATE_CODE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@UPDATE_CODE](
@A_DEPARTMENT		NVARCHAR(50),
@A_CODE_OLD          NVARCHAR(50),
@A_CODE_NEW          NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK INT;
			DECLARE @CHECK1 INT;
			SELECT @CHECK = COUNT(*) FROM [dbo].[EWIP_SPARE_PART] WHERE [CODE] = @A_CODE_OLD
			SELECT @CHECK1 = COUNT(*) FROM [dbo].[EWIP_SPARE_PART] WHERE [CODE] = @A_CODE_NEW

			IF @CHECK1 = 0
				IF @CHECK > 0
					BEGIN
					   BEGIN TRAN;
							UPDATE [dbo].[EWIP_SPARE_PART] SET [CODE] = @A_CODE_NEW WHERE [CODE] = @A_CODE_OLD
							UPDATE [dbo].[EWIP_SPARE_PART_DEPT] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT
							UPDATE [dbo].[EWIP_SPAREPART_DOCUMENT] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT
							UPDATE [dbo].[EWIP_SPAREPART_INVENTORY] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT

							UPDATE [dbo].[EWIP_SPAREPART_LOCATION] 
							SET [SPARE_PART_CODE]= @A_CODE_NEW ,[BARCODE] = [dbo].[CREATE_BARCODE](@A_CODE_NEW,[LOCATION_CODE],[CONDITION_CODE])
							WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT

							UPDATE [dbo].[EWIP_SPAREPART_PRICE] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD
							UPDATE [dbo].[EWIP_SPAREPART_UNIT] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT
							UPDATE [dbo].[EWIP_STOCK_OUT] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT
							UPDATE [dbo].[EWIP_SP_STOCKIN] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT
							UPDATE [dbo].[EWIP_SETUP_MINSTOCK] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT

							UPDATE [dbo].[EWIP_ORDER] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT
							UPDATE [dbo].[EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT

							UPDATE [dbo].[EWIP_HISTORY_INVENTORY] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT
							UPDATE [dbo].[EWIP_INVENTORY_BY_TIME] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT

							UPDATE [dbo].[EWIP_BOM] SET [SPARE_PART_CODE]= @A_CODE_NEW WHERE [SPARE_PART_CODE] = @A_CODE_OLD AND [DEPT_CODE] = @A_DEPARTMENT

							SET @N_RETURN = 0;
							SET @V_RETURN = 'MSG_COM_004';
						COMMIT TRAN;
					END
				 ELSE
				    BEGIN
						SET @N_RETURN = -1;
						SET @V_RETURN = 'MSG_NO_EXIST_DATA';
					END
			ELSE
			  BEGIN
				SET @N_RETURN = -1;
				SET @V_RETURN = 'MSG_EXIST_DATA';
			 END
		END

END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@CHECK_INVENTORY_ALARM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@CHECK_INVENTORY_ALARM](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

		    SELECT *
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] inv
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON inv.SPARE_PART_CODE = sp.CODE
			LEFT JOIN [dbo].[EWIP_SETUP_MINSTOCK] mins ON inv.SPARE_PART_CODE = mins.SPARE_PART_CODE AND inv.DEPT_CODE = mins.DEPT_CODE AND inv.STOCK_CODE =mins.STOCK_CODE
			WHERE inv.DEPT_CODE = @A_DEPARTMENT AND inv.QUANTITY <= [dbo].[CONVERT_UNIT](mins.UNIT_CODE,inv.UNIT_IN_CODE,inv.SPARE_PART_CODE,@A_DEPARTMENT)* mins.MIN_STOCK
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@CREATE_BALANCE_WAREHOUSE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@CREATE_BALANCE_WAREHOUSE](
@A_DEPARTMENT		NVARCHAR(50),
@A_USER             NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF; 
			BEGIN TRAN;
			UPDATE [dbo].[EWIP_SPAREPART_INVENTORY]
			SET [QUANTITY] = [QUANTITY_REAL], UPDATE_DATE = GETDATE(),USER_UPDATE = @A_USER
			WHERE [DEPT_CODE] = @A_DEPARTMENT 

			UPDATE [dbo].[EWIP_INVENTORY_BY_TIME]
			SET [QUANTITY] = [QUANTITY_REAL]
			WHERE [DEPT_CODE] = @A_DEPARTMENT AND [MONTH] = MONTH(GETDATE()) AND [YEAR] = YEAR(GETDATE())
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRAN;
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  ROLLBACK TRAN;
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@DELETE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@DELETE](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_IS_INVENTORY        NVARCHAR(2),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			IF @A_IS_INVENTORY = '1'
				DELETE FROM [dbo].[EWIP_SPAREPART_INVENTORY] 
				WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [STOCK_CODE] = @A_STOCK AND [DEPT_CODE] = @A_DEPARTMENT
            ELSE
			   DELETE FROM [dbo].[EWIP_SETUP_MINSTOCK]
			   WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [STOCK_CODE] = @A_STOCK AND [DEPT_CODE] = @A_DEPARTMENT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@GET]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@GET](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT inv.[SPARE_PART_CODE] AS CODE,sp.NAME_VI,sp.NAME_KR,sp.SPECIFICATIONS as SPECIFICATION,
			     [dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)* inv.[QUANTITY] AS [QUANTITY],
				 [dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)*inv.QUANTITY_REAL as QUANTITY_REAL,
			     ([dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)* inv.[QUANTITY] - [dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)*inv.QUANTITY_REAL) as DIFFERENCE_QUANTITY,
			     [dbo].[CONVERT_UNIT](mins.UNIT_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)* mins.MIN_STOCK AS MIN_STOCK ,
				 'PACK' as UNIT,sp.VENDER_ID as VENDER_NAME,inv.STOCK_CODE as KHO,inv.ID,mins.[RATE_ALARM]
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] inv
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON inv.SPARE_PART_CODE = sp.CODE
			LEFT JOIN [dbo].[EWIP_SETUP_MINSTOCK] mins ON inv.SPARE_PART_CODE = mins.SPARE_PART_CODE AND inv.DEPT_CODE = mins.DEPT_CODE AND inv.STOCK_CODE =mins.STOCK_CODE
			WHERE inv.DEPT_CODE = @A_DEPARTMENT

			SELECT sp.CODE,sp.NAME_VI
			FROM EWIP_SPARE_PART sp 
			     INNER JOIN EWIP_SPARE_PART_DEPT spd ON sp.CODE = spd.SPARE_PART_CODE AND spd.DEPT_CODE = @A_DEPARTMENT
				 ORDER BY SP.ID DESC;

			SELECT CODE,NAME FROM [dbo].[EWIP_STOCK] WHERE DEPT_CODE = @A_DEPARTMENT

			SELECT CODE,NAME FROM [dbo].[EWIP_UNITS]

			SELECT [ORDER_ID],[TITLE] FROM [dbo].[EWIP_ORDER] WHERE DEPT_CODE = @A_DEPARTMENT

			SELECT [CODE],[NAME] FROM [dbo].[EWIP_TYPE_IN_OUT]

			SELECT [FROM],[TO],[RATE] 
			FROM  [dbo].[EWIP_EXCHANGE_RATE]
			WHERE [FROM] = 'USD' AND [TO] = 'VN'

		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@GET_BY_SPARE_CODE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@GET_BY_SPARE_CODE](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            NVARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT inv.[QUANTITY],inv.QUANTITY_REAL,UNIT_ID AS UNIT,[IMAGE]
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] inv
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON inv.SPARE_PART_CODE = sp.CODE
			WHERE inv.DEPT_CODE = @A_DEPARTMENT AND inv.STOCK_CODE = @A_STOCK AND inv.SPARE_PART_CODE = @A_SPARE_PART_CODE

			SELECT MIN_STOCK,[UNIT_CODE] AS UNIT,[IMAGE],[RATE_ALARM]
			FROM [dbo].[EWIP_SETUP_MINSTOCK]
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON SPARE_PART_CODE = sp.CODE
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [STOCK_CODE] = @A_STOCK AND DEPT_CODE = @A_DEPARTMENT

		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@PUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@PUT](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_QUANTITY         FLOAT,
@A_QUANTITY_REAL    FLOAT,
@A_UNIT             VARCHAR(20),
@A_USER             NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK1 int;
			DECLARE @CHECK2 int;

			IF(@A_QUANTITY_REAL < 0)
				SET @A_QUANTITY_REAL = NULL; 
			

			SELECT @CHECK1 = COUNT(*) FROM [dbo].[EWIP_SPAREPART_INVENTORY] WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK
			SELECT @CHECK2 = COUNT(*) 
			FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [MONTH] = MONTH(GETDATE()) AND [YEAR]=YEAR(GETDATE())

			IF @CHECK1 > 0
			    BEGIN
					UPDATE [dbo].[EWIP_SPAREPART_INVENTORY] SET QUANTITY = @A_QUANTITY , QUANTITY_REAL = @A_QUANTITY_REAL,UNIT_IN_CODE = @A_UNIT,UPDATE_DATE = GETDATE(),[USER_UPDATE] = @A_USER
					WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK
				END
			ELSE
			    BEGIN
					INSERT INTO [dbo].[EWIP_SPAREPART_INVENTORY]
					VALUES(@A_SPARE_PART_CODE,@A_QUANTITY,@A_UNIT,@A_QUANTITY_REAL,@A_DEPARTMENT,@A_STOCK,GETDATE(),GETDATE(),@A_USER)
				END

			IF @CHECK2 > 0 
				   UPDATE [dbo].[EWIP_INVENTORY_BY_TIME] 
				   SET QUANTITY = @A_QUANTITY , QUANTITY_REAL = @A_QUANTITY_REAL,UNIT = @A_UNIT,[DATE]= GETDATE(),[YEAR] = YEAR(GETDATE()),[MONTH]=MONTH(GETDATE())
				   WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [MONTH] = MONTH(GETDATE()) AND [YEAR]=YEAR(GETDATE())
				ELSE
				   INSERT INTO [dbo].[EWIP_INVENTORY_BY_TIME]
				   VALUES(@A_SPARE_PART_CODE,@A_QUANTITY,@A_UNIT,@A_DEPARTMENT,@A_STOCK,GETDATE(),MONTH(GETDATE()),YEAR(GETDATE()),@A_QUANTITY_REAL)
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@REPORT_BY_SPAREPART]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@REPORT_BY_SPAREPART](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			DECLARE @PACK_UNIT NVARCHAR(50) = 'PACK';

		    SELECT ROW_NUMBER() OVER(ORDER BY inv.SPARE_PART_CODE ASC) as STT,
				inv.SPARE_PART_CODE AS CODE, 
				sp.NAME_VI,sp.NAME_KR,
				sp_type.NAME as SPARE_PART_TYPE,
				'Pack' as UNIT,
				SUB.PRICE_VN/[dbo].[CONVERT_UNIT](SUB.[UNIT_CODE],@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)  AS PRICE_VN,
				SUB.PRICE_US/[dbo].[CONVERT_UNIT](SUB.[UNIT_CODE],@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)  AS PRICE_US,
				[dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*inv.QUANTITY as QUANTITY,
				(SUB.PRICE_VN/[dbo].[CONVERT_UNIT](SUB.[UNIT_CODE],@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT))*[dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*inv.QUANTITY AS AMOUNT_VN,
				(SUB.PRICE_US/[dbo].[CONVERT_UNIT](SUB.[UNIT_CODE],@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)) * [dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*inv.QUANTITY AS AMOUNT_US,
				[dbo].[CONVERT_UNIT](mins.UNIT_CODE,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*mins.MIN_STOCK as MIN_STOCK,
				[dbo].[CONVERT_UNIT](bom.UNIT,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*bom.[WORKING_A_MONTH] AS WORKING_A_MONTH,
				[dbo].[CONVERT_UNIT](sp.UNIT_ID,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*sp.[MIN_ORDER] AS MIN_ORDER,
				SP.VENDER_ID,
				inv.STOCK_CODE
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] inv
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON inv.SPARE_PART_CODE = sp.CODE
			LEFT JOIN [dbo].[EWIP_SETUP_MINSTOCK] mins ON inv.SPARE_PART_CODE = mins.SPARE_PART_CODE AND mins.DEPT_CODE = @A_DEPARTMENT
			LEFT JOIN [dbo].[EWIP_BOM] bom ON inv.SPARE_PART_CODE = bom.[SPARE_PART_CODE] AND bom.[DEPT_CODE] = @A_DEPARTMENT
			LEFT JOIN [dbo].[EWIP_SPAREPART_TYPE] sp_type ON sp.TYPE = sp_type.CODE AND sp_type.DEPT_CODE = @A_DEPARTMENT
			LEFT JOIN (SELECT TOP 1 WITH TIES 
						[SPARE_PART_CODE],
						[PRICE_VN],
						[PRICE_US], 
						[UNIT_CODE]
						FROM [dbo].[EWIP_SPAREPART_PRICE]
						WHERE [DEPT_CODE] = @A_DEPARTMENT
						ORDER BY ROW_NUMBER() OVER(PARTITION BY SPARE_PART_CODE ORDER BY [DATE] DESC)) SUB ON SUB.SPARE_PART_CODE = inv.SPARE_PART_CODE
			WHERE inv.DEPT_CODE = @A_DEPARTMENT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@REPORT_BY_SPAREPART_IN_OUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@REPORT_BY_SPAREPART_IN_OUT](
@A_DEPARTMENT		NVARCHAR(50),
@A_TIME_FROM        NVARCHAR(50),
@A_TIME_TO          NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @PACK_UNIT NVARCHAR(50) = 'PACK';
			DECLARE @SQL NVARCHAR(MAX);

			DECLARE @SOURCE [dbo].[TableType];

			INSERT INTO @SOURCE
			SELECT 
			    --ROW_NUMBER() OVER(ORDER BY inv.SPARE_PART_CODE ASC) as STT,
			    invtime.[MONTH],
				invtime.[YEAR],
				inv.SPARE_PART_CODE AS CODE, 
				sp.NAME_VI,
				sp.SPECIFICATIONS,
				price.PRICE_VN/[dbo].[CONVERT_UNIT](price.[UNIT_CODE],@PACK_UNIT,price.SPARE_PART_CODE,@A_DEPARTMENT) as PRICE_VN,
				price.PRICE_US/[dbo].[CONVERT_UNIT](price.[UNIT_CODE],@PACK_UNIT,price.SPARE_PART_CODE,@A_DEPARTMENT) as PRICE_US,
				v.NAME as VENDER_NAME,
				'Pack' AS UNIT,
				sp_type.NAME as SPARE_PART_TYPE,
				[dbo].[CONVERT_UNIT](mins.UNIT_CODE,@PACK_UNIT,inv.SPARE_PART_CODE,@A_DEPARTMENT)*mins.MIN_STOCK as MIN_STOCK,
				hisInv.QUANTITY_MONTH,
				hisInv.IN_OUT,
				[dbo].[CONVERT_UNIT](invtime.UNIT,@PACK_UNIT,invtime.SPARE_PART_CODE,@A_DEPARTMENT)*invtime.QUANTITY AS QUANTITY,
				[dbo].[CONVERT_UNIT](invtime.UNIT,@PACK_UNIT,invtime.SPARE_PART_CODE,@A_DEPARTMENT)*invtime.QUANTITY_REAL AS QUANTITY_REAL,
				inv.STOCK_CODE
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] inv
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON inv.SPARE_PART_CODE = sp.CODE
			LEFT JOIN [dbo].[EWIP_SETUP_MINSTOCK] mins ON inv.SPARE_PART_CODE = mins.SPARE_PART_CODE AND mins.DEPT_CODE = @A_DEPARTMENT
			LEFT JOIN [dbo].[EWIP_SPAREPART_TYPE] sp_type ON sp.TYPE = sp_type.CODE AND sp_type.DEPT_CODE = @A_DEPARTMENT
			LEFT JOIN [dbo].[EWIP_VENDER] v ON sp.VENDER_ID = v.VENDER_ID
			LEFT JOIN  (
			            SELECT TOP 1 WITH TIES 
						[SPARE_PART_CODE],
						[PRICE_VN],
						[PRICE_US], 
						[UNIT_CODE]
						FROM [dbo].[EWIP_SPAREPART_PRICE]
						WHERE [DEPT_CODE] = @A_DEPARTMENT --AND [DATE] BETWEEN CAST(@A_TIME_FROM AS date) AND CAST(@A_TIME_TO AS date)
						ORDER BY ROW_NUMBER() OVER(PARTITION BY SPARE_PART_CODE ORDER BY [DATE] DESC)
						) AS price ON inv.SPARE_PART_CODE = price.SPARE_PART_CODE
            LEFT JOIN [dbo].[EWIP_INVENTORY_BY_TIME] invtime ON inv.SPARE_PART_CODE = invtime.SPARE_PART_CODE AND invtime.DEPT_CODE = inv.DEPT_CODE
			LEFT JOIN  
			(
				SELECT [SPARE_PART_CODE],[STOCK_CODE],[YEAR],[MONTH],[IN_OUT],SUM([dbo].[CONVERT_UNIT]([UNIT],@PACK_UNIT,SPARE_PART_CODE,@A_DEPARTMENT)*[QUANTITY]) AS QUANTITY_MONTH
				FROM [dbo].[EWIP_HISTORY_INVENTORY] 
				WHERE [DEPT_CODE] = @A_DEPARTMENT AND [DATE] BETWEEN CAST(@A_TIME_FROM AS date) AND CAST(@A_TIME_TO AS date)
				GROUP BY [STOCK_CODE],[SPARE_PART_CODE],[YEAR],[MONTH],IN_OUT
			) as hisInv ON inv.SPARE_PART_CODE = hisInv.SPARE_PART_CODE AND invtime.MONTH= hisInv.MONTH AND invtime.YEAR = hisInv.YEAR
			WHERE inv.DEPT_CODE = @A_DEPARTMENT

			DECLARE @SUM_ALL_ARR NVARCHAR(MAX) = [dbo].[SUM_ALL_ARR](@A_TIME_FROM,@A_TIME_TO);
			DECLARE @ALL_ARR NVARCHAR(MAX) = [dbo].[ALL_ARR](@A_TIME_FROM,@A_TIME_TO);
			DECLARE @RECEIVE_ARR NVARCHAR(MAX) = [dbo].[RECEIVE_ARR](@A_TIME_FROM, @A_TIME_TO);
			DECLARE @DELIVERY_ARR NVARCHAR(MAX) = [dbo].[DELIVERY_ARR](@A_TIME_FROM, @A_TIME_TO);
			DECLARE @STOCK_ARR NVARCHAR(MAX) = [dbo].[STOCK_ARR](@A_TIME_FROM, @A_TIME_TO);
			DECLARE @INVENTORY_ARR NVARCHAR(MAX) = [dbo].[INVENTORY_ARR](@A_TIME_FROM, @A_TIME_TO);

			SET @SQL = N'
					 SELECT 
						ROW_NUMBER() OVER (ORDER BY CODE) AS STT,CODE,NAME_VI,[DESCRIPTION],PRICE_VN,PRICE_US,VENDER_NAME,UNIT,SPARE_PART_TYPE,STOCK_CODE,MIN_STOCK,'+@SUM_ALL_ARR+'
					FROM
						(
						  SELECT CODE,NAME_VI,[DESCRIPTION],PRICE_VN,PRICE_US,VENDER_NAME,UNIT,SPARE_PART_TYPE,STOCK_CODE,MIN_STOCK,'+@ALL_ARR+'
						  FROM 
							(SELECT 
								CODE,NAME_VI,[DESCRIPTION],PRICE_VN,PRICE_US,VENDER_NAME,UNIT,SPARE_PART_TYPE,STOCK_CODE,MIN_STOCK,
								QUANTITY_MONTH,[dbo].[CONVERT_INOUT_STR](IN_OUT)+''_''+[dbo].[CONVERT_MONTH_STR]([MONTH])+''_''+CAST([YEAR] AS NVARCHAR(4)) AS T1,
								QUANTITY,[dbo].[CONVERT_INOUT_STR](''QUANTITY'')+''_''+[dbo].[CONVERT_MONTH_STR]([MONTH])+''_''+CAST([YEAR] AS NVARCHAR(4)) AS T2,
								QUANTITY_REAL,[dbo].[CONVERT_INOUT_STR](''QUANTITY_REAL'')+''_''+[dbo].[CONVERT_MONTH_STR]([MONTH])+''_''+CAST([YEAR] AS NVARCHAR(4)) AS T3
							  FROM @SOURCE
							 ) AS  SOURCE_DATA
							 PIVOT 
							 (
								SUM(QUANTITY_MONTH) FOR T1 IN('+@RECEIVE_ARR+','+@DELIVERY_ARR+')
							 ) AS PV1

							 PIVOT 
							 (
								SUM(QUANTITY) FOR T2 IN('+@STOCK_ARR+')
							 ) AS PV2
							 
							 PIVOT 
							 (
								SUM(QUANTITY_REAL) FOR T3 IN('+@INVENTORY_ARR+')
							 ) AS PV3
						) AS SOURCE_DATA1
					 GROUP BY STOCK_CODE,CODE,NAME_VI,[DESCRIPTION],PRICE_VN,PRICE_US,VENDER_NAME,UNIT,SPARE_PART_TYPE,MIN_STOCK';
			
			PRINT (@SQL)
            EXEC sp_executesql 
						@stmt = @SQL
						,@params = N'@SOURCE TableType readonly'
						,@SOURCE = @SOURCE;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_MIN_STOCK@PUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_MIN_STOCK@PUT](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_UNIT             VARCHAR(20),
@A_MIN_STOCK        FLOAT,
@A_RATE_ALARM       FLOAT,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK2 int;

			SELECT @CHECK2 = COUNT(*) FROM [dbo].[EWIP_SETUP_MINSTOCK] WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			IF @CHECK2 > 0 
				UPDATE [dbo].[EWIP_SETUP_MINSTOCK] SET [MIN_STOCK] = @A_MIN_STOCK ,UNIT_CODE = @A_UNIT ,[RATE_ALARM] = @A_RATE_ALARM  WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK
			ELSE
			   INSERT INTO [dbo].[EWIP_SETUP_MINSTOCK]
			   VALUES(@A_SPARE_PART_CODE,@A_UNIT,@A_MIN_STOCK,@A_STOCK,@A_DEPARTMENT,@A_RATE_ALARM)
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_TYPE@GET]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_TYPE@GET](
@A_DEPARTMENT       NVARCHAR(100),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT * FROM [dbo].[EWIP_SPAREPART_TYPE] WHERE DEPT_CODE = @A_DEPARTMENT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_UNIT@PUT]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_UNIT@PUT](
@A_SPARE_PART_CODE			NVARCHAR(50),
@A_UNIT						NVARCHAR(20),
@A_UNIT_MIN					NVARCHAR(20),
@A_DEPARTMENT				NVARCHAR(50),
@A_RATE                     FLOAT,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY


   DECLARE @CHECK INT;

   SELECT @CHECK = COUNT(*) FROM [dbo].[EWIP_SPAREPART_UNIT] WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT

   IF @CHECK > 0
      UPDATE [dbo].[EWIP_SPAREPART_UNIT]
	  SET UNIT_CODE = @A_UNIT, UNIT_CODE_MIN = @A_UNIT_MIN
	  WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT
  ELSE
     INSERT INTO [dbo].[EWIP_SPAREPART_UNIT]
	 VALUES(@A_SPARE_PART_CODE,@A_UNIT,@A_UNIT_MIN,@A_RATE,@A_DEPARTMENT)

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRANSACTION;

	END TRY
	BEGIN CATCH
	SET @N_RETURN = ERROR_NUMBER();
	SET @V_RETURN = ERROR_MESSAGE();
	ROLLBACK TRANSACTION;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_UNIT@GET]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_UNIT@GET](
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT * FROM [dbo].[EWIP_UNITS] 
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_UNIT_SPAREPART@GET_UNIT_BY_SPAREPART]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_UNIT_SPAREPART@GET_UNIT_BY_SPAREPART](
@A_DEPT_CODE                 NVARCHAR(50),
@A_SPARE_PART_CODE           NVARCHAR(50),
@N_RETURN					 int OUTPUT,
@V_RETURN					 NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT UNIT_CODE AS CODE,UNIT_CODE AS [NAME] , sp.IMAGE  
			FROM [dbo].[EWIP_SPAREPART_UNIT] uni
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON sp.CODE = uni.SPARE_PART_CODE AND sp.[SP_DEPT_CODE] = uni.DEPT_CODE
			WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND uni.DEPT_CODE = @A_DEPT_CODE
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_COMM@CHG_PWD]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_COMM@CHG_PWD](
@A_PLANT	VARCHAR(50),
@A_USER_ID	VARCHAR(50),
@A_CURR_PWD	NVARCHAR(50),
@A_CHG_PWD	NVARCHAR(50),
@N_RETURN  int			 OUTPUT,
@V_RETURN  NVARCHAR(4000) OUTPUT
)
AS

DECLARE @V_CHECK	INT;

BEGIN TRY

  SET @V_CHECK = 0;

    SELECT  @V_CHECK = COUNT(*)
    FROM ESYSMSTUSR T1
    WHERE T1.PLANT = @A_PLANT
	AND T1.USER_ID  = @A_USER_ID
    AND T1.PASSWORD = @A_CURR_PWD;
	--test
    IF @V_CHECK = 0 
	  BEGIN
		SET @N_RETURN = -1;
		SET @V_RETURN = 'MSG_ERR_149';
		RETURN;
	  END

    BEGIN TRAN
		UPDATE ESYSMSTUSR 
		SET PASSWORD = @A_CHG_PWD
		WHERE PLANT = @A_PLANT
		AND USER_ID = @A_USER_ID;
	COMMIT TRAN;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_COMM@GET_GLSR]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC	[dbo].[PKG_COMM@GET_GLSR]
@A_PLANT	VARCHAR(50), 
@N_RETURN	INT OUTPUT, 
@V_RETURN	NVARCHAR(4000) OUTPUT
WITH EXEC AS CALLER
AS
BEGIN TRY
  SELECT 
    T.GLSR,
	T.CHN,
	T.KOR,
	T.ENG,
	T.VTN
  FROM ESYSMSTGLA T
  WHERE T.PLANT = @A_PLANT
  ORDER BY T.GLSR ASC;

  SET @N_RETURN = 0;
  SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_COMM@GET_LANGAGUE]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_COMM@GET_LANGAGUE](
@N_RETURN  int			 OUTPUT,
@V_RETURN  NVARCHAR(4000) OUTPUT
)
AS

BEGIN TRY
  /**SELECT T.COMMCODE AS LANGUAGE,
	 	 T.COMMNAME AS LANGUAGE_DESC
  FROM ESYSMSTCOD T
  WHERE T.COMMGRP = 'LANGUAGE'
  ORDER BY T.COMMCODE;
  **/

  SELECT DEPARTMENT AS CODE, DEPARTMENT  FROM ESYSMSTDEPT-- ORDER BY CODE

  SET @N_RETURN = 0;
  SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_COMM@GET_LOGIN]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_COMM@GET_LOGIN](
@A_PLANT VARCHAR(50),
@A_USER_ID VARCHAR(50),
@A_DEPARTMENT VARCHAR(50),
@N_RETURN  int			 OUTPUT,
@V_RETURN  NVARCHAR(4000) OUTPUT
)
AS 
BEGIN TRY
	SELECT T1.PASSWORD AS PASSWORD,
			T1.USER_ID AS USER_ID,
			T1.USER_NAME AS USER_NAME
	FROM ESYSMSTUSR T1
	WHERE T1.PLANT = @A_PLANT
	AND T1.USER_ID = @A_USER_ID
	AND T1.DEPARTMENT = @A_DEPARTMENT
	AND T1.USEFLAG = 'Y';
  
	SELECT T1.USERROLE,
		   T2.USERROLE_NAME
	FROM ESYSMSTURO T1,
		 ESYSMSTROL T2
	WHERE T1.PLANT = @A_PLANT
	AND T1.USER_ID = @A_USER_ID
	AND T2.PLANT = T1.PLANT
	AND T2.USERROLE = T1.USERROLE;

  SET @N_RETURN = 0;
  SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[PKG_COMM@GET_MENU]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_COMM@GET_MENU](
@A_PLANT		VARCHAR(50),
@A_USER_ID		VARCHAR(50),
@A_LANG			VARCHAR(50),
@A_ACCESS_IP	VARCHAR(50),
@A_ACCESS_PC	VARCHAR(50),
@A_DEPARTMENT	VARCHAR(50),
@N_RETURN		int				OUTPUT,
@V_RETURN		NVARCHAR(4000)	OUTPUT
)
AS

DECLARE @N_CHECK		int;
DECLARE @V_TRAN_TIME	VARCHAR(14);

DECLARE @V_FROM_TIME	VARCHAR(14);
DECLARE @V_TO_TIME		VARCHAR(14);

BEGIN TRY

	SET @V_TRAN_TIME = [dbo].[FUN_CURR_TIME]();

	SELECT @N_CHECK = ISNULL(MAX(T1.HIST_SEQ), 0)
	FROM ESYSLOGLGN T1
	WHERE T1.PLANT = @A_PLANT
	AND T1.USER_ID = @A_USER_ID
	AND T1.DEPARTMENT = @A_DEPARTMENT;

	SET @N_CHECK = @N_CHECK + 1;

	INSERT INTO ESYSLOGLGN(
		PLANT,
		DEPARTMENT,
		USER_ID,
		HIST_SEQ,
		ACCESS_TIME,
		ACCESS_IP,
		ACCESS_PC
	) VALUES (
		@A_PLANT,
		@A_DEPARTMENT,
		@A_USER_ID,
		@N_CHECK,
		@V_TRAN_TIME,
		@A_ACCESS_IP,
		@A_ACCESS_PC
	);

    SELECT T1.MENUSEQ AS MENUSEQ,
            cast(T1.UPRSEQ as varchar(10)) AS UPRSEQ,
            MAX(ISNULL(CASE WHEN @A_LANG = 'KOR' THEN T3.KOR
					 WHEN @A_LANG = 'ENG' THEN T3.ENG
					 WHEN @A_LANG = 'VTN' THEN T3.VTN
					 WHEN @A_LANG = 'CHN' THEN T3.CHN
					 ELSE T3.KOR END, T3.KOR)) AS MENUNAME,
            MAX(T1.FORM) AS FORM,
            MAX(T4.FORMROLE) AS FORMROLE,
            MAX(T1.DISPSEQ) AS DISPSEQ,
            MAX(T1.IMGIDX) AS IMGIDX,
			MAX(T6.ACCESS_TYPE) AS ACCESS_TYPE,
			MAX(T1.IMAGE) AS IMAGE
    FROM ESYSMSTMEU T1
         LEFT OUTER JOIN ESYSMSTMEU T2 ON T2.PLANT = T1.PLANT AND T2.MENUSEQ = T1.UPRSEQ 
         LEFT OUTER JOIN ESYSMSTGLA T3 ON T3.PLANT = T1.PLANT AND T3.GLSR = T1.MENUNAME 
         INNER JOIN ESYSMSTMRO T4 ON T4.PLANT = T1.PLANT AND T4.MENUSEQ = T1.MENUSEQ AND T4.PLANT = T1.PLANT 
         INNER JOIN ESYSMSTURO T5 ON T5.PLANT = T1.PLANT AND T4.USERROLE = T5.USERROLE AND T5.USER_ID = @A_USER_ID
		 LEFT OUTER JOIN ESYSMSTFORM T6 ON T6.PLANT = T1.PLANT AND T6.FORM = T1.FORM 
    WHERE
    T4.USEFLAG = 'Y'
    AND T1.USEFLAG = 'Y'
    AND T1.DISPFLAG = 'Y'
	AND T1.FORM_GUBUN = 'PC'
	AND T1.DEPARTMENT IN ('ALL', @A_DEPARTMENT)
	--AND (T1.UPRSEQ LIKE '1%' OR T1.UPRSEQ LIKE '2%' OR T1.UPRSEQ LIKE '5%')
	GROUP BY T1.MENUSEQ, T1.UPRSEQ
    --ORDER BY ISNULL(T1.UPRSEQ, 0), MAX(T1.DISPSEQ)
	ORDER BY T1.MENUSEQ

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_COMM@PUT_LOGIN]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_COMM@PUT_LOGIN](
@A_PLANT		VARCHAR(50),
@A_USER_ID		VARCHAR(50),
@A_FORM_CODE	NVARCHAR(500),
@A_DEPARTMENT	VARCHAR(50),
@N_RETURN		int				OUTPUT,
@V_RETURN		NVARCHAR(4000)	OUTPUT
)
AS 

DECLARE @V_TRAN_TIME	VARCHAR(14);
DECLARE @N_CHECK		INT;

BEGIN TRY
	
	SET @V_TRAN_TIME = DBO.FUN_CURR_TIME();

	SELECT @N_CHECK = ISNULL(MAX(T1.HIST_SEQ), 0)
	FROM ESYSLOGFORM T1
	WHERE T1.PLANT = @A_PLANT 
	AND T1.USER_ID = @A_USER_ID 
	AND T1.DEPARTMENT = @A_DEPARTMENT;

	SET @N_CHECK = @N_CHECK + 1;

	DECLARE @V_FORM_CODE  VARCHAR(50)

	SELECT @V_FORM_CODE = GLSR FROM ESYSMSTGLA WHERE (KOR = @A_FORM_CODE OR VTN = @A_FORM_CODE)

	BEGIN TRAN
	INSERT INTO ESYSLOGFOM(PLANT,DEPARTMENT,USER_ID,HIST_SEQ,FORM_CODE,ACCESS_TYPE)
	VALUES (@A_PLANT, @A_DEPARTMENT, @A_USER_ID, @N_CHECK, @V_FORM_CODE, @V_TRAN_TIME);
	COMMIT TRAN;
	

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT001@GET_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_LOGDAT001@GET_LIST](
@A_DEPARTMENT		VARCHAR(50),
@A_FROM_DATE		VARCHAR(50),
@A_TO_DATE			VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
	if(@A_USER_ID = '') SET @A_USER_ID = NULL;

	SELECT T1.USER_ID,
           T2.USER_NAME AS USER_NAME,
           dbo.[CHAR_TO_DATE](T1.ACCESS_TIME) AS ACCESS_TIME,
           T1.ACCESS_IP,
           T1.ACCESS_PC
    FROM ESYSLOGLGN T1,
            ESYSMSTUSR T2
    WHERE T1.DEPARTMENT = @A_DEPARTMENT
    AND T2.USER_ID = T1.USER_ID
    AND T1.USER_ID = ISNULL(@A_USER_ID, T1.USER_ID)
    AND T1.ACCESS_TIME BETWEEN @A_FROM_DATE+'000000' AND @A_TO_DATE+'235959'
    ORDER BY T1.ACCESS_TIME;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT001@INT_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_LOGDAT001@INT_LIST](
@A_DEPARTMENT		VARCHAR(50),
@A_ROLE				VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	IF @A_ROLE = 'ROLE_ADMIN'
		BEGIN
			SELECT '' AS USERID,
				   '' AS USER_NAME,
				   '' AS ACCESS_TIME,
				   '' AS ACCESS_IP,
				   '' AS ACCESS_PC
			WHERE @@ROWCOUNT < 0;

			SELECT T.USER_ID AS USER_ID,
				   T.USER_NAME AS USER_NAME
			FROM ESYSMSTUSR T
			ORDER BY T.USER_NAME ASC;
		END
	ELSE
		BEGIN
			SELECT '' AS USERID,
				   '' AS USER_NAME,
				   '' AS ACCESS_TIME,
				   '' AS ACCESS_IP,
				   '' AS ACCESS_PC
			WHERE @@ROWCOUNT < 0;

			SELECT T.USER_ID AS USER_ID,
				   T.USER_NAME AS USER_NAME
			FROM ESYSMSTUSR T
			WHERE T.DEPARTMENT = @A_DEPARTMENT
			ORDER BY T.USER_NAME ASC;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT002@GET_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_LOGDAT002@GET_LIST](
@A_PLANT			VARCHAR(50),
@A_FROM_DATE		VARCHAR(50),
@A_TO_DATE			VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_LANG				VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
if(@A_USER_ID = '')
set @A_USER_ID = NULL;
	SELECT T1.USER_ID AS USER_ID,
		   MAX(T2.USER_NAME) AS USER_NAME,
            T1.FORM_CODE AS FORM_CODE,
			 MAX(CASE WHEN @A_LANG = 'KOR' THEN T3.KOR
					  WHEN @A_LANG = 'VTN' THEN T3.VTN
				ELSE T3.VTN END) AS FORMNAME,
            COUNT(*) AS ACCESS_COUNTER,
            MAX(dbo.[CHAR_TO_DATE](T1.ACCESS_TIME)) AS LAST_ACCESS_TIME
    FROM ESYSLOGFOM T1,
            ESYSMSTUSR T2,
            ESYSMSTGLA T3
    WHERE T1.PLANT = @A_PLANT
    AND T2.PLANT = T1.PLANT
    AND T2.USER_ID = T1.USER_ID
    AND T3.PLANT = T1.PLANT
    AND T3.GLSR = T1.FORM_CODE
    AND T2.USER_ID = ISNULL(@A_USER_ID,T2.USER_ID)
    AND T1.ACCESS_TIME > @A_FROM_DATE+'000000' AND T1.ACCESS_TIME < @A_TO_DATE +'235959'
	and T1.USER_ID <> 'H2002001'
    GROUP BY T1.USER_ID, T1.FORM_CODE
    --ORDER BY T1.USER_ID, COUNT(*) DESC;
	ORDER BY LAST_ACCESS_TIME DESC

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT002@INT_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_LOGDAT002@INT_LIST](
@A_PLANT			VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
	SELECT '' AS USERID,
           '' AS FORM_CODE,
           '' AS FORMNAME,
           0 AS ACCESS_COUNTER,
           '' AS LAST_ACCESS_TIME
	WHERE @@ROWCOUNT < 0;

	SELECT T.USER_ID AS USER_ID,
           T.USER_NAME AS USER_NAME
    FROM ESYSMSTUSR T
    WHERE T.PLANT = @A_PLANT
    ORDER BY T.USER_NAME ASC;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT002@POP_GET_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_LOGDAT002@POP_GET_LIST](
@A_PLANT			VARCHAR(50),
@A_FROM_DATE		VARCHAR(50),
@A_TO_DATE			VARCHAR(50),
@A_FORM_CODE		VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_LANG				VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY

    SELECT T1.USER_ID,
           T1.FORM_CODE,
           (CASE WHEN @A_LANG = 'KOR' THEN T2.KOR
					  WHEN @A_LANG = 'VTN' THEN T2.VTN END)
			 AS FORMNAME,
           dbo.[CHAR_TO_DATE](T1.ACCESS_TIME) AS LAST_ACCESS_TIME
    FROM ESYSLOGFOM T1,
         ESYSMSTGLA T2
    WHERE T1.PLANT = @A_PLANT
    AND T2.PLANT = T1.PLANT
    AND T2.GLSR = T1.FORM_CODE
    AND T1.USER_ID = @A_USER_ID
    AND T1.FORM_CODE = @A_FORM_CODE
    AND T1.ACCESS_TIME BETWEEN @A_FROM_DATE+'000000' AND @A_TO_DATE+'235959'
    ORDER BY T1.ACCESS_TIME;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM001@GET_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stored Procedure

CREATE PROCEDURE [dbo].[PKG_SYSTEM001@GET_LIST](
@A_PLANT			VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
	SELECT T.GLSR AS GLSR,
			T.VTN AS VTN,
			T.KOR AS KOR,
			DBO.CHAR_TO_DATE(T.CREATE_TIME) AS CREATE_TIME,
			T.CREATE_USER AS CREATE_USER,
			--,
			DBO.CHAR_TO_DATE(T.UPDATE_TIME) AS UPDATE_TIME,
			T.UPDATE_USER
    FROM ESYSMSTGLA T
    WHERE T.PLANT = @A_PLANT
	--AND T.USE_FLAG = 'Y'
	--AND CREATE_TIME LIKE '202007%' OR CREATE_TIME LIKE '202006%' OR CREATE_TIME LIKE '202008%' 
    ORDER BY T.GLSR ASC;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH







GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM001@INT_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM001@INT_LIST](
@A_PLANT			VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
	SELECT T.GLSR AS GLSR,
			T.VTN AS VTN,
			T.KOR AS KOR
    FROM ESYSMSTGLA T
    WHERE T.PLANT = @A_PLANT
	--AND T.USE_FLAG = 'Y'
	--AND CREATE_TIME LIKE '202007%' OR CREATE_TIME LIKE '202006%' OR CREATE_TIME LIKE '202008%' 
    ORDER BY T.GLSR ASC;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM001@PUT_ITEM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM001@PUT_ITEM](
@A_PLANT			VARCHAR(50),
@A_GLSR				VARCHAR(4000),
@A_KOR				NVARCHAR(4000),
@A_VTN				NVARCHAR(4000),
@A_TRAN_USER_ID		VARCHAR(30),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE @V_TRAN_TIME	VARCHAR(14);
DECLARE	@V_CHECK		INT;

BEGIN TRY

	SET @V_TRAN_TIME = DBO.FUN_CURR_TIME();
	SET @V_CHECK = 0;

	SELECT @V_CHECK = COUNT(*)
    FROM ESYSMSTGLA T1
    WHERE T1.PLANT = @A_PLANT
    AND T1.GLSR = @A_GLSR;

	BEGIN TRAN

	IF @V_CHECK != 0
		BEGIN
			UPDATE ESYSMSTGLA
			SET 
				KOR = @A_KOR,
				VTN = @A_VTN,
				UPDATE_TIME = @V_TRAN_TIME,
				UPDATE_USER = @A_TRAN_USER_ID
			WHERE PLANT = @A_PLANT
			AND GLSR = @A_GLSR;
		END
    ELSE
		BEGIN
			INSERT INTO ESYSMSTGLA (
				PLANT,
				GLSR,
				KOR,
				VTN,
				CREATE_TIME,
				CREATE_USER
			) VALUES (
				@A_PLANT,
				@A_GLSR,
				@A_KOR,
				@A_VTN,
				@V_TRAN_TIME,
				@A_TRAN_USER_ID
			);
		END

	COMMIT TRAN;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM002@GET_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM002@GET_LIST](
@A_PLANT			VARCHAR(50),
@A_LANG				VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
	SELECT T.FORM AS FORM,
            ( CASE WHEN @A_LANG = 'KOR' THEN T1.KOR
					WHEN @A_LANG = 'VTN' THEN T1.VTN
			 END) AS FORMNAME,
            T.USEFLAG AS USEFLAG,
            T.REMARKS AS REMARKS
     FROM ESYSMSTFORM T
	LEFT JOIN ESYSMSTGLA T1 ON T.FORM = T1.GLSR AND T.DEPARTMENT = T1.DEPARTMENT
    WHERE T.PLANT = @A_PLANT
    ORDER BY T.FORM ASC;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM002@INT_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM002@INT_LIST](
@A_PLANT			VARCHAR(50),
@A_LANG				VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
	SELECT T.FORM AS FORM,
           ( CASE WHEN @A_LANG = 'KOR' THEN T1.KOR
					WHEN @A_LANG = 'VTN' THEN T1.VTN
			 END) AS FORMNAME,
            T.USEFLAG AS USEFLAG,
            T.REMARKS AS REMARKS
    FROM ESYSMSTFORM T
	LEFT JOIN ESYSMSTGLA T1 ON T.FORM = T1.GLSR AND T.DEPARTMENT = T1.DEPARTMENT
    WHERE T.PLANT = @A_PLANT
    ORDER BY T.FORM ASC;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM002@PUT_ITEM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM002@PUT_ITEM](
@A_PLANT			VARCHAR(10),
@A_FORM				VARCHAR(30),
@A_FORMNAME			NVARCHAR(50),
@A_USEFLAG			VARCHAR(1),
@A_REMARKS			NVARCHAR(4000),
@A_TRAN_USER_ID		VARCHAR(30),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE @V_TRAN_TIME	VARCHAR(14);
DECLARE	@V_CHECK		INT;

BEGIN TRY

	SET @V_TRAN_TIME = DBO.FUN_CURR_TIME();
	SET @V_CHECK = 0;

	SELECT @V_CHECK = COUNT(*)
    FROM ESYSMSTFORM T1
    WHERE T1.PLANT = @A_PLANT
    AND T1.FORM = @A_FORM;

	BEGIN TRAN

	IF @V_CHECK != 0
		BEGIN
			UPDATE ESYSMSTFORM
			SET FORMNAME = @A_FORMNAME,
				USEFLAG = @A_USEFLAG,
				REMARKS = @A_REMARKS,
				UPDATE_TIME = @V_TRAN_TIME,
				UPDATE_USER = @A_TRAN_USER_ID
			WHERE PLANT = @A_PLANT
			AND FORM = @A_FORM;

			UPDATE ESYSMSTMEU 
			SET USEFLAG = @A_USEFLAG
			WHERE PLANT = @A_PLANT
			AND MENUNAME = @A_FORM
		END
    ELSE
		BEGIN
			INSERT INTO ESYSMSTFORM (
				PLANT,
				DEPARTMENT,
				FORM,
				FORMNAME,
				USEFLAG,
				REMARKS,
				CREATE_TIME,
				CREATE_USER
			) VALUES (
				@A_PLANT,
				'ALL',
				@A_FORM,
				@A_FORMNAME,
				@A_USEFLAG,
				@A_REMARKS,
				@V_TRAN_TIME,
				@A_TRAN_USER_ID
			);
		END

	COMMIT TRAN;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM004@GET_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM004@GET_LIST](
@A_PLANT			VARCHAR(50),
@A_USERROLE			VARCHAR(50),
@A_LANG				VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
DECLARE @V_MASTER_FLAG VARCHAR(1);

BEGIN TRY

SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID AND T1.DEPARTMENT = @A_DEPARTMENT)
IF(@V_MASTER_FLAG = 'Y')
BEGIN	
		SELECT ISNULL(T3.USEFLAG, 'N') AS USEFLAG,
              ( CASE WHEN @A_LANG = 'KOR' THEN T2.KOR
					WHEN @A_LANG = 'VTN' THEN T2.VTN
			 END) AS MENUNAME,
              T1.MENUSEQ AS MENUSEQ,
              T1.UPRSEQ AS UPRSEQ,
              T3.FORMROLE AS FORMROLE
       FROM ESYSMSTMEU T1 
			LEFT OUTER JOIN ESYSMSTGLA T2 ON T2.PLANT = T1.PLANT AND T2.GLSR = T1.MENUNAME
			LEFT OUTER JOIN ESYSMSTMRO T3 ON T3.PLANT = T1.PLANT AND T3.MENUSEQ = T1.MENUSEQ AND T3.USERROLE = @A_USERROLE
       WHERE T1.PLANT = @A_PLANT
       --ORDER BY T1.UPRSEQ, T1.DISPSEQ;
	   ORDER BY T1.MENUSEQ
END
ELSE
BEGIN
		SELECT ISNULL(T3.USEFLAG, 'N') AS USEFLAG,
              ( CASE WHEN @A_LANG = 'KOR' THEN T2.KOR
					WHEN @A_LANG = 'VTN' THEN T2.VTN
			 END) AS MENUNAME,
              T1.MENUSEQ AS MENUSEQ,
              T1.UPRSEQ AS UPRSEQ,
              T3.FORMROLE AS FORMROLE
       FROM ESYSMSTMEU T1 
			LEFT OUTER JOIN ESYSMSTGLA T2 ON T2.PLANT = T1.PLANT AND T2.GLSR = T1.MENUNAME
			LEFT OUTER JOIN ESYSMSTMRO T3 ON T3.PLANT = T1.PLANT AND T3.MENUSEQ = T1.MENUSEQ AND T3.USERROLE = @A_USERROLE
       WHERE T1.PLANT = @A_PLANT
	   --AND T1.MENUNAME NOT LIKE '%SYSTEM%'
	   AND T1.MENUNAME <> 'SYSTEM001' AND T1.MENUNAME <>'SYSTEM002' AND T1.MENUNAME <> 'SYSTEM006' AND T1.MENUNAME <>'SYSTEM007' AND T1.MENUNAME <>'SYSTEM014'
	   AND T1.MENUNAME <> 'MENU_LOG' AND T1.MENUNAME <> 'LOGDAT001' AND T1.MENUNAME <> 'LOGDAT002'
	   AND T1.USEFLAG = 'Y'
       --ORDER BY T1.UPRSEQ, T1.DISPSEQ;
	   ORDER BY T1.MENUSEQ
END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM004@INT_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM004@INT_LIST](
@A_PLANT			VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
DECLARE @V_MASTER_FLAG VARCHAR(1);
BEGIN TRY
SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID)
IF(@V_MASTER_FLAG = 'Y')
BEGIN	
		SELECT T.USERROLE AS USERROLE,
               T.USERROLE_NAME AS USERROLE_NAME
        FROM ESYSMSTROL T
        WHERE T.PLANT = @A_PLANT
        ORDER BY T.USERROLE ASC;

		SELECT 'N' AS USEFLAG,
               '' AS MENUNAME,
               '' AS MENUSEQ,
               '' AS UPRSEQ,
               '' AS FORMROLE
		WHERE @@ROWCOUNT < 0
END
ELSE
BEGIN
		SELECT T.USERROLE AS USERROLE,
               T.USERROLE_NAME AS USERROLE_NAME
        FROM ESYSMSTROL T
        WHERE T.PLANT = @A_PLANT
		AND T.USERROLE <> 'ROLE_ADMIN'
        ORDER BY T.USERROLE ASC;

		SELECT 'N' AS USEFLAG,
               '' AS MENUNAME,
               '' AS MENUSEQ,
               '' AS UPRSEQ,
               '' AS FORMROLE
		WHERE @@ROWCOUNT < 0
END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM004@PUT_ITEM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM004@PUT_ITEM](
@A_PLANT			VARCHAR(50),
@A_USERROLE			VARCHAR(50),
@A_XML				XML,
@A_TRAN_USER_ID		VARCHAR(30),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE	@V_TRAN_TIME	VARCHAR(14);

DECLARE @V_MENUSEQ		INT;
DECLARE @V_FORMROLE		VARCHAR(3);
DECLARE	@V_USEFLAG		VARCHAR(1);



BEGIN TRY
	SET @V_TRAN_TIME = dbo.FUN_CURR_TIME();

	BEGIN TRAN

		DELETE
		FROM ESYSMSTMRO
		WHERE PLANT = @A_PLANT
		AND USERROLE = @A_USERROLE 
	
		DECLARE R_REC cursor for
		SELECT DISTINCT
			'MENUSEQ' = x.v.value('MENUSEQ[1]', 'INT'),
			'FORMROLE' = x.v.value('FORMROLE[1]', 'varchar(3)'),
			'USEFLAG' = x.v.value('USEFLAG[1]', 'VARCHAR(1)')
		FROM @A_XML.nodes('DocumentElement/Table') x(v);

		OPEN R_REC
		FETCH NEXT FROM R_REC into @V_MENUSEQ, @V_FORMROLE, @V_USEFLAG;
	
		WHILE @@FETCH_STATUS = 0
			BEGIN

				INSERT INTO ESYSMSTMRO (
					PLANT,
					DEPARTMENT,
					USERROLE,
					MENUSEQ,
					FORMROLE,
					USEFLAG,
					CREATE_TIME,
					CREATE_USER
				) VALUES (
					@A_PLANT,
					'ALL',
					@A_USERROLE,
					@V_MENUSEQ,
					@V_FORMROLE,
					@V_USEFLAG,
					@V_TRAN_TIME,
					@A_TRAN_USER_ID
				);
				FETCH NEXT FROM R_REC into @V_MENUSEQ, @V_FORMROLE, @V_USEFLAG;
			END
		CLOSE R_REC;
		DEALLOCATE R_REC;
	COMMIT TRAN;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM005@GET_DETAIL]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PKG_SYSTEM005@GET_DETAIL](
@A_USER_ID				VARCHAR(50),
@N_RETURN				int				OUTPUT,
@V_RETURN				NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY

	SELECT USR.PLANT, USR.DEPARTMENT, USR.USER_ID, USR.PASSWORD, USR.USER_NAME, USR.PHONE_NUM,
	USR.EMAIL, USR.USEFLAG, USR.ADDRESS, USR.REMARKS, USR.MASTER_FLAG, 
	USRL.USERROLE
	FROM ESYSMSTUSR USR 
	LEFT JOIN ESYSMSTURO USRL ON USR.USER_ID = USRL.USER_ID
	LEFT JOIN ESYSMSTROL ROLE ON USRL.USERROLE = ROLE.USERROLE
	WHERE USR.USER_ID = @A_USER_ID

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM005@GET_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM005@GET_LIST](
@A_PLANT			VARCHAR(50),
@A_LANG				VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE @V_MASTER_FLAG VARCHAR(1);

BEGIN TRY
SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID AND T1.DEPARTMENT = @A_DEPARTMENT)
IF(@V_MASTER_FLAG = 'Y')
BEGIN	
		SELECT T.USER_ID AS USER_ID,
				T.PASSWORD,
               T.USER_NAME AS USER_NAME,
               T.PHONE_NUM AS PHONE_NUM,
               T.EMAIL AS EMAIL,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS,
			   T.DEPARTMENT
        FROM ESYSMSTUSR T
        ORDER BY T.USER_ID ASC;
END
ELSE
BEGIN
		SELECT T.USER_ID AS USER_ID,
				T.PASSWORD,
               T.USER_NAME AS USER_NAME,
               T.PHONE_NUM AS PHONE_NUM,
               T.EMAIL AS EMAIL,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS,
			   T.DEPARTMENT
        FROM ESYSMSTUSR T
        WHERE T.PLANT = @A_PLANT
		AND T.MASTER_FLAG IS NULL
		AND T.USEFLAG = 'Y'
		AND T.DEPARTMENT = @A_DEPARTMENT
        ORDER BY T.USER_ID ASC;
END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM005@INT_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM005@INT_LIST](
@A_PLANT			VARCHAR(50),
@A_LANG				VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE @V_MASTER_FLAG		VARCHAR(1);
DECLARE @V_IS_ADMIN			TINYINT;

BEGIN TRY

/**SET @V_IS_ADMIN = (SELECT COUNT(*) FROM ESYSMSTUSR USR
INNER JOIN ESYSMSTURO USRL ON USR.USER_ID = USRL.USER_ID
INNER JOIN ESYSMSTROL ROLE ON USRL.USERROLE = ROLE.USERROLE
WHERE USR.USER_ID = @A_USER_ID)**/

SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID AND T1.DEPARTMENT = @A_DEPARTMENT)
IF(@V_MASTER_FLAG = 'Y')
BEGIN	
		SELECT T.USER_ID AS USER_ID,
               T.PASSWORD AS PASSWORD,
               T.USER_NAME AS USER_NAME,
               T.PHONE_NUM AS PHONE_NUM,
               T.EMAIL AS EMAIL,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS,
			   T.DEPARTMENT
        FROM ESYSMSTUSR T
        ORDER BY T.USER_ID ASC;

		SELECT * FROM ESYSMSTDEPT;

END
ELSE
BEGIN
		SELECT T.USER_ID AS USER_ID,
               T.PASSWORD AS PASSWORD,
               T.USER_NAME AS USER_NAME,
               T.PHONE_NUM AS PHONE_NUM,
               T.EMAIL AS EMAIL,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS,
			   T.DEPARTMENT
        FROM ESYSMSTUSR T
        WHERE T.PLANT = @A_PLANT
		AND T.MASTER_FLAG IS NULL
		AND T.USEFLAG = 'Y'
		AND T.DEPARTMENT = @A_DEPARTMENT
        ORDER BY T.USER_ID ASC;

		SELECT * FROM ESYSMSTDEPT WHERE DEPARTMENT = @A_DEPARTMENT;
END



	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM005@PUT_ITEM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM005@PUT_ITEM](
@A_PLANT			VARCHAR(50),
@A_USER_ID			VARCHAR(20),
@A_PASSWORD			NVARCHAR(200),
@A_USER_NAME		NVARCHAR(100),
@A_PHONE_NUM		NVARCHAR(30),
@A_EMAIL			NVARCHAR(100),
@A_USEFLAG			VARCHAR(1),
@A_REMARKS			NVARCHAR(4000),
@A_TRAN_USER_ID		VARCHAR(30),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE	@V_TRAN_TIME	VARCHAR(14);
DECLARE	@V_CHECK		INT;
DECLARE	@V_MASTER_FLAG	VARCHAR(5);



BEGIN TRY
	SET @V_TRAN_TIME = dbo.FUN_CURR_TIME();
	SET @V_CHECK = 0;

	SELECT @V_CHECK = COUNT(*)
    FROM ESYSMSTUSR T1
    WHERE T1.PLANT = @A_PLANT
    AND T1.USER_ID = @A_USER_ID
	AND T1.DEPARTMENT = @A_DEPARTMENT
	;

	BEGIN TRAN
		IF @V_CHECK != 0 
			BEGIN
				SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_TRAN_USER_ID)
				IF(@V_MASTER_FLAG = 'Y')
				BEGIN	
					UPDATE ESYSMSTUSR
					SET USER_NAME = @A_USER_NAME,
						PASSWORD = @A_PASSWORD,
						PHONE_NUM = @A_PHONE_NUM,
						EMAIL = @A_EMAIL,
						USEFLAG = @A_USEFLAG,
						REMARKS = @A_REMARKS,
						UPDATE_TIME = @V_TRAN_TIME,
						UPDATE_USER = @A_TRAN_USER_ID,
						DEPARTMENT = @A_DEPARTMENT
					WHERE  USER_ID = @A_USER_ID
				END
				ELSE
					BEGIN
						UPDATE ESYSMSTUSR
						SET USER_NAME = @A_USER_NAME,
							PASSWORD = @A_PASSWORD,
							PHONE_NUM = @A_PHONE_NUM,
							EMAIL = @A_EMAIL,
							USEFLAG = @A_USEFLAG,
							REMARKS = @A_REMARKS,
							UPDATE_TIME = @V_TRAN_TIME,
							UPDATE_USER = @A_TRAN_USER_ID,
							DEPARTMENT = @A_DEPARTMENT
						WHERE PLANT = @A_PLANT
						AND USER_ID = @A_USER_ID
						AND DEPARTMENT = @A_DEPARTMENT;
					END
			END
		ELSE
			BEGIN
				INSERT INTO ESYSMSTUSR (
					PLANT,
					DEPARTMENT,
					USER_ID,
					PASSWORD,
					USER_NAME,
					PHONE_NUM,
					EMAIL,
					USEFLAG,
					REMARKS,
					CREATE_TIME,
					CREATE_USER
				) VALUES (
					@A_PLANT,
					@A_DEPARTMENT,
					@A_USER_ID,
					@A_PASSWORD,
					@A_USER_NAME,
					@A_PHONE_NUM,
					@A_EMAIL,
					@A_USEFLAG,
					@A_REMARKS,
					@V_TRAN_TIME,
					@A_TRAN_USER_ID
				);
			END
	COMMIT TRAN;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM006@GET_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM006@GET_LIST](
@A_PLANT			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
		SELECT T.USERROLE AS USERROLE,
               T.USERROLE_NAME AS USERROLE_NAME,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS
        FROM ESYSMSTROL T
        WHERE T.USERROLE <> 'ROLE_ADMIN'
        ORDER BY T.USERROLE ASC;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM006@INT_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM006@INT_LIST](
@A_PLANT			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
	
		SELECT T.USERROLE AS USERROLE,
               T.USERROLE_NAME AS USERROLE_NAME,
               T.USEFLAG AS USEFLAG,
               T.REMARKS AS REMARKS
        FROM ESYSMSTROL T
		WHERE T.USERROLE <> 'ROLE_ADMIN'
        ORDER BY T.USERROLE ASC;

		SELECT T1.USERROLE AS USERROLE,
               T1.USERROLE_NAME AS USERROLE_NAME
        FROM ESYSMSTROL T1
        WHERE T1.PLANT = @A_PLANT
		AND T1.USEFLAG = 'Y'
		AND T1.DEPARTMENT = @A_DEPARTMENT
        ORDER BY T1.USERROLE;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM006@PUT_ITEM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM006@PUT_ITEM](
@A_PLANT			VARCHAR(50),
@A_USERROLE			VARCHAR(20),
@A_USERROLE_NAME	NVARCHAR(100),
@A_USEFLAG			VARCHAR(1),
@A_REMARKS			NVARCHAR(4000),
@A_TRAN_USER_ID		VARCHAR(30),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE	@V_TRAN_TIME	VARCHAR(14);
DECLARE	@V_CHECK		INT;

BEGIN TRY

	SET @V_TRAN_TIME = dbo.FUN_CURR_TIME();
	SET @V_CHECK = 0;

	SELECT @V_CHECK = COUNT(*)
    FROM ESYSMSTROL T1
    WHERE T1.PLANT = @A_PLANT
    AND T1.USERROLE = @A_USERROLE
	AND T1.DEPARTMENT = @A_DEPARTMENT;
	
	BEGIN TRAN

		IF @V_CHECK != 0 
			BEGIN
				UPDATE ESYSMSTROL
				SET USERROLE_NAME = @A_USERROLE_NAME,
					USEFLAG = @A_USEFLAG,
					REMARKS = @A_REMARKS,
					UPDATE_TIME = @V_TRAN_TIME,
					UPDATE_USER = @A_TRAN_USER_ID
				WHERE PLANT = @A_PLANT
				AND USERROLE = @A_USERROLE
				AND DEPARTMENT = @A_DEPARTMENT;
			END
		ELSE
			BEGIN
				INSERT INTO ESYSMSTROL (
					PLANT,
					DEPARTMENT,
					USERROLE,
					USERROLE_NAME,
					USEFLAG,
					REMARKS,
					CREATE_TIME,
					CREATE_USER
				) VALUES (
					@A_PLANT,
					@A_DEPARTMENT,
					@A_USERROLE,
					@A_USERROLE_NAME,
					@A_USEFLAG,
					@A_REMARKS,
					@V_TRAN_TIME,
					@A_TRAN_USER_ID
				);
			END

	COMMIT TRAN

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM008@GET_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM008@GET_LIST](
@A_PLANT			VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE @V_MASTER_FLAG VARCHAR(1);

BEGIN TRY

	SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID and T1.DEPARTMENT = @A_DEPARTMENT)
	IF(@V_MASTER_FLAG = 'Y')
	BEGIN	
		SELECT CASE WHEN T2.USER_ID IS NULL THEN 'N'
					ELSE 'Y' END AS SEL,
			   T1.USERROLE,
			   T1.USERROLE_NAME
		FROM ESYSMSTROL T1 LEFT OUTER JOIN ESYSMSTURO T2 
		ON T2.USERROLE = T1.USERROLE AND T2.USER_ID = @A_USER_ID AND T2.PLANT = @A_PLANT AND T1.DEPARTMENT = T2.DEPARTMENT
	END
	ELSE
	BEGIN
		SELECT CASE WHEN T2.USER_ID IS NULL THEN 'N'
					ELSE 'Y' END AS SEL,
			   T1.USERROLE,
			   T1.USERROLE_NAME
		FROM ESYSMSTROL T1 LEFT OUTER JOIN ESYSMSTURO T2 
		ON T2.USERROLE = T1.USERROLE AND T2.USER_ID = @A_USER_ID AND T2.PLANT = @A_PLANT
		WHERE T1.USERROLE <> 'ROLE_ADMIN'
	END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM008@INT_LIST]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM008@INT_LIST](
@A_PLANT			VARCHAR(50),
@A_USER_ID			VARCHAR(50),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE @V_MASTER_FLAG VARCHAR(1);

BEGIN TRY
SET @V_MASTER_FLAG = (SELECT T1.MASTER_FLAG FROM ESYSMSTUSR T1 WHERE T1.USER_ID = @A_USER_ID AND T1.DEPARTMENT = @A_DEPARTMENT)
IF(@V_MASTER_FLAG = 'Y')
BEGIN	
		SELECT T1.USER_ID,
			   T1.USER_NAME,
			   T1.DEPARTMENT
			   --T2.COMMNAME AS DEPT_NAME
		FROM ESYSMSTUSR T1
			 --LEFT OUTER JOIN ESYSMSTCOD T2 ON T2.PLANT = T1.PLANT AND T2.COMMGRP = 'USER_DEPT'-- AND T2.COMMCODE = T1.DEPT_CODE
		WHERE T1.PLANT = @A_PLANT
		AND T1.USEFLAG = 'Y'
		--AND T1.DEPARTMENT = @A_DEPARTMENT
		ORDER BY T1.USER_NAME;

		SELECT 'N' AS SEL,
			   T1.USERROLE AS USERROLE,
               T1.USERROLE_NAME AS USERROLE_NAME
	    FROM ESYSMSTROL T1
		WHERE T1.PLANT = @A_PLANT
		AND T1.USEFLAG = 'Y'
		ORDER BY T1.USERROLE_NAME;
END
ELSE
BEGIN
		SELECT T1.USER_ID,
			   T1.USER_NAME
			   --t1.DEPT_CODE,
			   --T2.COMMNAME AS DEPT_NAME
		FROM ESYSMSTUSR T1
			 --LEFT OUTER JOIN ESYSMSTCOD T2 ON T2.PLANT = T1.PLANT AND T2.COMMGRP = 'USER_DEPT'-- AND T2.COMMCODE = T1.DEPT_CODE
		WHERE T1.PLANT = @A_PLANT
		AND T1.USEFLAG = 'Y'
		AND T1.MASTER_FLAG IS NULL
		AND T1.DEPARTMENT = @A_DEPARTMENT
		ORDER BY T1.USER_NAME;

		SELECT 'N' AS SEL,
			   T1.USERROLE AS USERROLE,
               T1.USERROLE_NAME AS USERROLE_NAME
	    FROM ESYSMSTROL T1
		WHERE T1.PLANT = @A_PLANT
		AND T1.USEFLAG = 'Y'
		AND T1.USERROLE <> 'ROLE_ADMIN'
		AND T1.DEPARTMENT = @A_DEPARTMENT
		ORDER BY T1.USERROLE_NAME;
END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH







GO
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM008@PUT_ITEM]    Script Date: 7/17/2021 2:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM008@PUT_ITEM](
@A_PLANT			VARCHAR(50),
@A_XML				XML,
@A_USER_ID			VARCHAR(50),
@A_TRAN_USER_ID		VARCHAR(30),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE	@V_TRAN_TIME	VARCHAR(14);

DECLARE @V_USERROLE		VARCHAR(30);
DECLARE @V_COUNT		INT;


BEGIN TRY
	SET @V_TRAN_TIME = dbo.FUN_CURR_TIME();

	BEGIN TRAN

		DELETE
		FROM ESYSMSTURO
		WHERE PLANT = @A_PLANT
		AND USER_ID = @A_USER_ID
		AND DEPARTMENT = @A_DEPARTMENT
		;

	
		DECLARE R_REC cursor for
		SELECT DISTINCT
			'USERROLE' = x.v.value('USERROLE[1]', 'VARCHAR(30)')
		FROM @A_XML.nodes('DocumentElement/Table') x(v);

		OPEN R_REC
		FETCH NEXT FROM R_REC into @V_USERROLE;

		SET @V_COUNT = 0; 

		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @V_COUNT = @V_COUNT + 1;

				INSERT INTO ESYSMSTURO (
					PLANT,
					DEPARTMENT,
					USER_ID,
					ITEM_NO,
					USERROLE,
					CREATE_TIME,
					CREATE_USER
				) VALUES (
					@A_PLANT,
					@A_DEPARTMENT,
					@A_USER_ID,
					@V_COUNT,
					@V_USERROLE,
					@V_TRAN_TIME,
					@A_TRAN_USER_ID
				);
				FETCH NEXT FROM R_REC into @V_USERROLE;
			END
		CLOSE R_REC
	COMMIT TRAN;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lich su nhap xuat kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_INVENTORY', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'don vi nhap kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_INVENTORY', @level2type=N'COLUMN',@level2name=N'UNIT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ngay nhap xuat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_INVENTORY', @level2type=N'COLUMN',@level2name=N'DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'thang' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_INVENTORY', @level2type=N'COLUMN',@level2name=N'MONTH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_INVENTORY', @level2type=N'COLUMN',@level2name=N'YEAR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1: nhap kho 0: xuat kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_INVENTORY', @level2type=N'COLUMN',@level2name=N'IN_OUT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nguyen nhan sua chua' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', @level2type=N'COLUMN',@level2name=N'CAUSE_REPAIR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'thoi gian sua chua' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', @level2type=N'COLUMN',@level2name=N'TIME_REPAIR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'thoi gian hoan thanh' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', @level2type=N'COLUMN',@level2name=N'TIME_SUCCESS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'cach thuc sua chua' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', @level2type=N'COLUMN',@level2name=N'ACTION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nguoi sua chua' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', @level2type=N'COLUMN',@level2name=N'USER_REPARE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: NEW, 1: INPROGRESS , 2: COMPLETE , 4: CANCEL' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_INVENTORY_DELIVERY_RECEIVING', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vị trí :01-01' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_LOCATIONS', @level2type=N'COLUMN',@level2name=N'CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma Kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_LOCATIONS', @level2type=N'COLUMN',@level2name=N'STOCK_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma Phong ban' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_LOCATIONS', @level2type=N'COLUMN',@level2name=N'DEPT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NULL : CHUA ORDER ,1: ORDERED 0: HUY ORDER' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_ORDER', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma thiet bi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'SPARE_PART_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma phieu nhap Kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'STOCK_IN_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Don gia/dvi san pham' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'PRICE_VN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Don vi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'UNIT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma nha cung cap' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'VENDER_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma Kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'STOCK_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nguyen nhan nhap kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'CAUSE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma phong ban' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'DEPT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngay nhap kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'DATE_IN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tien theo so luong, don vi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'AMOUNT_US'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tien theo so luong, don vi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'AMOUNT_VN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ghi chu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'NOTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nam' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'YEAR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'thang' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SP_STOCKIN', @level2type=N'COLUMN',@level2name=N'MONTH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NEW, OKE, NG' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_CONDITION', @level2type=N'COLUMN',@level2name=N'NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ton kho thiet bi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_INVENTORY', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'So luong thuc te' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_INVENTORY', @level2type=N'COLUMN',@level2name=N'QUANTITY_REAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma Phong Ban' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_INVENTORY', @level2type=N'COLUMN',@level2name=N'DEPT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma Kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_INVENTORY', @level2type=N'COLUMN',@level2name=N'STOCK_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma thiet bi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_LOCATION', @level2type=N'COLUMN',@level2name=N'SPARE_PART_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vi tri' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_LOCATION', @level2type=N'COLUMN',@level2name=N'LOCATION_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'OK,NG,NEW' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_LOCATION', @level2type=N'COLUMN',@level2name=N'CONDITION_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'trang thai co vi tri, khong vi tri' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_LOCATION', @level2type=N'COLUMN',@level2name=N'IS_WAITE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'So luong san pham tren vi tri' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_LOCATION', @level2type=N'COLUMN',@level2name=N'QUANTITY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPARE_CODE-LOCATION_CODE-[NG]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_LOCATION', @level2type=N'COLUMN',@level2name=N'BARCODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma thiet bi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_PRICE', @level2type=N'COLUMN',@level2name=N'SPARE_PART_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma phieu nhap kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_PRICE', @level2type=N'COLUMN',@level2name=N'STOCK_IN_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'don vi nho nhat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_UNIT', @level2type=N'COLUMN',@level2name=N'UNIT_CODE_MIN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ti le : 1 pac = 6 ea' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPAREPART_UNIT', @level2type=N'COLUMN',@level2name=N'RATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'xuat kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_STOCK_OUT', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ma phieu xuat kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_STOCK_OUT', @level2type=N'COLUMN',@level2name=N'STOCK_OUT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ma thiet bi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_STOCK_OUT', @level2type=N'COLUMN',@level2name=N'SPARE_PART_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nguyen nhan xuat kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_STOCK_OUT', @level2type=N'COLUMN',@level2name=N'CAUSE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ngay xuat kho' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_STOCK_OUT', @level2type=N'COLUMN',@level2name=N'DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'OK,NG' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_STOCK_OUT', @level2type=N'COLUMN',@level2name=N'QUANTITY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Thoi gian tra lai hang neu la xuat tra lai' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_STOCK_OUT', @level2type=N'COLUMN',@level2name=N'RETURN_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'01-01_5_OK,01-02_5_NG' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_STOCK_OUT', @level2type=N'COLUMN',@level2name=N'LOCATION'
GO
