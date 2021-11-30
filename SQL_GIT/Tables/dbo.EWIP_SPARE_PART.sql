CREATE TABLE [dbo].[EWIP_SPARE_PART]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NAME_VI] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NAME_KR] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UNIT_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GL_ACCOUNT] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[VENDER_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IMAGE] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DESCRIPTION] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TYPE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MATERIAL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USES] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EQUIPMENT_USED] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPECIFICATIONS] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SIZE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WEIGHT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CREATED_AT] [date] NULL,
[UPDATED_AT] [date] NULL,
[CREATE_BY] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UPDATE_BY] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MIN_ORDER] [float] NULL,
[SP_DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LEAD_TIME] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_SPARE_PART] ADD CONSTRAINT [PK_EWIP_SPARE_PART] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'thiet bi su dung', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'EQUIPMENT_USED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Chất liệu', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'MATERIAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Kich thuoc', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'SIZE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Thong so ky thuat', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'SPECIFICATIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Spare part or Consumable part', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cong dung', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'USES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Can nang', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'WEIGHT'
GO
