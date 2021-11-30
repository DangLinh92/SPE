CREATE TYPE [dbo].[EWIP_MRP_TYPE] AS TABLE
(
[ID] [int] NULL,
[SPAREPART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY_NEED_BUY] [float] NULL,
[UNIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_NEED_BUY] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_NEED_FINISH] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_END_ACTUAL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USER_UPDATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_UPDATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OFF_NOTI] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_NEED_REQUIRED] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MRP_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
