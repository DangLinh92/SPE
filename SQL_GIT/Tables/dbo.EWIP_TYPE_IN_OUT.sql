CREATE TABLE [dbo].[EWIP_TYPE_IN_OUT]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NAME] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_TYPE_IN_OUT] ADD CONSTRAINT [PK_EWIP_TYPE_IN_OUT] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
