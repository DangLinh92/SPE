CREATE TABLE [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LOCATION_CODE_FROM] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LOCATION_CODE_TO] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONDITION_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY] [float] NULL,
[DEPT_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UNIT_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPIRED_DATE] [date] NULL,
[TIME_IN] [date] NULL,
[DATE_MOVE] [datetime] NULL,
[USER_MOVE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PO_NO] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION] ADD CONSTRAINT [PK_EWIP_SPAREPART_LOCATION_TRANSACTION] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO