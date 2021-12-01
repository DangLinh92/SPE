CREATE TYPE [dbo].[PO_DETAIL_TYPE] AS TABLE
(
[PO_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PO_ID_TEMP] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PO_CREATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LIFNR] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PR_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KUNNR] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BKGRP] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PSTYP] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TXZ01_DESCRIPTION] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WERKS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LGORT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LGORT_STOREAGE_LOCATION] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PO_QTY] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UNIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NETPR_PRICE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PER] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WAERS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MWSKZ] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EINDT_DELIVERY_DATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KNTTP] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MATKL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[POSID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SAKNR_GL_ACCOUNT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KOSTL_COST_CENTER] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO