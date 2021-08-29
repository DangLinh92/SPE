CREATE TABLE [dbo].[EWIP_SPAREPART_LOCATION] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NOT NULL,
  [LOCATION_CODE] [nvarchar](50) NULL,
  [CONDITION_CODE] [varchar](50) NULL,
  [IS_WAITE] [bit] NULL CONSTRAINT [DF_EWIP_SPAREPART_LOCATION_IS_WAITE] DEFAULT (0),
  [QUANTITY] [float] NULL,
  [DEPT_CODE] [varchar](50) NULL,
  [STOCK_CODE] [varchar](50) NULL,
  [BARCODE] [nvarchar](200) NULL,
  [UNIT_ID] [varchar](20) NULL,
  [EXPIRED_DATE] [date] NULL,
  [TIME_IN] [date] NULL,
  CONSTRAINT [PK_EWIP_SPAREPART_LOCATION] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma thiet bi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'SPARE_PART_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Vi tri', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'LOCATION_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'OK,NG,NEW', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'CONDITION_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'trang thai co vi tri, khong vi tri', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'IS_WAITE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'So luong san pham tren vi tri', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'QUANTITY'
GO

DECLARE @value SQL_VARIANT = CAST(N'' AS nvarchar(1))
EXEC sys.sp_addextendedproperty N'MS_Description', @value, 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'BARCODE'
GO