CREATE TABLE [dbo].[EWIP_GOC_PLAN_SMT]
(
[WEEK] [int] NULL,
[UPDATE_DATE] [date] NULL,
[MONTH] [int] NULL,
[MODEL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MODEL_NAME] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SALES_PLAN] [float] NULL,
[SALES_PLAN_POINT] [float] NULL,
[WHC_PLAN] [float] NULL,
[WHC_PLAN_POINT] [float] NULL,
[STOCK] [float] NULL,
[STOCK_POINT] [float] NULL,
[UPDATE_TIME_SYS] [datetime] NULL,
[USER_UPDATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[YEAR_PLAN] [int] NULL
) ON [PRIMARY]
GO
