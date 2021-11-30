CREATE TYPE [dbo].[PR_DETAIL_TYPE1] AS TABLE
(
[MRP_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPAREPART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY_NEED_BUY] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UNIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPECTED_PRICE_VN] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRICE_VN] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TOTAL_MONEY_VN] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENDOR_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PR_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_NEED_FINISH] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USER_UPDATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_UPDATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_CREATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPECTED_PRICE_US] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRICE_US] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TOTAL_MONEY_US] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_END_ACTUAL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STT_MRP] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IS_DELETE] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
