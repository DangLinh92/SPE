CREATE TABLE [dbo].[EWIP_ORDER_PR] (
  [ID] [int] IDENTITY,
  [PO_ID] [nvarchar](50) NULL,
  [PR_CODE] [nvarchar](50) NULL,
  [STATUS] [nvarchar](50) NULL,
  [DATE_NEED_FINISH] [date] NULL,
  [DATE_END_ACTUAL] [date] NULL,
  [DATE_CREATE] [date] NULL,
  [DATE_UPDATE] [date] NULL,
  [USER_CREATE] [nvarchar](50) NULL,
  [USER_UPDATE] [nvarchar](50) NULL,
  [DEPT_CODE] [nvarchar](50) NULL,
  [PO_ID_TEMP] [nvarchar](50) NULL,
  CONSTRAINT [PK_EWIP_ORDER_PR] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO