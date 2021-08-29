CREATE TABLE [dbo].[EWIP_LOCATIONS] (
  [ID] [int] IDENTITY,
  [CODE] [nvarchar](50) NOT NULL,
  [STOCK_CODE] [varchar](50) NULL,
  [DEPT_CODE] [nvarchar](100) NOT NULL,
  [UPDATE_DATE] [date] NULL,
  CONSTRAINT [PK_EWIP_LOCATIONS] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'vị trí :01-01', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_LOCATIONS', 'COLUMN', N'CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma Kho', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_LOCATIONS', 'COLUMN', N'STOCK_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma Phong ban', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_LOCATIONS', 'COLUMN', N'DEPT_CODE'
GO