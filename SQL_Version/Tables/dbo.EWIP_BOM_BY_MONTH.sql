﻿CREATE TABLE [dbo].[EWIP_BOM_BY_MONTH] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NULL,
  [WORKING_A_MONTH] [float] NULL,
  [UNIT] [varchar](20) NULL,
  [DEPT_CODE] [nvarchar](100) NULL,
  [RATE] [float] NULL,
  [MONTH] [int] NULL,
  [YEART] [int] NULL,
  [WORKING_A_LINE_PACK] [float] NULL,
  [WORKING_DAY_NUMBER] [float] NULL,
  [WORKING_LINE_NUMBER] [float] NULL,
  CONSTRAINT [PK_EWIP_BOM_BY_MONTH] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO