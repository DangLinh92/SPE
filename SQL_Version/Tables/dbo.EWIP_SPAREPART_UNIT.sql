CREATE TABLE [dbo].[EWIP_SPAREPART_UNIT] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NULL,
  [UNIT_CODE] [varchar](20) NULL,
  [UNIT_CODE_MIN] [varchar](20) NULL,
  [RATE] [float] NULL,
  [DEPT_CODE] [nvarchar](50) NULL,
  CONSTRAINT [PK_EWIP_SPAREPART_UNIT] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'don vi nho nhat', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_UNIT', 'COLUMN', N'UNIT_CODE_MIN'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'ti le : 1 pac = 6 ea', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_UNIT', 'COLUMN', N'RATE'
GO