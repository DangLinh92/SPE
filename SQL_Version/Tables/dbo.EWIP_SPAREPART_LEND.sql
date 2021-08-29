CREATE TABLE [dbo].[EWIP_SPAREPART_LEND] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NULL,
  [DATE_LEND] [date] NULL,
  [QUANTITY] [float] NULL,
  [UNIT] [nvarchar](50) NULL,
  [DATE_PAY] [date] NULL,
  [DATE_PAY_ACTUAL] [date] NULL,
  [USER_CREATE] [nvarchar](50) NULL,
  [USER_UPDATE] [nvarchar](50) NULL,
  [DATE_UPDATE] [date] NULL,
  [DEPT_CODE] [nvarchar](50) NULL,
  [IS_PAY] [bit] NULL,
  [QUANTITY_PAY] [float] NULL,
  [LEND_CODE] [nvarchar](50) NULL,
  CONSTRAINT [PK_EWIP_SPAREPART_LEND] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO