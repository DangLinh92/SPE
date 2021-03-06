CREATE TABLE [dbo].[EWIP_EQUIPMENT]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[EQUIPMENT_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EQUIPMENT_NAME] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EQUIPMENT_TYPE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EQ_MANUFACTURING_YEAR] [int] NULL,
[EQ_SERIAL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EQ_ORIGIN] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EQ_MODEL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IMAGE] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DETAIL_INFO] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[USER_UPDATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SYS_TIME] [datetime] NULL,
[STATUS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE_IN] [datetime] NULL,
[MANUFACTURER] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_EQUIPMENT] ADD CONSTRAINT [PK_EWIP_EQUIPMENT] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'NAM SAN XUAT', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_EQUIPMENT', 'COLUMN', N'EQ_MANUFACTURING_YEAR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XUAT XU', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_EQUIPMENT', 'COLUMN', N'EQ_ORIGIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Mã tài sản', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_EQUIPMENT', 'COLUMN', N'EQUIPMENT_ID'
GO
