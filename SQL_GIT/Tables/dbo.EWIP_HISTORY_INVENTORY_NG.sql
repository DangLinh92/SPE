CREATE TABLE [dbo].[EWIP_HISTORY_INVENTORY_NG]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QUANTITY] [float] NOT NULL,
[UNIT] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[STOCK_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DATE] [date] NULL,
[MONTH] [int] NULL,
[YEAR] [int] NULL,
[IN_OUT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK_IN_OUT_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY_NG] [float] NULL,
[EXPRIRED_DATE] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_HISTORY_INVENTORY_NG] ADD CONSTRAINT [PK_EWIP_HISTORY_INVENTORY_NG] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
