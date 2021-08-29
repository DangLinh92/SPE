CREATE TABLE [dbo].[EWIP_HISTORY_INVENTORY] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NOT NULL,
  [QUANTITY] [float] NOT NULL,
  [UNIT] [varchar](20) NOT NULL,
  [DEPT_CODE] [nvarchar](100) NOT NULL,
  [STOCK_CODE] [varchar](50) NOT NULL,
  [DATE] [date] NULL,
  [MONTH] [int] NULL,
  [YEAR] [int] NULL,
  [IN_OUT] [nvarchar](50) NULL,
  [STOCK_IN_OUT_CODE] [nvarchar](50) NULL,
  [STATUS] [nvarchar](50) NULL,
  [QUANTITY_NG] [float] NULL,
  [EXPRIRED_DATE] [date] NULL,
  CONSTRAINT [PK_EWIP_HISTORY_INVENTORY] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Lich su nhap xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'ID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'don vi nhap kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'UNIT'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'ngay nhap xuat', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'DATE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'thang', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'MONTH'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'nam', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'YEAR'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'1: nhap kho 0: xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_INVENTORY', 'COLUMN', N'IN_OUT'
GO