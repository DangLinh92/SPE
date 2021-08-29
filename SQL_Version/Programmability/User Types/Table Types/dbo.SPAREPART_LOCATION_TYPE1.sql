CREATE TYPE [dbo].[SPAREPART_LOCATION_TYPE1] AS TABLE (
  [SPARE_PART_CODE] [nvarchar](50) NULL,
  [LOCATION_CODE] [nvarchar](50) NULL,
  [CONDITION_CODE] [nvarchar](50) NULL,
  [IS_WAITE] [nvarchar](10) NULL,
  [QUANTITY] [nvarchar](50) NULL,
  [UNIT_ID] [nvarchar](50) NULL,
  [EXPIRED_DATE] [nvarchar](50) NULL,
  [TIME_IN] [nvarchar](50) NULL
)
GO