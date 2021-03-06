CREATE TABLE [dbo].[EWIP_BOM_BY_MONTH]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WORKING_A_MONTH] [float] NULL,
[UNIT] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RATE] [float] NULL,
[MONTH] [int] NULL,
[YEART] [int] NULL,
[WORKING_A_LINE_PACK] [float] NULL,
[WORKING_DAY_NUMBER] [float] NULL,
[WORKING_LINE_NUMBER] [float] NULL,
[MIN_STOCK_PACK] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_BOM_BY_MONTH] ADD CONSTRAINT [PK_EWIP_BOM_BY_MONTH] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
