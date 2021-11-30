CREATE TYPE [dbo].[SPAREPART_PRICE_TYPE] AS TABLE
(
[STT] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPARE_PART_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NAME_VN] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PRICE_VN] [float] NULL,
[PRICE_US] [float] NULL,
[UNIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INPUT_DEFAULT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
