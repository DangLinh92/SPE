CREATE TABLE [dbo].[EWIP_STOCK_OUT]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[STOCK_OUT_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CAUSE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE] [date] NULL,
[YEAR] [int] NULL,
[MONTH] [int] NULL,
[USER_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY] [float] NULL,
[TYPE_OUT_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RETURN_TIME] [date] NULL,
[UNIT_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LOCATION] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_STOCK_OUT] ADD CONSTRAINT [PK_EWIP_STOCK_OUT] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'nguyen nhan xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'CAUSE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ngay xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'01-01_5_OK,01-02_5_NG', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'LOCATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'OK,NG', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'QUANTITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Thoi gian tra lai hang neu la xuat tra lai', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'RETURN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ma thiet bi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'SPARE_PART_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ma phieu xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'STOCK_OUT_CODE'
GO
