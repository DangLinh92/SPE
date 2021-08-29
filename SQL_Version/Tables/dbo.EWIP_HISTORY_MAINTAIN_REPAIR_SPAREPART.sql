CREATE TABLE [dbo].[EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NOT NULL,
  [DEPT_CODE] [nvarchar](100) NOT NULL,
  [CAUSE_REPAIR] [nvarchar](500) NULL,
  [TIME_REPAIR] [date] NULL,
  [TIME_SUCCESS] [date] NULL,
  [ACTION] [nvarchar](500) NULL,
  [USER_REPARE] [nvarchar](100) NULL,
  CONSTRAINT [PK_EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'nguyen nhan sua chua', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'CAUSE_REPAIR'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'thoi gian sua chua', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'TIME_REPAIR'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'thoi gian hoan thanh', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'TIME_SUCCESS'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'cach thuc sua chua', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'ACTION'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'nguoi sua chua', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'USER_REPARE'
GO