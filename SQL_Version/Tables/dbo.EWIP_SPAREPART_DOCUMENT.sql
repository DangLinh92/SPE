CREATE TABLE [dbo].[EWIP_SPAREPART_DOCUMENT] (
  [ID] [int] IDENTITY,
  [SPARE_PART_CODE] [nvarchar](50) NOT NULL,
  [DEPT_CODE] [nvarchar](100) NOT NULL,
  [LINK] [nvarchar](1000) NULL,
  CONSTRAINT [PK_EWIP_SPAREPART_DOCUMENT] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO