CREATE TABLE [dbo].[ESYSMSTFORM]
(
[PLANT] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DEPARTMENT] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FORM] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FORMNAME] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MENUAL_FILE] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ACCESS_TYPE] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USEFLAG] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_ESYSMSTFORM_USEFLAG] DEFAULT ('Y'),
[REMARKS] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CREATE_TIME] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CREATE_USER] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UPDATE_TIME] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UPDATE_USER] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ESYSMSTFORM] ADD CONSTRAINT [PK_ESYSMSTFORM] PRIMARY KEY CLUSTERED ([PLANT], [DEPARTMENT], [FORM]) ON [PRIMARY]
GO
