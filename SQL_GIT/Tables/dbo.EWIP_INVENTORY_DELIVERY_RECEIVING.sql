CREATE TABLE [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CODE_NO] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DATE] [date] NULL,
[IN_OUT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STOCK_CODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPT_CODE] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USER_CREATE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USER_SYS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ORDER_CODE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DELIVERET_RECEIVER] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TIME_INPUT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] ADD CONSTRAINT [PK_EWIP_INVENTORY_DELIVERY_RECEIVING] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'0: NEW, 1: INPROGRESS , 2: COMPLETE , 4: CANCEL', 'SCHEMA', N'dbo', 'TABLE', N'EWIP_INVENTORY_DELIVERY_RECEIVING', 'COLUMN', N'STATUS'
GO
