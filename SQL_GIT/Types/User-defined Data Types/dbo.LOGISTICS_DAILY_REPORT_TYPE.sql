CREATE TYPE [dbo].[LOGISTICS_DAILY_REPORT_TYPE] AS TABLE
(
[WAY] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LH] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MASTER_B_LMAWB_NO] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HOUSE_BL_HAWB_NO] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VESSEL_FLIGHT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETD] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETA] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETA_WISOL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SHIPPER] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INVOICE] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QUANTITY_PAL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GW_KGS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CW_KGS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEASUREME_NT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LCL_FCL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONT_20] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONT_40] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[POL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[POD] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TERM] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WARE_HOUSE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TIME_DELIVERY] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NO_CD] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DESCRIPTION_OF_GOODS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NOTE] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
