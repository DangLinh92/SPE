CREATE TABLE [dbo].[EWIP_STOCK_OUT] (
  [ID] [int] IDENTITY,
  [STOCK_OUT_CODE] [nvarchar](50) NOT NULL,
  [SPARE_PART_CODE] [nvarchar](50) NOT NULL,
  [CAUSE] [nvarchar](100) NULL,
  [STOCK_CODE] [varchar](50) NULL,
  [DEPT_CODE] [nvarchar](100) NULL,
  [DATE] [date] NULL,
  [YEAR] [int] NULL,
  [MONTH] [int] NULL,
  [USER_ID] [varchar](20) NULL,
  [QUANTITY] [float] NULL,
  [TYPE_OUT_CODE] [nvarchar](50) NULL,
  [RETURN_TIME] [date] NULL,
  [UNIT_ID] [varchar](20) NULL,
  [LOCATION] [nvarchar](max) NULL,
  CONSTRAINT [PK_EWIP_STOCK_OUT] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'ID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma phieu xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'STOCK_OUT_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'ma thiet bi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'SPARE_PART_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'nguyen nhan xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'CAUSE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'ngay xuat kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'DATE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'OK,NG', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'QUANTITY'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Thoi gian tra lai hang neu la xuat tra lai', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'RETURN_TIME'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'01-01_5_OK,01-02_5_NG', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_STOCK_OUT', 'COLUMN', N'LOCATION'
GO