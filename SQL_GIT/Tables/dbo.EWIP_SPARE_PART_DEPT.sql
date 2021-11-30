CREATE TABLE [dbo].[EWIP_SPARE_PART_DEPT]
(
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[COST_CTR] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_SPARE_PART_DEPT] ADD CONSTRAINT [PK_EWIP_SPARE_PART_DEPT] PRIMARY KEY CLUSTERED ([DEPT_CODE], [SPARE_PART_CODE]) ON [PRIMARY]
GO
