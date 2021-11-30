CREATE TABLE [dbo].[EWIP_LOCATIONS]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[STOCK_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UPDATE_DATE] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_LOCATIONS] ADD CONSTRAINT [PK_EWIP_LOCATIONS] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'vị trí :01-01', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_LOCATIONS', 'COLUMN', N'CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ma Phong ban', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_LOCATIONS', 'COLUMN', N'DEPT_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ma Kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_LOCATIONS', 'COLUMN', N'STOCK_CODE'
GO
