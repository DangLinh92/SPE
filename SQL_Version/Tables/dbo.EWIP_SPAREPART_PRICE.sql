CREATE TABLE [dbo].[EWIP_SPAREPART_PRICE] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NOT NULL,
  [STOCK_IN_CODE] [varchar](50) NULL,
  [PRICE_VN] [float] NULL,
  [PRICE_US] [float] NULL,
  [UNIT_CODE] [varchar](20) NULL,
  [DEPT_CODE] [nvarchar](50) NULL,
  [DATE] [date] NULL,
  CONSTRAINT [PK_EWIP_SPAREPART_PRICE] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma thiet bi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_PRICE', 'COLUMN', N'SPARE_PART_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma phieu nhap kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_PRICE', 'COLUMN', N'STOCK_IN_CODE'
GO