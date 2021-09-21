﻿CREATE TABLE [dbo].[ESYSMSTMEU] (
  [PLANT] [varchar](10) NOT NULL,
  [DEPARTMENT] [varchar](50) NOT NULL,
  [MENUSEQ] [int] NOT NULL,
  [UPRSEQ] [int] NULL,
  [MENUNAME] [nvarchar](50) NOT NULL,
  [FORM] [varchar](30) NULL,
  [IMGIDX] [int] NULL,
  [DISPSEQ] [int] NULL,
  [DISPFLAG] [char](1) NOT NULL CONSTRAINT [DF_ESYSMSTMEU_DISPLAG] DEFAULT ('Y'),
  [USEFLAG] [char](1) NOT NULL CONSTRAINT [DF_ESYSMSTMEU_USEFLAG] DEFAULT ('Y'),
  [FORM_GUBUN] [varchar](10) NULL,
  [MASTER_FLAG] [char](1) NULL,
  [REMARKS] [nvarchar](4000) NULL,
  [IMAGE] [varchar](100) NULL,
  [CREATE_TIME] [varchar](14) NOT NULL,
  [CREATE_USER] [varchar](20) NOT NULL,
  [UPDATE_TIME] [varchar](14) NULL,
  [UPDATE_USER] [varchar](20) NULL,
  CONSTRAINT [PK_ESYSMSTMEU] PRIMARY KEY CLUSTERED ([PLANT], [DEPARTMENT], [MENUSEQ])
)
ON [PRIMARY]
GO