CREATE TYPE [dbo].[GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE] AS TABLE
(
[RECEIPT_ISSUE_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NAME] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY] [float] NULL,
[UNIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRICE_VN] [float] NULL,
[PRICE_US] [float] NULL,
[AMOUNT_VN] [float] NULL,
[AMOUNT_US] [float] NULL,
[CAUSE] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NOTE] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INT_OUT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CREATE_DATE] [date] NULL,
[USER_CREATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USER_SYS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ORDER_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TYPE_IN_OUT_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RETURN_TIME] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LOCATION] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY_NG] [float] NULL,
[EXPRIRED_DATE] [date] NULL,
[IS_INTEGRATED] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
