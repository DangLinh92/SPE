CREATE TYPE [dbo].[EWIP_ODER_PR] AS TABLE
(
[ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PR_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MRP_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TOTAL_VALUE] [float] NULL,
[TOTAL_VALUE_US] [float] NULL,
[DATE_CREATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_NEED_FINISH] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PR_STATUS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
