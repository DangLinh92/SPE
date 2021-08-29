CREATE TABLE [dbo].[EWIP_INVENTORY_BY_TIME] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NULL,
  [QUANTITY] [float] NULL,
  [UNIT] [varchar](20) NULL,
  [DEPT_CODE] [nvarchar](100) NULL,
  [STOCK_CODE] [varchar](50) NULL,
  [DATE] [date] NULL,
  [MONTH] [int] NULL,
  [YEAR] [int] NULL,
  [QUANTITY_REAL] [float] NULL,
  [PRICE_VN] [float] NULL,
  [PRICE_US] [float] NULL,
  CONSTRAINT [PK_EWIP_INVENTORY_BY_TIME] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO