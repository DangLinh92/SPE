CREATE TABLE [dbo].[EWIP_INVOICES] (
  [ID] [int] IDENTITY,
  [INVOICE_DOC_NO] [nvarchar](50) NULL,
  [CONFIRM] [nvarchar](50) NULL,
  [POSTING] [nvarchar](50) NULL,
  [PO_NO] [nvarchar](50) NULL,
  [BENEFICIARY] [nvarchar](50) NULL,
  [BENEFICIARY_NAME] [nvarchar](2000) NULL,
  [BASELINE_DATE] [nvarchar](50) NULL,
  [ACCOUNTING_DOC] [nvarchar](50) NULL,
  [DOC_NO_OF_INVOICE_DOC_NO] [nvarchar](50) NULL,
  [MATERIAL_ID] [nvarchar](50) NULL,
  [MATERIAL_DESC] [nvarchar](2000) NULL,
  [EXCHANGE_RATE] [nvarchar](50) NULL,
  [AMOUNT_LOCAL] [nvarchar](50) NULL,
  [PURCH_ORG] [nvarchar](50) NULL,
  [POSTING_DATE] [nvarchar](50) NULL,
  [PURCH_GRP] [nvarchar](50) NULL,
  [BL_NO_HOUSE] [nvarchar](50) NULL,
  [DOC_DATE] [nvarchar](50) NULL,
  [QUANTITY] [nvarchar](50) NULL,
  [UNIT] [nvarchar](50) NULL,
  [INVOICE_AMOUNT] [nvarchar](50) NULL,
  [CURRENCY] [nvarchar](50) NULL,
  [BL_DOC_NO] [nvarchar](50) NULL,
  [LC_NO] [nvarchar](50) NULL,
  [IMPORT_REQUEST_NO] [nvarchar](50) NULL,
  [COMMERCIAL_INVOICE_NO] [nvarchar](200) NULL,
  [TRANSACTION] [nvarchar](50) NULL,
  [CREATE_BY] [nvarchar](50) NULL,
  [IMPORT_BY] [nvarchar](50) NULL,
  [IMPORT_DATE] [datetime] NULL,
  CONSTRAINT [PK_EWIP_INVOICES] PRIMARY KEY CLUSTERED ([ID])
)
ON [PRIMARY]
GO