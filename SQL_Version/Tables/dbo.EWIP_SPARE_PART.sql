CREATE TABLE [dbo].[EWIP_SPARE_PART] (
  [ID] [int] IDENTITY,
  [CODE] [nvarchar](50) NOT NULL,
  [NAME_VI] [nvarchar](200) NOT NULL,
  [NAME_KR] [nvarchar](200) NULL,
  [UNIT_ID] [varchar](20) NOT NULL,
  [GL_ACCOUNT] [varchar](50) NOT NULL,
  [VENDER_ID] [varchar](50) NOT NULL,
  [IMAGE] [nvarchar](max) NULL,
  [DESCRIPTION] [nvarchar](1000) NULL,
  [TYPE] [varchar](50) NULL,
  [MATERIAL] [nvarchar](50) NULL,
  [USES] [nvarchar](200) NULL,
  [EQUIPMENT_USED] [nvarchar](200) NULL,
  [SPECIFICATIONS] [nvarchar](500) NULL,
  [SIZE] [nvarchar](50) NULL,
  [WEIGHT] [nvarchar](50) NULL,
  [CREATED_AT] [date] NULL,
  [UPDATED_AT] [date] NULL,
  [CREATE_BY] [nvarchar](50) NULL,
  [UPDATE_BY] [nvarchar](50) NULL,
  [MIN_ORDER] [float] NULL,
  [SP_DEPT_CODE] [nvarchar](100) NULL,
  [LEAD_TIME] [int] NULL,
  CONSTRAINT [PK_EWIP_SPARE_PART] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Spare part or Consumable part', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'TYPE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Chất liệu', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'MATERIAL'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cong dung', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'USES'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'thiet bi su dung', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'EQUIPMENT_USED'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Thong so ky thuat', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'SPECIFICATIONS'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Kich thuoc', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'SIZE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Can nang', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_SPARE_PART', 'COLUMN', N'WEIGHT'
GO