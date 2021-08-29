SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@PUT](
@A_DATA   GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE READONLY,
@A_USER    NVARCHAR(50),
@A_DELIVER_RECEIVER NVARCHAR(100),
@A_RETURN_SPARE_PART_ID NVARCHAR(50),
@N_RETURN	int				OUTPUT,
@V_RETURN	NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @A_RECEIPT_ISSUE_CODE NVARCHAR(50);
			DECLARE @A_STATUS NVARCHAR(50);
			DECLARE @A_INOUT NVARCHAR(50);

			SELECT @A_RECEIPT_ISSUE_CODE = [RECEIPT_ISSUE_CODE],@A_STATUS = [STATUS],@A_INOUT =[INT_OUT]  FROM @A_DATA GROUP BY [RECEIPT_ISSUE_CODE],[STATUS],[INT_OUT]

			BEGIN TRAN;
			    IF @A_RECEIPT_ISSUE_CODE = 'N'
					SET @A_RECEIPT_ISSUE_CODE = NEWID()
				ELSE
					BEGIN
						DELETE FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] WHERE CODE_NO = @A_RECEIPT_ISSUE_CODE
						DELETE FROM [dbo].[EWIP_HISTORY_INVENTORY]  WHERE STOCK_IN_OUT_CODE = @A_RECEIPT_ISSUE_CODE

						IF @A_INOUT = 'IN'
							DELETE FROM [dbo].[EWIP_SP_STOCKIN]  WHERE STOCK_IN_CODE = @A_RECEIPT_ISSUE_CODE
						ELSE 
							BEGIN
								DELETE FROM [dbo].[EWIP_STOCK_OUT]  WHERE [STOCK_OUT_CODE] = @A_RECEIPT_ISSUE_CODE
							END
					END
				  
					INSERT INTO [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING]
					SELECT @A_RECEIPT_ISSUE_CODE,[CREATE_DATE],[INT_OUT],[STOCK_CODE],[DEPT_CODE],[USER_CREATE],[USER_SYS],[ORDER_CODE],[STATUS],@A_DELIVER_RECEIVER AS [DELIVERET_RECEIVER],CONVERT(VARCHAR(8),GETDATE(),108) AS [TIME_INPUT]
					FROM @A_DATA
					GROUP BY [DEPT_CODE],[STOCK_CODE],[RECEIPT_ISSUE_CODE],[CREATE_DATE],[INT_OUT],[USER_SYS],[STATUS],[USER_CREATE],[ORDER_CODE]

					IF @A_INOUT = 'IN'
						BEGIN	
							INSERT INTO [dbo].[EWIP_SP_STOCKIN]
								SELECT 
								[SPARE_PART_CODE],
								@A_RECEIPT_ISSUE_CODE,
								[QUANTITY],
								[PRICE_VN],
								[UNIT],
								VENDER_ID,
								[STOCK_CODE],
								[CAUSE],
								[DEPT_CODE],
								[CREATE_DATE],
								[USER_CREATE],
								[AMOUNT_US],
								[AMOUNT_VN],
								[NOTE],
								YEAR([CREATE_DATE]),
								MONTH([CREATE_DATE]),
								[PRICE_US],
								[TYPE_IN_OUT_CODE],
								[QUANTITY_NG],
								[EXPRIRED_DATE],
								[IS_INTEGRATED]
								FROM @A_DATA
								LEFT JOIN [dbo].[EWIP_SPARE_PART] ON CODE = [SPARE_PART_CODE] AND SP_DEPT_CODE = DEPT_CODE
						END
					ELSE
					   BEGIN	
							INSERT INTO [dbo].[EWIP_STOCK_OUT]
								 SELECT 
									@A_RECEIPT_ISSUE_CODE,
									[SPARE_PART_CODE],
									[CAUSE],
									[STOCK_CODE],
									[DEPT_CODE],
									[CREATE_DATE],
									YEAR([CREATE_DATE]),
									MONTH([CREATE_DATE]),
									@A_USER,
									[QUANTITY],
									[TYPE_IN_OUT_CODE],
									case when [RETURN_TIME] = '' then null
									    else [RETURN_TIME]
									end,
									[UNIT],
									[LOCATION]
									FROM @A_DATA
						END
					

					INSERT INTO [dbo].[EWIP_HISTORY_INVENTORY]
					SELECT [SPARE_PART_CODE],[QUANTITY],[UNIT],[DEPT_CODE],[STOCK_CODE],[CREATE_DATE],MONTH([CREATE_DATE]),YEAR([CREATE_DATE]),[INT_OUT],@A_RECEIPT_ISSUE_CODE,[STATUS],[QUANTITY_NG],[EXPRIRED_DATE]
					FROM @A_DATA

					-- RECACULATOR INVENTORY : Tinh lai ton kho khi insert/update
					IF @A_STATUS = 'COMPLETE'
					  BEGIN

						DECLARE @A_DATE DATE
						DECLARE @A_STOCK_CODE VARCHAR(50)
						DECLARE @A_DEPT_CODE NVARCHAR(100)
						DECLARE @A_USER_CREATE NVARCHAR(50)		
						DECLARE @A_SPARE_PART_CODE NVARCHAR(50)					
						DECLARE @A_UNIT NVARCHAR(50)
						DECLARE @A_YEAR int
						DECLARE @A_MONTH int
						DECLARE @A_LOCATION NVARCHAR(MAX)
						DECLARE @A_PRICE_VN float
						DECLARE @A_PRICE_US float
						DECLARE @A_QUANTITY_NG FLOAT = 0
						DECLARE @A_EXPIRED_DATE DATE
						DECLARE @A_QUANTITY_IN FLOAT = 0
						DECLARE @A_IS_INTEGRATED BIT
						DECLARE @A_TYPE_IN_OUT NVARCHAR(20)
						DECLARE @A_RETURN_TIME NVARCHAR(50)

						--LOCATION: location_quantity_condition_expired date_in time_unit
						DECLARE @A_TMP_LOCATION NVARCHAR(200)
						DECLARE @A_TMP_L NVARCHAR(100)
						DECLARE @A_TMP_Q NVARCHAR(20)
						DECLARE @A_TMP_C NVARCHAR(50)
						DECLARE @A_TMP_EX NVARCHAR(50)
						DECLARE @A_TMP_IT NVARCHAR(50)
						DECLARE @A_TMP_UNIT NVARCHAR(20)
					
						DECLARE cursorInventory CURSOR FOR
						SELECT [DEPT_CODE],[STOCK_CODE],[SPARE_PART_CODE],[UNIT],[CREATE_DATE],YEAR([CREATE_DATE]) AS [YEAR],MONTH([CREATE_DATE]) AS [MONTH],
						       [USER_CREATE],[LOCATION],[PRICE_VN],[PRICE_US],[QUANTITY_NG],[EXPRIRED_DATE],[QUANTITY],[IS_INTEGRATED],[TYPE_IN_OUT_CODE],[RETURN_TIME]
						FROM @A_DATA

						OPEN cursorInventory

						FETCH NEXT FROM cursorInventory
						INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION,@A_PRICE_VN,@A_PRICE_US,@A_QUANTITY_NG,@A_EXPIRED_DATE,@A_QUANTITY_IN,@A_IS_INTEGRATED,@A_TYPE_IN_OUT,@A_RETURN_TIME

						IF @A_USER_CREATE = '' OR @A_USER_CREATE IS NULL 
							SET @A_USER_CREATE = @A_USER

						WHILE @@FETCH_STATUS = 0
							BEGIN

								IF(@A_DATE <= GETDATE())
									BEGIN
										DECLARE @CountMonth int = DATEDIFF(month,@A_DATE,GETDATE())

										WHILE @CountMonth >= 0
										  BEGIN TRY
										        DECLARE @newDate date = DATEADD(month,-@CountMonth,GETDATE())
												DECLARE @year nvarchar(4) = YEAR(@newDate)
												DECLARE @month nvarchar(2) = MONTH(@newDate)

												EXEC [dbo].[PKG_BUSINESS_CACULATOR_INVENTORY@CALL] 
													 @A_DEPARTMENT = @A_DEPT_CODE,
													 @A_STOCK = @A_STOCK_CODE,
													 @A_SPARE_PART_CODE = @A_SPARE_PART_CODE,
													 @A_UNIT = @A_UNIT,
													 @A_DATE = @newDate,
													 @A_YEAR = @year,
													 @A_MONTH = @month,
													 @A_USER = @A_USER_CREATE,
													 @N_RETURN =@N_RETURN OUT,
													 @V_RETURN = @V_RETURN OUT;

													 IF @N_RETURN <> 0 
														THROW @N_RETURN, @V_RETURN, 1;

												SET @CountMonth = @CountMonth - 1
										  END TRY
										  BEGIN CATCH
												THROW;
										  END CATCH


										  -- update  so luong tai vi tri, khi tinh ton kho roi thi k cho update.
										  IF @A_INOUT = 'OUT'
										    BEGIN 
													DECLARE locationCursor CURSOR FOR
													select value from string_split(@A_LOCATION,',') -- W_20_OK_2021-07-30,01-03_10_OK_2021-07-30 : old ->
													--new: 17-07_250_OK_2199-01-01_2021-06-30_EA,17-07_250_NG_2199-01-01_2021-07-20_EA,W_99.99999_OK_2199-01-01_2021-06-30_EA
													-- W_1_OK_2199-01-01_2021-06-30_PACK
													-- location_quantity_condition_expired date_in time_unit
													 
													OPEN locationCursor

													FETCH NEXT FROM locationCursor
													INTO @A_TMP_LOCATION

													--PRINT(@A_TMP_LOCATION)

													WHILE @@FETCH_STATUS = 0
														BEGIN

																SET @A_TMP_L = SUBSTRING(@A_TMP_LOCATION,1,CHARINDEX('_',@A_TMP_LOCATION) - 1)
																SET @A_TMP_Q = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L)+2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L)+2)-LEN(@A_TMP_L)- 2)
																SET @A_TMP_C = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q) + 2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q) - 2)
																SET @A_TMP_EX = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C) + 2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C) - 2)
																SET @A_TMP_IT = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX) + 2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX) - 2)
																SET @A_TMP_UNIT = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) + 2,LEN(@A_TMP_LOCATION) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) - 1)

																UPDATE [dbo].[EWIP_SPAREPART_LOCATION]
																SET [QUANTITY] = [QUANTITY] - [dbo].[CONVERT_UNIT](@A_TMP_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE) * cast(@A_TMP_Q as float)
																WHERE 
																	[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
																	[DEPT_CODE] = @A_DEPT_CODE AND 
																	[STOCK_CODE] = @A_STOCK_CODE AND 
																	 @A_TMP_LOCATION LIKE 
																	  (CASE 
																		  WHEN LOCATION_CODE = '' THEN   N'W_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar)+'_'+ CAST(TIME_IN as nvarchar)+'_%'
																		  WHEN LOCATION_CODE IS NULL THEN  N'W_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar)+'_'+ CAST(TIME_IN as nvarchar)+'_%'
																		  ELSE N'' + LOCATION_CODE +'_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar) +'_'+ CAST(TIME_IN as nvarchar)+'_%'
																	  END) AND
																	[EXPIRED_DATE] = CAST(@A_TMP_EX AS date) AND TIME_IN = CAST(@A_TMP_IT AS date) AND CONDITION_CODE = @A_TMP_C

																	-- DELETE IF QUANTITY = 0
																	DELETE FROM [dbo].[EWIP_SPAREPART_LOCATION]
																	WHERE 
																	[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
																	[DEPT_CODE] = @A_DEPT_CODE AND 
																	[STOCK_CODE] = @A_STOCK_CODE AND 
																	[QUANTITY] = 0 AND
																	 @A_TMP_LOCATION LIKE 
																	  (CASE 
																		  WHEN LOCATION_CODE = '' THEN   N'W_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar)+'_'+ CAST(TIME_IN as nvarchar)+'_%'
																		  WHEN LOCATION_CODE IS NULL THEN  N'W_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar)+'_'+ CAST(TIME_IN as nvarchar)+'_%'
																		  ELSE N'' + LOCATION_CODE +'_%_' +[CONDITION_CODE] + '_'+ CAST([EXPIRED_DATE] AS nvarchar) +'_'+ CAST(TIME_IN as nvarchar)+'_%'
																	  END) AND
																	[EXPIRED_DATE] = CAST(@A_TMP_EX AS date) AND TIME_IN = CAST(@A_TMP_IT AS date) AND CONDITION_CODE = @A_TMP_C 

																	
																	INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION]
																	VALUES(@A_SPARE_PART_CODE,@A_TMP_L,'OUT',@A_TMP_C,cast(@A_TMP_Q as float),@A_DEPT_CODE,@A_STOCK_CODE,@A_TMP_UNIT,CAST(@A_TMP_EX AS date),CAST(@A_TMP_IT AS date),GETDATE(),@A_USER)

																	
																	IF @A_TYPE_IN_OUT = '3' -- XUAT TRA LAI
																	  BEGIN
																		 INSERT INTO [dbo].[EWIP_SPAREPART_LEND]
																		 VALUES(@A_SPARE_PART_CODE,GETDATE(),cast(@A_TMP_Q as float),@A_TMP_UNIT,CAST(@A_RETURN_TIME AS date),NULL,@A_USER,NULL,NULL,@A_DEPT_CODE,'False',0,@A_RETURN_SPARE_PART_ID);

																		 INSERT INTO [dbo].[EWIP_SPAREPART_LEND_EX]
																		 VALUES(@A_RETURN_SPARE_PART_ID,@A_RECEIPT_ISSUE_CODE,cast(@A_TMP_Q as float),@A_TMP_UNIT)
																	  END

																	FETCH NEXT FROM locationCursor
																	INTO @A_TMP_LOCATION
														END

														CLOSE locationCursor
														DEALLOCATE locationCursor
											END
										  ELSE
										     BEGIN
													IF @A_RETURN_TIME IS NOT NULL AND @A_RETURN_TIME != ''
													     BEGIN
																IF EXISTS(SELECT top 1 * FROM [dbo].[EWIP_SPAREPART_LEND] WHERE [LEND_CODE] = @A_RETURN_SPARE_PART_ID)
																     BEGIN
																	       
																			DECLARE @CHECK_IS_PAY FLOAT 
																			SELECT @CHECK_IS_PAY = (ISNULL([QUANTITY_PAY],0) + [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT],@A_SPARE_PART_CODE,@A_DEPT_CODE) * @A_QUANTITY_IN - [QUANTITY])
																			FROM [dbo].[EWIP_SPAREPART_LEND]
																			WHERE [LEND_CODE] = @A_RETURN_SPARE_PART_ID

																			DECLARE @ISPAY BIT
																			IF @CHECK_IS_PAY < 0
																			   SET @ISPAY = 'False'
																			else
																			   set @ISPAY = 'True'

																			UPDATE [dbo].[EWIP_SPAREPART_LEND]
																			SET  [QUANTITY_PAY] = ISNULL([QUANTITY_PAY],0) + [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT],@A_SPARE_PART_CODE,@A_DEPT_CODE) * @A_QUANTITY_IN,
																			     [DATE_PAY_ACTUAL] = GETDATE(),[USER_UPDATE] = @A_USER,[DATE_UPDATE] = GETDATE(),[IS_PAY] = @ISPAY
																			WHERE [LEND_CODE] = @A_RETURN_SPARE_PART_ID

																			INSERT INTO [dbo].[EWIP_SPAREPART_LEND_EX]
																			VALUES(@A_RETURN_SPARE_PART_ID,@A_RECEIPT_ISSUE_CODE,cast(@A_QUANTITY_IN as float),@A_UNIT)
																	 END
														 END

											        IF @A_QUANTITY_NG = 0 OR @A_QUANTITY_NG IS NULL 
													     BEGIN

														    DECLARE @QUANTITY_IN_W4 FLOAT = 0;
															DECLARE @ID_IN_W4 INT
															DECLARE @CONDTION NVARCHAR(50)

															IF @A_IS_INTEGRATED = 'True'
															    set @CONDTION = 'INTEGRATED'
															else 
															   set @CONDTION = 'OK'

															SELECT @QUANTITY_IN_W4 = [dbo].[CONVERT_UNIT]([UNIT_ID],@A_UNIT,@A_SPARE_PART_CODE,@A_DEPT_CODE)*QUANTITY,@ID_IN_W4 =ID
															FROM [dbo].[EWIP_SPAREPART_LOCATION]
															WHERE [IS_WAITE] = 'True' AND 
															[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
															[DEPT_CODE] = @A_DEPT_CODE AND 
															[STOCK_CODE] = @A_STOCK_CODE AND
															CONDITION_CODE = @CONDTION AND
															EXPIRED_DATE = CAST(@A_EXPIRED_DATE AS DATE) AND
															TIME_IN = @A_DATE

															IF @QUANTITY_IN_W4 = 0
																INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
																VALUES(@A_SPARE_PART_CODE,NULL,@CONDTION,'True',@A_QUANTITY_IN,@A_DEPT_CODE,@A_STOCK_CODE,NULL,@A_UNIT,@A_EXPIRED_DATE,@A_DATE)
															ELSE
															     UPDATE  [dbo].[EWIP_SPAREPART_LOCATION]
																 SET QUANTITY = QUANTITY + @A_QUANTITY_IN * [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE)
																 WHERE ID = @ID_IN_W4 

															INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION]
															VALUES(@A_SPARE_PART_CODE,'IN','',@CONDTION,@A_QUANTITY_IN,@A_DEPT_CODE,@A_STOCK_CODE,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,GETDATE(),@A_USER)
														 END
													 ELSE
													     BEGIN

															 DECLARE @QUANTITY_OKE FLOAT
															 SET @QUANTITY_OKE = @A_QUANTITY_IN - @A_QUANTITY_NG
															 IF @QUANTITY_OKE > 0
															    BEGIN
																	
																	 DECLARE @QUANTITY_IN_W3 FLOAT = 0;
																	 DECLARE @ID_IN_W3 INT
																	 
																	 SELECT @QUANTITY_IN_W3 = [dbo].[CONVERT_UNIT]([UNIT_ID],@A_UNIT,@A_SPARE_PART_CODE,@A_DEPT_CODE)*QUANTITY,@ID_IN_W3 =ID
																	 FROM [dbo].[EWIP_SPAREPART_LOCATION]
																	 WHERE [IS_WAITE] = 'True' AND 
																	 [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
																	 [DEPT_CODE] = @A_DEPT_CODE AND 
																	 [STOCK_CODE] = @A_STOCK_CODE AND
																	 CONDITION_CODE = 'OK' AND
																	 EXPIRED_DATE = CAST(@A_EXPIRED_DATE AS DATE) AND
																	 TIME_IN = @A_DATE
																    
																	IF @QUANTITY_IN_W3 = 0
																		INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
																		VALUES(@A_SPARE_PART_CODE,NULL,'OK','True',@QUANTITY_OKE,@A_DEPT_CODE,@A_STOCK_CODE,NULL,@A_UNIT,@A_EXPIRED_DATE,@A_DATE)
																	ELSE
																		UPDATE  [dbo].[EWIP_SPAREPART_LOCATION]
																		SET QUANTITY = QUANTITY + @QUANTITY_OKE * [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE)
																		WHERE ID = @ID_IN_W3 

																	INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION]
																	VALUES(@A_SPARE_PART_CODE,'IN','','OK',@QUANTITY_OKE,@A_DEPT_CODE,@A_STOCK_CODE,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,GETDATE(),@A_USER)

																	IF @A_QUANTITY_NG > 0
																	    BEGIN
																				DECLARE @QUANTITY_IN_W1_NG FLOAT = 0;
																				DECLARE @ID_IN_W1_NG INT

																				SELECT @QUANTITY_IN_W1_NG = [dbo].[CONVERT_UNIT]([UNIT_ID],@A_UNIT,@A_SPARE_PART_CODE,@A_DEPT_CODE)*QUANTITY,@ID_IN_W1_NG =ID
																				FROM [dbo].[EWIP_SPAREPART_LOCATION]
																				WHERE [IS_WAITE] = 'True' AND 
																				[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
																				[DEPT_CODE] = @A_DEPT_CODE AND 
																				[STOCK_CODE] = @A_STOCK_CODE AND
																				CONDITION_CODE = 'NG' AND
																				EXPIRED_DATE = CAST(@A_EXPIRED_DATE AS DATE) AND
																				TIME_IN = @A_DATE

																				INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION]
																				VALUES(@A_SPARE_PART_CODE,'IN','','NG',@A_QUANTITY_NG,@A_DEPT_CODE,@A_STOCK_CODE,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,GETDATE(),@A_USER)

																				IF @QUANTITY_IN_W1_NG = 0
																					INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
																					VALUES(@A_SPARE_PART_CODE,NULL,'NG','True',@A_QUANTITY_NG,@A_DEPT_CODE,@A_STOCK_CODE,NULL,@A_UNIT,@A_EXPIRED_DATE,@A_DATE)
																				ELSE
																				    UPDATE [dbo].[EWIP_SPAREPART_LOCATION]
																					SET QUANTITY = QUANTITY + @A_QUANTITY_NG* [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE)
																					WHERE ID = @ID_IN_W1_NG
																		END
																END
															 ELSE
															    BEGIN

																				DECLARE @QUANTITY_IN_W2_NG FLOAT = 0;
																				DECLARE @ID_IN_W2_NG INT

																				SELECT @QUANTITY_IN_W2_NG = [dbo].[CONVERT_UNIT]([UNIT_ID],@A_UNIT,@A_SPARE_PART_CODE,@A_DEPT_CODE)*QUANTITY,@ID_IN_W2_NG =ID
																				FROM [dbo].[EWIP_SPAREPART_LOCATION]
																				WHERE [IS_WAITE] = 'True' AND 
																				[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
																				[DEPT_CODE] = @A_DEPT_CODE AND 
																				[STOCK_CODE] = @A_STOCK_CODE AND
																				CONDITION_CODE = 'NG' AND
																				EXPIRED_DATE = CAST(@A_EXPIRED_DATE AS DATE) AND
																				TIME_IN = @A_DATE

																				IF @QUANTITY_IN_W2_NG = 0
																					INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
																					VALUES(@A_SPARE_PART_CODE,NULL,'NG','True',@A_QUANTITY_NG,@A_DEPT_CODE,@A_STOCK_CODE,NULL,@A_UNIT,@A_EXPIRED_DATE,@A_DATE)
																				ELSE
																				    UPDATE [dbo].[EWIP_SPAREPART_LOCATION]
																					SET QUANTITY = QUANTITY + @A_QUANTITY_NG* [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE)
																					WHERE ID = @ID_IN_W2_NG
																END
															     
														 END
											 END
									END

								SET @A_QUANTITY_NG = 0
								SET @A_QUANTITY_IN = 0

								FETCH NEXT FROM cursorInventory
								INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION,@A_PRICE_VN,@A_PRICE_US,@A_QUANTITY_NG,@A_EXPIRED_DATE,@A_QUANTITY_IN,@A_IS_INTEGRATED,@A_TYPE_IN_OUT,@A_RETURN_TIME
							END

					CLOSE cursorInventory
					DEALLOCATE cursorInventory
				END
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRAN;
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  ROLLBACK TRAN;
END CATCH
GO