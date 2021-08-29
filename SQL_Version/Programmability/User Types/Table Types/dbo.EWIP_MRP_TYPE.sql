CREATE TYPE [dbo].[EWIP_MRP_TYPE] AS TABLE (
  [ID] [int] NULL,
  [SPAREPART_CODE] [nvarchar](50) NULL,
  [QUANTITY_NEED_BUY] [float] NULL,
  [UNIT] [nvarchar](50) NULL,
  [STATUS] [nvarchar](50) NULL,
  [DATE_NEED_BUY] [nvarchar](50) NULL,
  [DATE_NEED_FINISH] [nvarchar](50) NULL,
  [DATE_END_ACTUAL] [nvarchar](50) NULL,
  [USER_UPDATE] [nvarchar](50) NULL,
  [DATE_UPDATE] [nvarchar](50) NULL,
  [OFF_NOTI] [nvarchar](50) NULL,
  [DATE_NEED_REQUIRED] [nvarchar](50) NULL,
  [DEPT_CODE] [nvarchar](50) NULL,
  [MRP_CODE] [nvarchar](50) NULL
)
GO