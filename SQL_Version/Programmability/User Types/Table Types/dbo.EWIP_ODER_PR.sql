CREATE TYPE [dbo].[EWIP_ODER_PR] AS TABLE (
  [ID] [nvarchar](50) NULL,
  [PR_CODE] [nvarchar](50) NULL,
  [MRP_CODE] [nvarchar](50) NULL,
  [TOTAL_VALUE] [float] NULL,
  [TOTAL_VALUE_US] [float] NULL,
  [DATE_CREATE] [nvarchar](50) NULL,
  [DATE_NEED_FINISH] [nvarchar](50) NULL,
  [DEPT_CODE] [nvarchar](50) NULL,
  [PR_STATUS] [nvarchar](50) NULL
)
GO