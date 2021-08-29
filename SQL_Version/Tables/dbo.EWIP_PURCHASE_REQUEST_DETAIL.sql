﻿CREATE TABLE [dbo].[EWIP_PURCHASE_REQUEST_DETAIL] (
  [ID] [int] IDENTITY,
  [MRP_CODE] [nvarchar](50) NULL,
  [SPAREPART_CODE] [nvarchar](50) NULL,
  [DEPT_CODE] [nvarchar](100) NULL,
  [QUANTITY_NEED_BUY] [float] NULL,
  [UNIT] [nvarchar](50) NULL,
  [EXPECTED_PRICE_VN] [float] NULL,
  [PRICE_VN] [float] NULL,
  [TOTAL_MONEY_VN] [float] NULL,
  [VENDOR_ID] [nvarchar](50) NULL,
  [PR_CODE] [nvarchar](50) NULL,
  [DATE_NEED_FINISH] [date] NULL,
  [USER_UPDATE] [nvarchar](50) NULL,
  [DATE_UPDATE] [date] NULL,
  [DATE_CREATE] [date] NULL,
  [STATUS] [nvarchar](50) NULL,
  [EXPECTED_PRICE_US] [float] NULL,
  [PRICE_US] [float] NULL,
  [TOTAL_MONEY_US] [float] NULL,
  CONSTRAINT [PK_EWIP_PURCHASE_REQUEST_DETAIL] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO