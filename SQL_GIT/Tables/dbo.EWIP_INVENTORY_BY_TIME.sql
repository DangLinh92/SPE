CREATE TABLE [dbo].[EWIP_INVENTORY_BY_TIME]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY] [float] NULL,
[UNIT] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE] [date] NULL,
[MONTH] [int] NULL,
[YEAR] [int] NULL,
[QUANTITY_REAL] [float] NULL,
[PRICE_VN] [float] NULL,
[PRICE_US] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_INVENTORY_BY_TIME] ADD CONSTRAINT [PK_EWIP_INVENTORY_BY_TIME] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO