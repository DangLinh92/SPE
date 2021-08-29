CREATE TYPE [dbo].[LOCATION_TYPE] AS TABLE (
  [CODE] [nvarchar](50) NULL,
  [STOCK_CODE] [varchar](50) NULL,
  [DEPT_CODE] [nvarchar](100) NULL,
  [RACK_CODE] [nchar](10) NULL
)
GO