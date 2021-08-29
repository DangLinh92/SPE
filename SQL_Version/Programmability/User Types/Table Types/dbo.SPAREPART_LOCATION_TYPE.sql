CREATE TYPE [dbo].[SPAREPART_LOCATION_TYPE] AS TABLE (
  [SPARE_PART_CODE] [nvarchar](50) NULL,
  [LOCATION_CODE] [nvarchar](50) NULL,
  [CONDITION_CODE] [nvarchar](50) NULL,
  [IS_WAITE] [nvarchar](10) NULL,
  [QUANTITY] [nvarchar](50) NULL,
  [UNIT_ID] [nvarchar](50) NULL
)
GO