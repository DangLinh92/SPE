CREATE TABLE [dbo].[EWIP_BOM]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QUANTITY_IN_UNIT] [float] NULL,
[UNIT] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WORKING_DAY_NUMBER] [float] NULL,
[WORKING_LINE_NUMBER] [float] NULL,
[WORKING_A_LINE] [float] NULL,
[WORKING_A_MONTH] [float] NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[WORKING_A_LINE_PACK] [float] NULL,
[RATE] [float] NULL,
[FROM_TIME] [date] NULL,
[TO_TIME] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_BOM] ADD CONSTRAINT [PK_EWIP_BOM_1] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
