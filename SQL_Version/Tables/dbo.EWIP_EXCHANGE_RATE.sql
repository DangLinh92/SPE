﻿CREATE TABLE [dbo].[EWIP_EXCHANGE_RATE] (
  [ID] [int] IDENTITY,
  [VALID_TIME] [date] NOT NULL,
  [FROM] [varchar](5) NOT NULL,
  [TO] [varchar](5) NOT NULL,
  [RATE] [float] NOT NULL,
  [UPDATED_AT] [date] NULL,
  [CREATED_AT] [date] NULL,
  CONSTRAINT [PK_EWIP_EXCHANGE_RATE] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO