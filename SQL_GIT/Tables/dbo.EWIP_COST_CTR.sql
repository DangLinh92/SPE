CREATE TABLE [dbo].[EWIP_COST_CTR]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[COST_CTR] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SHORT_TEXT] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_COST_CTR] ADD CONSTRAINT [PK_EWIP_COST_CTR] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
