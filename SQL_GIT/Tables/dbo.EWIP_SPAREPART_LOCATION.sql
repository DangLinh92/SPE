CREATE TABLE [dbo].[EWIP_SPAREPART_LOCATION]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LOCATION_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONDITION_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IS_WAITE] [bit] NULL CONSTRAINT [DF_EWIP_SPAREPART_LOCATION_IS_WAITE] DEFAULT ((0)),
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
ALTER TABLE [dbo].[EWIP_SPAREPART_LOCATION] ADD CONSTRAINT [PK_EWIP_SPAREPART_LOCATION] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'BARCODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'OK,NG,NEW', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'CONDITION_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'trang thai co vi tri, khong vi tri', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'IS_WAITE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Vi tri', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'LOCATION_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'So luong san pham tren vi tri', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'QUANTITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Ma thiet bi', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPAREPART_LOCATION', 'COLUMN', N'SPARE_PART_CODE'
GO
