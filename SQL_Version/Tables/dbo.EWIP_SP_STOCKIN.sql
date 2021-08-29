CREATE TABLE [dbo].[EWIP_SP_STOCKIN] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NOT NULL,
  [STOCK_IN_CODE] [nvarchar](50) NOT NULL,
  [QUANTITY] [float] NOT NULL,
  [PRICE_VN] [float] NOT NULL,
  [UNIT_CODE] [varchar](20) NOT NULL,
  [VENDER_ID] [varchar](50) NULL,
  [STOCK_CODE] [varchar](50) NULL,
  [CAUSE] [nvarchar](500) NULL,
  [DEPT_CODE] [nvarchar](100) NOT NULL,
  [DATE_IN] [date] NOT NULL,
  [USER_ID] [varchar](20) NULL,
  [AMOUNT_US] [float] NULL,
  [AMOUNT_VN] [float] NULL,
  [NOTE] [nvarchar](500) NULL,
  [YEAR] [int] NULL,
  [MONTH] [int] NULL,
  [PRICE_US] [float] NULL,
  [TYPE_IN_CODE] [nvarchar](50) NULL,
  [QUANTITY_NG] [float] NULL,
  [EXPRIRED_DATE] [date] NULL,
  [IS_INTEGRATED] [bit] NULL,
  CONSTRAINT [PK_EWIP_SP_STOCKIN] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma thiet bi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'SPARE_PART_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma phieu nhap Kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'STOCK_IN_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Don gia/dvi san pham', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'PRICE_VN'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Don vi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'UNIT_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma nha cung cap', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'VENDER_ID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma Kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'STOCK_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'nguyen nhan nhap kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'CAUSE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma phong ban', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'DEPT_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ngay nhap kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'DATE_IN'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Tien theo so luong, don vi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'AMOUNT_US'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Tien theo so luong, don vi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'AMOUNT_VN'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ghi chu', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'NOTE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'nam', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'YEAR'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'thang', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SP_STOCKIN', 'COLUMN', N'MONTH'
GO