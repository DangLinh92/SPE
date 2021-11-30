CREATE TYPE [dbo].[GOC_PLAN_SMT] AS TABLE
(
[WEEK] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UPDATE_DATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MONTH] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MODEL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MODEL_NAME] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SALES_PLAN] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SALES_PLAN_POINT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WHC_PLAN] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WHC_PLAN_POINT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK_POINT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[YEAR_PLAN] [int] NULL
)
GO
