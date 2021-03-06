CREATE TYPE [dbo].[GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE] AS TABLE (
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
  [LOCATION] [nvarchar](max) NULL,
  [QUANTITY_NG] [float] NULL,
  [EXPRIRED_DATE] [date] NULL,
  [IS_INTEGRATED] [nvarchar](20) NULL
)
GO