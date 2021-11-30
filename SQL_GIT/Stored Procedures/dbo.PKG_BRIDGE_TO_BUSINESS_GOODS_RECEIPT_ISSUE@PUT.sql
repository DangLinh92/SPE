SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROC [dbo].[PKG_BRIDGE_TO_BUSINESS_GOODS_RECEIPT_ISSUE@PUT](
@A_QUANTITY NVARCHAR(50),
@A_IN_OUT  NVARCHAR(50),
@A_TRAN_USER_ID NVARCHAR(50),
@N_RETURN	int				OUTPUT,
@V_RETURN	NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY

     BEGIN TRAN
      DECLARE @DATA_INPUT GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE

	  IF @A_IN_OUT = 'OUT'
	    BEGIN
			  INSERT INTO @DATA_INPUT
			  VALUES ('N', 'FLUX TSF-8818HF', 'Keo dán bản mạch', 1, 'EA', NULL, NULL, NULL, NULL, NULL, NULL, 'SMT_K1', 'SMT', 'OUT', GETDATE(), @A_TRAN_USER_ID, 'WHNP1-DB', NULL, 'COMPLETE', '4', '', '', 0, NULL, NULL)
	    END
	  ELSE
	      BEGIN
				INSERT INTO @DATA_INPUT
				VALUES('N','FLUX TSF-8818HF','Keo dán bản mạch',cast(@A_QUANTITY as int),'EA',0,0,0,0,'','','SMT_K1','SMT','IN',GETDATE(),@A_TRAN_USER_ID,'WHNP1-DB','','COMPLETE','1','','',0,'2199-01-01','False')
		  END

	   EXEC SPARE_PART_UPDATE.[dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@PUT]  @A_DATA = @DATA_INPUT
                                                                         ,@A_USER = 'WHNP1-DB'
                                                                         ,@A_DELIVER_RECEIVER = 'WHNP1-DB'
                                                                         ,@A_RETURN_SPARE_PART_ID = ''
                                                                         ,@A_DEPARMENT = 'SMT'
                                                                         ,@N_RETURN = @N_RETURN OUT
                                                                         ,@V_RETURN = @V_RETURN OUT;

									IF @N_RETURN <> 0
									THROW @N_RETURN, @V_RETURN, 1;
SET @N_RETURN = 0;
SET @V_RETURN = 'MSG_COM_004';
COMMIT TRAN
END TRY
BEGIN CATCH
 SET @N_RETURN = ERROR_NUMBER();
 SET @V_RETURN = ERROR_MESSAGE();
 ROLLBACK TRAN;
END CATCH 
GO
