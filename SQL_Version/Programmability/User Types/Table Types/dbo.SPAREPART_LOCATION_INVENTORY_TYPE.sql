CREATE TYPE [dbo].[SPAREPART_LOCATION_INVENTORY_TYPE] AS TABLE (
  [SPARE_PART_CODE] [nvarchar](50) NULL,
  [NAME_VI] [nvarchar](50) NULL,
  [CONDITION_CODE] [nvarchar](50) NULL,
  [TIME_IN] [nvarchar](10) NULL,
  [EXPIRED_DATE] [nvarchar](50) NULL,
  [INVENTORY_ASSETS_TIME] [nvarchar](50) NULL,
  [UNIT] [nvarchar](50) NULL,
  [LOCATION] [nvarchar](50) NULL,
  [QUANTITY] [nvarchar](50) NULL,
  [QUANTITY_REAL] [nvarchar](50) NULL,
  [DIFF] [nvarchar](50) NULL
)
GO