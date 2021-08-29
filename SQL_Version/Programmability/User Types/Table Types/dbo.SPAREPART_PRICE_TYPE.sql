CREATE TYPE [dbo].[SPAREPART_PRICE_TYPE] AS TABLE (
  [STT] [nvarchar](20) NULL,
  [SPARE_PART_CODE] [nvarchar](50) NULL,
  [NAME_VN] [nvarchar](50) NULL,
  [PRICE_VN] [float] NULL,
  [PRICE_US] [float] NULL,
  [UNIT] [nvarchar](50) NULL,
  [DATE] [nvarchar](50) NULL
)
GO