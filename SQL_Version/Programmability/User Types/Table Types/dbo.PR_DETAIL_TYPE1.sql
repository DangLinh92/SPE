CREATE TYPE [dbo].[PR_DETAIL_TYPE1] AS TABLE (
  [MRP_CODE] [nvarchar](50) NULL,
  [SPAREPART_CODE] [nvarchar](50) NULL,
  [DEPT_CODE] [nvarchar](100) NULL,
  [QUANTITY_NEED_BUY] [nvarchar](50) NULL,
  [UNIT] [nvarchar](50) NULL,
  [EXPECTED_PRICE_VN] [nvarchar](50) NULL,
  [PRICE_VN] [nvarchar](50) NULL,
  [TOTAL_MONEY_VN] [nvarchar](50) NULL,
  [VENDOR_ID] [nvarchar](50) NULL,
  [PR_CODE] [nvarchar](50) NULL,
  [DATE_NEED_FINISH] [nvarchar](50) NULL,
  [USER_UPDATE] [nvarchar](50) NULL,
  [DATE_UPDATE] [nvarchar](50) NULL,
  [DATE_CREATE] [nvarchar](50) NULL,
  [STATUS] [nvarchar](50) NULL,
  [EXPECTED_PRICE_US] [nvarchar](50) NULL,
  [PRICE_US] [nvarchar](50) NULL,
  [TOTAL_MONEY_US] [nvarchar](50) NULL,
  [DATE_END_ACTUAL] [nvarchar](50) NULL,
  [STT_MRP] [nvarchar](50) NULL,
  [IS_DELETE] [nvarchar](10) NULL
)
GO