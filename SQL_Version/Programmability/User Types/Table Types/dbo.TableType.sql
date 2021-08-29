CREATE TYPE [dbo].[TableType] AS TABLE (
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