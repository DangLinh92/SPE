﻿CREATE TABLE [dbo].[EWIP_FILE_TEMP] (
  [ID] [int] IDENTITY,
  [Name] [nvarchar](200) NOT NULL,
  [ContenType] [nvarchar](300) NOT NULL,
  [Data] [varbinary](max) NOT NULL,
  CONSTRAINT [PK_EWIP_FILE_TEMP] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO