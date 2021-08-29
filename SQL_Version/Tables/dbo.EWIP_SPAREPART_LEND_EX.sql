﻿CREATE TABLE [dbo].[EWIP_SPAREPART_LEND_EX] (
  [ID] [int] IDENTITY,
  [LEND_CODE] [nvarchar](50) NULL,
  [RECEIPT_ISSUE_CODE] [nvarchar](50) NULL,
  [QUANTITY] [float] NULL,
  [UNIT] [nvarchar](50) NULL,
  CONSTRAINT [PK_EWIP_SPAREPART_LEND_EX] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO