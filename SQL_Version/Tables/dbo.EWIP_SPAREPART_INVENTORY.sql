CREATE TABLE [dbo].[EWIP_SPAREPART_INVENTORY] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NOT NULL,
  [QUANTITY] [float] NOT NULL,
  [UNIT_IN_CODE] [varchar](20) NOT NULL,
  [QUANTITY_REAL] [float] NULL,
  [DEPT_CODE] [nvarchar](100) NOT NULL,
  [STOCK_CODE] [varchar](50) NOT NULL,
  [CREATE_DATE] [date] NULL,
  [UPDATE_DATE] [date] NULL,
  [USER_UPDATE] [nvarchar](50) NULL,
  CONSTRAINT [PK_EWIP_SPAREPART_INVENTORY] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ton kho thiet bi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_INVENTORY', 'COLUMN', N'ID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'So luong thuc te', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_INVENTORY', 'COLUMN', N'QUANTITY_REAL'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma Phong Ban', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_INVENTORY', 'COLUMN', N'DEPT_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma Kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_INVENTORY', 'COLUMN', N'STOCK_CODE'
GO