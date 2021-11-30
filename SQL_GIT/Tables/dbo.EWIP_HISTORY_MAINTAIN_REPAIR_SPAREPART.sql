CREATE TABLE [dbo].[EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CAUSE_REPAIR] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TIME_REPAIR] [date] NULL,
[TIME_SUCCESS] [date] NULL,
[ACTION] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USER_REPARE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART] ADD CONSTRAINT [PK_EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'cach thuc sua chua', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'ACTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'nguyen nhan sua chua', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'CAUSE_REPAIR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'thoi gian sua chua', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'TIME_REPAIR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'thoi gian hoan thanh', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'TIME_SUCCESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'nguoi sua chua', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_HISTORY_MAINTAIN_REPAIR_SPAREPART', 'COLUMN', N'USER_REPARE'
GO
