CREATE TABLE [dbo].[EWIP_PURCHASE_REQUEST_DETAIL]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[MRP_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPAREPART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY_NEED_BUY] [float] NULL,
[UNIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPECTED_PRICE_VN] [float] NULL,
[PRICE_VN] [float] NULL,
[TOTAL_MONEY_VN] [float] NULL,
[VENDOR_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PR_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_NEED_FINISH] [date] NULL,
[USER_UPDATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_UPDATE] [date] NULL,
[DATE_CREATE] [date] NULL,
[STATUS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPECTED_PRICE_US] [float] NULL,
[PRICE_US] [float] NULL,
[TOTAL_MONEY_US] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_PURCHASE_REQUEST_DETAIL] ADD CONSTRAINT [PK_EWIP_PURCHASE_REQUEST_DETAIL] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
