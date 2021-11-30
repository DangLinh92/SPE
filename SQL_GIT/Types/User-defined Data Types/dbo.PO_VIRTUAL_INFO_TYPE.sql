CREATE TYPE [dbo].[PO_VIRTUAL_INFO_TYPE] AS TABLE
(
[TITLE] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPAREPART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NAME_VI] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UNIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY_NEED_BUY] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENDOR] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRICE_VN] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRICE_US] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
