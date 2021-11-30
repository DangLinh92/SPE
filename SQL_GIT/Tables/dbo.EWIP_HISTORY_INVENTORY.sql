CREATE TABLE [dbo].[EWIP_HISTORY_INVENTORY]
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
ALTER TABLE [dbo].[EWIP_HISTORY_INVENTORY] ADD CONSTRAINT [PK_EWIP_HISTORY_INVENTORY] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'ngay nhap xuat', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Lich su nhap xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'1: nhap kho 0: xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'IN_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'thang', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'MONTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'don vi nhap kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'UNIT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'nam', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'YEAR'
GO
