CREATE TABLE [dbo].[EWIP_SPAREPART_LEND_EX]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[LEND_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RECEIPT_ISSUE_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY] [float] NULL,
[UNIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_SPAREPART_LEND_EX] ADD CONSTRAINT [PK_EWIP_SPAREPART_LEND_EX] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
