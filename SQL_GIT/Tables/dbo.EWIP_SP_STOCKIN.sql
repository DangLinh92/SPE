CREATE TABLE [dbo].[EWIP_SP_STOCKIN]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[STOCK_IN_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QUANTITY] [float] NOT NULL,
[PRICE_VN] [float] NOT NULL,
[UNIT_CODE] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[VENDER_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CAUSE] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DATE_IN] [date] NOT NULL,
[USER_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AMOUNT_US] [float] NULL,
[AMOUNT_VN] [float] NULL,
[NOTE] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[YEAR] [int] NULL,
[MONTH] [int] NULL,
[PRICE_US] [float] NULL,
[TYPE_IN_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY_NG] [float] NULL,
[EXPRIRED_DATE] [date] NULL,
[IS_INTEGRATED] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_SP_STOCKIN] ADD CONSTRAINT [PK_EWIP_SP_STOCKIN] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Tien theo so luong, don vi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'AMOUNT_US'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Tien theo so luong, don vi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'AMOUNT_VN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'nguyen nhan nhap kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'CAUSE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ngay nhap kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'DATE_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ma phong ban', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'DEPT_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'thang', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'MONTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ghi chu', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'NOTE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Don gia/dvi san pham', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'PRICE_VN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ma thiet bi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'SPARE_PART_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ma Kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'STOCK_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ma phieu nhap Kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'STOCK_IN_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Don vi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'UNIT_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ma nha cung cap', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'VENDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'nam', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'YEAR'
GO
