CREATE TYPE [dbo].[TableType] AS TABLE
(
[MONTH] [int] NULL,
[YEAR] [int] NULL,
[CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NAME_VI] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DESCRIPTION] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRICE_VN] [float] NULL,
[PRICE_US] [float] NULL,
[VENDER_NAME] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UNIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPARE_PART_TYPE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MIN_STOCK] [float] NULL,
[QUANTITY_MONTH] [float] NULL,
[IN_OUT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY] [float] NULL,
[QUANTITY_REAL] [float] NULL,
[STOCK_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
