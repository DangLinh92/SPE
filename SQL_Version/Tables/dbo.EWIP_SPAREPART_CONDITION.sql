CREATE TABLE [dbo].[EWIP_SPAREPART_CONDITION] (
  [ID] [int] IDENTITY,
  [CODE] [varchar](50) NOT NULL,
  [NAME] [nvarchar](50) NULL,
  CONSTRAINT [PK_EWIP_SPAREPART_CONDITION] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'NEW, OKE, NG', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_CONDITION', 'COLUMN', N'NAME'
GO