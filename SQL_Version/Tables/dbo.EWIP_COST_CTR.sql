CREATE TABLE [dbo].[EWIP_COST_CTR] (
  [ID] [int] IDENTITY,
  [COST_CTR] [varchar](50) NOT NULL,
  [SHORT_TEXT] [varchar](50) NULL,
  [DEPT_CODE] [nvarchar](100) NULL,
  CONSTRAINT [PK_EWIP_COST_CTR] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO