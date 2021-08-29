CREATE TABLE [dbo].[EWIP_ORDER_DETAIL] (
  [ID] [int] IDENTITY,
  [PO_ID] [nvarchar](50) NULL,
  [PO_CREATE] [datetime] NULL,
  [BKGRP] [nvarchar](50) NULL,
  [KUNNR] [nvarchar](50) NULL,
  [PSTYP] [nvarchar](50) NULL,
  [SPARE_PART_CODE] [nvarchar](50) NULL,
  [WERKS] [nvarchar](50) NULL,
  [LGORT] [nvarchar](50) NULL,
  [NETPR] [float] NULL,
  [PER] [float] NULL,
  [WAERS] [nvarchar](50) NULL,
  [MWSKZ] [nvarchar](50) NULL,
  [KNTTP] [nvarchar](50) NULL CONSTRAINT [DF_EWIP_ORDER_DETAIL_KNTTP] DEFAULT (N'K'),
  [MATKL] [nvarchar](50) NULL,
  [POSID] [nvarchar](50) NULL,
  [DEPT_CODE] [nvarchar](50) NULL,
  [PO_QTY] [float] NULL,
  [UNIT] [nvarchar](50) NULL,
  [PR_CODE] [nvarchar](50) NULL,
  [PO_ID_TEMP] [nvarchar](50) NULL,
  [TXZ01_DESCRIPTION] [nvarchar](max) NULL,
  [VENDOR] [nvarchar](50) NULL,
  [DELIVERY_DATE] [nvarchar](50) NULL,
  [GL_ACCOUNT] [nvarchar](50) NULL,
  [COST_CENTER] [nvarchar](50) NULL,
  CONSTRAINT [PK_EWIP_ORDER_DETAIL] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma nguoi mua hang', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'BKGRP'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'고객-Customer', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'KUNNR'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Item Cat.', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'PSTYP'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Ma hang', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'SPARE_PART_CODE'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'플랜트-PLANT', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'WERKS'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Storage Location', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'LGORT'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Price', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'NETPR'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'가격단위', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'PER'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Currency : USD', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'WAERS'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Tax Code : VZ', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'MWSKZ'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'AccAssCat: DEFALT : K WITH MRO', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'KNTTP'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Material Group', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'MATKL'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'SO LUONG PO', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'PO_QTY'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'DO VI', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_ORDER_DETAIL', 'COLUMN', N'UNIT'
GO