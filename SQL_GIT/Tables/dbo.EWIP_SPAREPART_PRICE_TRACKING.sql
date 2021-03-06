CREATE TABLE [dbo].[EWIP_SPAREPART_PRICE_TRACKING]
(
[ID] [bigint] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[STOCK_IN_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRICE_VN] [float] NULL,
[PRICE_US] [float] NULL,
[UNIT_CODE] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE] [date] NULL,
[INPUT_DEFAULT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_SPAREPART_PRICE_TRACKING] ADD CONSTRAINT [PK_EWIP_SPAREPART_PRICE_TRACKING] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
