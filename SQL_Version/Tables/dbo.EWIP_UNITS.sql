CREATE TABLE [dbo].[EWIP_UNITS] (
  [ID] [int] IDENTITY,
  [CODE] [varchar](20) NOT NULL,
  [NAME] [nvarchar](50) NULL,
  CONSTRAINT [PK_EWIP_UNITS] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO