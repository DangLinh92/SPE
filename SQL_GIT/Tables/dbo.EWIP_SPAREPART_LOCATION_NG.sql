CREATE TABLE [dbo].[EWIP_SPAREPART_LOCATION_NG]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LOCATION_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONDITION_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IS_WAITE] [bit] NULL CONSTRAINT [DF_EWIP_SPAREPART_LOCATION_IS_WAITE_NG] DEFAULT ((0)),
[QUANTITY] [float] NULL,
[DEPT_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BARCODE] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UNIT_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPIRED_DATE] [date] NULL,
[TIME_IN] [date] NULL,
[PO_NO] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_SPAREPART_LOCATION_NG] ADD CONSTRAINT [PK_EWIP_SPAREPART_LOCATION_NG] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
