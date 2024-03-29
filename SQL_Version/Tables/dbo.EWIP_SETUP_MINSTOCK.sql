﻿CREATE TABLE [dbo].[EWIP_SETUP_MINSTOCK] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NOT NULL,
  [UNIT_CODE] [varchar](20) NOT NULL,
  [MIN_STOCK] [float] NOT NULL,
  [STOCK_CODE] [varchar](50) NOT NULL,
  [DEPT_CODE] [nvarchar](100) NOT NULL,
  [RATE_ALARM] [float] NULL,
  CONSTRAINT [PK_EWIP_SETUP_MINSTOCK] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO