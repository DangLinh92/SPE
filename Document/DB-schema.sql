USE [master]
GO
/****** Object:  Database [SPARE_PART_UPDATE]    Script Date: 7/17/2021 2:47:28 PM ******/
CREATE DATABASE [SPARE_PART_UPDATE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SPARE_PART_UPDATE', FILENAME = N'D:\DATA_SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\SPARE_PART_UPDATE.mdf' , SIZE = 466944KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SPARE_PART_UPDATE_log', FILENAME = N'D:\DATA_SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\SPARE_PART_UPDATE_log.ldf' , SIZE = 991232KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SPARE_PART_UPDATE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET ARITHABORT OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET RECOVERY FULL 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET  MULTI_USER 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET QUERY_STORE = OFF
GO
USE [SPARE_PART_UPDATE]
GO
/****** Object:  UserDefinedTableType [dbo].[GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE2]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[LOCATION_TYPE]    Script Date: 7/17/2021 2:47:28 PM ******/
CREATE TYPE [dbo].[LOCATION_TYPE] AS TABLE(
	[CODE] [nvarchar](50) NULL,
	[STOCK_CODE] [varchar](50) NULL,
	[DEPT_CODE] [nvarchar](100) NULL,
	[RACK_CODE] [nchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SPAREPART_LOCATION_TYPE]    Script Date: 7/17/2021 2:47:28 PM ******/
CREATE TYPE [dbo].[SPAREPART_LOCATION_TYPE] AS TABLE(
	[SPARE_PART_CODE] [nvarchar](50) NULL,
	[LOCATION_CODE] [nvarchar](50) NULL,
	[CONDITION_CODE] [nvarchar](50) NULL,
	[IS_WAITE] [nvarchar](10) NULL,
	[QUANTITY] [nvarchar](50) NULL,
	[UNIT_ID] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SPAREPART_LOCATION_TYPE1]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[TableType]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[ALL_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CHAR_TO_DATE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CHAR_TO_MONTHYEAR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CONVERT_INOUT_STR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CONVERT_MONTH_STR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CONVERT_UNIT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CREATE_BARCODE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[DELIVERY_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[FUN_CURR_TIME]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[FUN_GET_PLANT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[FUN_TIMESTAMP]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[GETBARCODE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[INVENTORY_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[RECEIVE_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[STOCK_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[SUM_ALL_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[SUM_DELIVERY_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[SUM_INVENTORY_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[SUM_RECEIVE_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[SUM_STOCK_ARR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[ESYSLOGFORM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[ESYSLOGLGN]    Script Date: 7/17/2021 2:47:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESYSLOGLGN](
	[PLANT] [varchar](10) NOT NULL,
	[DEPARTMENT] [varchar](50) NOT NULL,
	[USER_ID] [varchar](30) NOT NULL,
	[HIST_SEQ] [int] NOT NULL,
	[ACCESS_TIME] [varchar](14) NOT NULL,
	[ACCESS_IP] [varchar](20) NULL,
	[ACCESS_PC] [varchar](100) NULL,
 CONSTRAINT [PK_ESYSLOGLGN] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[DEPARTMENT] ASC,
	[USER_ID] ASC,
	[HIST_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESYSMSTDEPT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[ESYSMSTFORM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[ESYSMSTGLA]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[ESYSMSTMEU]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[ESYSMSTMRO]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[ESYSMSTROL]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[ESYSMSTURO]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[ESYSMSTUSR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_BOM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_COST_CTR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_EXCHANGE_RATE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_FILE_TEMP]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_GL_ACCOUNT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_HISTORY_INVENTORY]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_INVENTORY_BY_TIME]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_LABEL]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_LOCATIONS]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_ORDER]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SETUP_MINSTOCK]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SP_STOCKIN]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SPARE_PART]    Script Date: 7/17/2021 2:47:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EWIP_SPARE_PART](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODE] [nvarchar](50) NOT NULL,
	[NAME_VI] [nvarchar](200) NOT NULL,
	[NAME_KR] [nvarchar](200) NULL,
	[UNIT_ID] [varchar](20) NOT NULL,
	[GL_ACCOUNT] [varchar](50) NOT NULL,
	[VENDER_ID] [varchar](50) NOT NULL,
	[IMAGE] [nvarchar](max) NULL,
	[DESCRIPTION] [nvarchar](1000) NULL,
	[TYPE] [varchar](50) NULL,
	[MATERIAL] [nvarchar](50) NULL,
	[USES] [nvarchar](200) NULL,
	[EQUIPMENT_USED] [nvarchar](200) NULL,
	[SPECIFICATIONS] [nvarchar](500) NULL,
	[SIZE] [nvarchar](50) NULL,
	[WEIGHT] [nvarchar](50) NULL,
	[CREATED_AT] [date] NULL,
	[UPDATED_AT] [date] NULL,
	[CREATE_BY] [nvarchar](50) NULL,
	[UPDATE_BY] [nvarchar](50) NULL,
	[MIN_ORDER] [float] NULL,
	[SP_DEPT_CODE] [nvarchar](100) NULL,
 CONSTRAINT [PK_EWIP_SPARE_PART] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EWIP_SPARE_PART_DEPT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SPAREPART_CONDITION]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SPAREPART_DOCUMENT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SPAREPART_INVENTORY]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SPAREPART_LOCATION]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SPAREPART_PRICE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SPAREPART_TYPE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_SPAREPART_UNIT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_STOCK]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_STOCK_OUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_TYPE_IN_OUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_UNITS]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  Table [dbo].[EWIP_VENDER]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_BOM@INIT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_BOM_SPAREPART@DELETE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_BOM_SPAREPART@GET]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_BOM_SPAREPART@PUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_CACULATOR_INVENTORY@CALL]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_FILE_TEMP@GET_FILE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_FILE_TEMP@INSERT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@DELETE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@INIT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@PUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@DELETE_QUANTITY_REAL]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@GET_QUANTITY_REAL]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@PUT_QUANTITY_REAL]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_DELIVERY_RECEIVING@GET]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_INVENTORY_DELIVERY_RECEIVING@GET_BY_TIME]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_KHO@GET]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LABEL@GET_TEMP]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@DELETE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@GET]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@GET_SINGLE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@INSERT_BATCH]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION@INSERT_SINGLE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_INIT@GET]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@CACULAR_REMAIN_QUANTITY]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@DELETE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@GET_LOCATION_BY_SPAREPART]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@GET_SINGLE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_ BATCH]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_SPAREPART]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_SPAREPART_EXPIRED]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@MOVE_SPARE_PART_TO_LOCATION]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@DELETE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@GET]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@GET_MAX_AUTO_CODE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@INIT_PUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@ONLY_SHOW_SPAREPART]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@PUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@SEARCH]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@SHOW]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP@UPDATE_CODE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@CHECK_INVENTORY_ALARM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@CREATE_BALANCE_WAREHOUSE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@DELETE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@GET]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@GET_BY_SPARE_CODE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@PUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@REPORT_BY_SPAREPART]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_INVENTORY@REPORT_BY_SPAREPART_IN_OUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_MIN_STOCK@PUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_TYPE@GET]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_SP_UNIT@PUT]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_UNIT@GET]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_BUSINESS_UNIT_SPAREPART@GET_UNIT_BY_SPAREPART]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_COMM@CHG_PWD]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_COMM@GET_GLSR]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_COMM@GET_LANGAGUE]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_COMM@GET_LOGIN]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_COMM@GET_MENU]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_COMM@PUT_LOGIN]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT001@GET_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT001@INT_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT002@GET_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT002@INT_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_LOGDAT002@POP_GET_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM001@GET_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM001@INT_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM001@PUT_ITEM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM002@GET_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM002@INT_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM002@PUT_ITEM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM004@GET_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM004@INT_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM004@PUT_ITEM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM005@GET_DETAIL]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM005@GET_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM005@INT_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM005@PUT_ITEM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM006@GET_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM006@INT_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM006@PUT_ITEM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM008@GET_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM008@INT_LIST]    Script Date: 7/17/2021 2:47:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PKG_SYSTEM008@PUT_ITEM]    Script Date: 7/17/2021 2:47:28 PM ******/
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spare part or Consumable part' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPARE_PART', @level2type=N'COLUMN',@level2name=N'TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Chất liệu' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPARE_PART', @level2type=N'COLUMN',@level2name=N'MATERIAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cong dung' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPARE_PART', @level2type=N'COLUMN',@level2name=N'USES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'thiet bi su dung' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPARE_PART', @level2type=N'COLUMN',@level2name=N'EQUIPMENT_USED'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Thong so ky thuat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPARE_PART', @level2type=N'COLUMN',@level2name=N'SPECIFICATIONS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Kich thuoc' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPARE_PART', @level2type=N'COLUMN',@level2name=N'SIZE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Can nang' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EWIP_SPARE_PART', @level2type=N'COLUMN',@level2name=N'WEIGHT'
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
USE [master]
GO
ALTER DATABASE [SPARE_PART_UPDATE] SET  READ_WRITE 
GO
