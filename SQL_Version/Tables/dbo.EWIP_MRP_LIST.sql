﻿CREATE TABLE [dbo].[EWIP_MRP_LIST] (
  [ID] [int] IDENTITY,
  [MRP_CODE] [nvarchar](50) NOT NULL,
  [DATE_CREATE] [date] NULL,
  [STATUS] [nvarchar](50) NULL,
  [DEPT_CODE] [nvarchar](100) NOT NULL,
  [DATE_END_ACTUAL] [date] NULL,
  [DATE_NEED_FINISH] [date] NULL,
  [USER_CREATE] [nvarchar](50) NULL,
  [USER_UPDATE] [nvarchar](50) NULL,
  [DATE_UPDATE] [date] NULL,
  [TITLE] [nvarchar](500) NULL,
  CONSTRAINT [PK_EWIP_MRP_LIST] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO