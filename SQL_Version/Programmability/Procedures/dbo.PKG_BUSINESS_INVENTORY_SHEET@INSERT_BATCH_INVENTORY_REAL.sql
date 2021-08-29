﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_SHEET@INSERT_BATCH_INVENTORY_REAL](
@A_DATA  SPAREPART_LOCATION_INVENTORY_TYPE1  READONLY,
@A_DEPARTMENT_CODE NVARCHAR(50),
@A_STOCK NVARCHAR(50),
@A_USER NVARCHAR(50),
@A_TIME NVARCHAR(50),
@A_FROM_TIME NVARCHAR(50),
@A_TO_TIME NVARCHAR(50),
@A_TITLE   NVARCHAR(50),
@A_SHEET_ID NVARCHAR(50),
@N_RETURN  int	OUTPUT,
@V_RETURN  NVARCHAR(4000) OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			BEGIN TRAN
			DECLARE @SPARE_PART_CODE  NVARCHAR(50)
			DECLARE @UNIT NVARCHAR(50)
			DECLARE @QUANTITY_REAL FLOAT
			DECLARE @INVENTORY_ASSETS_TIME NVARCHAR(50)
			DECLARE @DEPT_CODE NVARCHAR(50)
			DECLARE @STOCK_CODE NVARCHAR(50)

			DECLARE @CHECK INT = 0

			SELECT @CHECK = COUNT(*) FROM [dbo].[EWIP_INVENTORY_SHEET] WHERE [DEPT_CODE] = @A_DEPARTMENT_CODE AND STOCK_CODE = @A_STOCK AND [SHEET_ID] = @A_SHEET_ID

			IF @CHECK = 0
				INSERT INTO [dbo].[EWIP_INVENTORY_SHEET]
				VALUES(@A_SHEET_ID,CAST(@A_FROM_TIME AS DATE), CAST(@A_TO_TIME AS DATE),@A_DEPARTMENT_CODE,@A_STOCK,@A_USER,@A_USER,GETDATE(),@A_TITLE,CAST(@A_TIME AS date))
			ELSE
			   UPDATE [dbo].[EWIP_INVENTORY_SHEET]
			   SET [DATE_START] = CAST(@A_FROM_TIME AS DATE),[DATE_END] = CAST(@A_TO_TIME AS DATE),[USER_UPDATE] = @A_USER,[DATE_UPDATE]= GETDATE(),[TITLE] = @A_TITLE,[INVENTORY_SHEET_MONTH] = CAST(@A_TIME AS date)
			   WHERE [DEPT_CODE] = @A_DEPARTMENT_CODE AND STOCK_CODE = @A_STOCK AND [SHEET_ID] = @A_SHEET_ID

			DELETE FROM [dbo].[EWIP_INVENTORY_SHEET_DETAIL]
			WHERE [SHEET_ID] = @A_SHEET_ID AND [DEPT_CODE] = @A_DEPARTMENT_CODE AND [STOCK_CODE] = @A_STOCK

			INSERT INTO [dbo].[EWIP_INVENTORY_SHEET_DETAIL]
			SELECT [SPARE_PART_CODE],[LOCATION],CAST([QUANTITY] AS FLOAT),[UNIT],@A_SHEET_ID AS [SHEET_ID],@A_DEPARTMENT_CODE AS [DEPT_CODE],@A_STOCK AS [STOCK_CODE],CAST([QUANTITY_REAL] AS FLOAT),[DIFF],'True' as [IS_CHECK],[CONDITION_CODE],CAST([TIME_IN] AS DATE),CAST([EXPIRED_DATE] AS DATE)
			FROM @A_DATA

			DECLARE cursorInventory CURSOR FOR
			SELECT [SPARE_PART_CODE],[UNIT],SUM(CAST([QUANTITY_REAL] AS float)) AS [QUANTITY_REAL],[INVENTORY_ASSETS_TIME],@A_DEPARTMENT_CODE AS [DEPT_CODE],@A_STOCK AS [STOCK_CODE]
			FROM @A_DATA
			GROUP BY [SPARE_PART_CODE],[UNIT],[INVENTORY_ASSETS_TIME]

			OPEN cursorInventory

			FETCH NEXT FROM cursorInventory
			INTO @SPARE_PART_CODE,@UNIT,@QUANTITY_REAL,@INVENTORY_ASSETS_TIME,@DEPT_CODE,@STOCK_CODE

			WHILE @@FETCH_STATUS = 0
							BEGIN
									IF @A_TIME <> '' AND @A_TIME IS NOT NULL
									    SET @INVENTORY_ASSETS_TIME = @A_TIME

									IF @QUANTITY_REAL IS NULL
									    SET @QUANTITY_REAL = 0

							        DECLARE @dateAssets date = CAST(@INVENTORY_ASSETS_TIME AS DATE)
									DECLARE @YEAR INT= YEAR(@dateAssets)
									DECLARE @MONTH INT= MONTH(@dateAssets)

								   EXEC [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@PUT_QUANTITY_REAL]
										@A_DEPARTMENT = @DEPT_CODE,
										@A_STOCK       = @STOCK_CODE,
										@A_SPARE_PART_CODE = @SPARE_PART_CODE,
										@A_QUANTITY_REAL   = @QUANTITY_REAL,
										@A_UNIT            = @UNIT,
										@A_DATE			   =  @INVENTORY_ASSETS_TIME,
										@A_YEAR            = @YEAR,
										@A_MONTH		   = @MONTH,
										@A_QUANTITY        = -1,
										@A_USER            = @A_USER,
										@N_RETURN		   = @N_RETURN 	OUT,
										@V_RETURN		   = @V_RETURN	OUT

									IF @N_RETURN <> 0 
										THROW @N_RETURN, @V_RETURN, 1;

								   FETCH NEXT FROM cursorInventory
								   INTO @SPARE_PART_CODE,@UNIT,@QUANTITY_REAL,@INVENTORY_ASSETS_TIME,@DEPT_CODE,@STOCK_CODE
							END
		
					CLOSE cursorInventory
					DEALLOCATE cursorInventory
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRAN
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  Rollback TRAN
END CATCH
GO