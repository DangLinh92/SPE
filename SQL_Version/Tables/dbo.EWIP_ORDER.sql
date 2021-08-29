CREATE TABLE [dbo].[EWIP_ORDER] (
  [ID] [int] IDENTITY,
  [PO_ID] [nvarchar](50) NULL,
  [DATE_ORERED] [datetime] NULL,
  [DATE_CREATE] [datetime] NULL,
  [STATUS] [nvarchar](50) NULL,
  [USER_ID] [varchar](20) NULL,
  [UPDATED_DATE] [datetime] NULL,
  [TITLE] [nvarchar](200) NULL,
  [DATE_ACTUAL_END] [date] NULL,
  [DATE_NEED_FINISH] [date] NULL,
  [PO_ID_TEMP] [nvarchar](50) NULL,
  CONSTRAINT [PK_EWIP_ORDER] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'NULL : CHUA ORDER ,1: ORDERED 0: HUY ORDER', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER', 'COLUMN', N'STATUS'
GO