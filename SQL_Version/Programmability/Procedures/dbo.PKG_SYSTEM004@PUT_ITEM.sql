﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PKG_SYSTEM004@PUT_ITEM](
@A_PLANT			VARCHAR(50),
@A_USERROLE			VARCHAR(50),
@A_XML				XML,
@A_TRAN_USER_ID		VARCHAR(30),
@A_DEPARTMENT		VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

DECLARE	@V_TRAN_TIME	VARCHAR(14);

DECLARE @V_MENUSEQ		INT;
DECLARE @V_FORMROLE		VARCHAR(3);
DECLARE	@V_USEFLAG		VARCHAR(1);



BEGIN TRY
	SET @V_TRAN_TIME = dbo.FUN_CURR_TIME();

	BEGIN TRAN

		DELETE
		FROM ESYSMSTMRO
		WHERE PLANT = @A_PLANT
		AND USERROLE = @A_USERROLE 
	
		DECLARE R_REC cursor for
		SELECT DISTINCT
			'MENUSEQ' = x.v.value('MENUSEQ[1]', 'INT'),
			'FORMROLE' = x.v.value('FORMROLE[1]', 'varchar(3)'),
			'USEFLAG' = x.v.value('USEFLAG[1]', 'VARCHAR(1)')
		FROM @A_XML.nodes('DocumentElement/Table') x(v);

		OPEN R_REC
		FETCH NEXT FROM R_REC into @V_MENUSEQ, @V_FORMROLE, @V_USEFLAG;
	
		WHILE @@FETCH_STATUS = 0
			BEGIN

				INSERT INTO ESYSMSTMRO (
					PLANT,
					DEPARTMENT,
					USERROLE,
					MENUSEQ,
					FORMROLE,
					USEFLAG,
					CREATE_TIME,
					CREATE_USER
				) VALUES (
					@A_PLANT,
					'ALL',
					@A_USERROLE,
					@V_MENUSEQ,
					@V_FORMROLE,
					@V_USEFLAG,
					@V_TRAN_TIME,
					@A_TRAN_USER_ID
				);
				FETCH NEXT FROM R_REC into @V_MENUSEQ, @V_FORMROLE, @V_USEFLAG;
			END
		CLOSE R_REC;
		DEALLOCATE R_REC;
	COMMIT TRAN;

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_001';
END TRY
BEGIN CATCH

	rollback tran;
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH








GO