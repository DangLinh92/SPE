SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@DELETE](
@A_RECEIPT_ISSUE_CODE NVARCHAR(50),
@A_INOUT NVARCHAR(50),
@A_USER    NVARCHAR(50),
@A_STATUS  NVARCHAR(50),
@N_RETURN	int				OUTPUT,
@V_RETURN	NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			BEGIN TRAN;

					DECLARE @A_DATA GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE;

					IF @A_STATUS = 'COMPLETE'
					  BEGIN
					     if @A_INOUT = 'IN'
						   BEGIN
								INSERT INTO @A_DATA
								SELECT 
									   IVR.CODE_NO AS RECEIPT_ISSUE_CODE,
									   HIS.[SPARE_PART_CODE],
									   '',
									   HIS.QUANTITY,
									   HIS.[UNIT],
									   SPT.PRICE_VN,
									   SPT.PRICE_US,
									   SPT.AMOUNT_VN,
									   SPT.AMOUNT_US,
									   SPT.CAUSE,
									   SPT.NOTE,
									   SPT.STOCK_CODE,
									   SPT.DEPT_CODE,
									   HIS.IN_OUT as INT_OUT,
									   IVR.DATE AS [CREATE_DATE],
									   IVR.[USER_CREATE],
									   IVR.USER_SYS,
									   IVR.ORDER_CODE,
									   IVR.STATUS,
									   '' AS [TYPE_IN_OUT_CODE],
									   '',
									   '',
									   SPT.[QUANTITY_NG],
									   SPT.[EXPRIRED_DATE],
									   SPT.[IS_INTEGRATED]
								FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IVR 
								INNER JOIN [dbo].[EWIP_SP_STOCKIN]  SPT ON IVR.CODE_NO = SPT.STOCK_IN_CODE
								INNER JOIN [dbo].[EWIP_HISTORY_INVENTORY]  HIS ON IVR.CODE_NO = HIS.STOCK_IN_OUT_CODE
								WHERE IVR.CODE_NO = @A_RECEIPT_ISSUE_CODE
							END
						  ELSE
						    BEGIN
								INSERT INTO @A_DATA
								SELECT 
									   IVR.CODE_NO AS RECEIPT_ISSUE_CODE,
									   HIS.[SPARE_PART_CODE],
									   '',
									   HIS.QUANTITY,
									   HIS.[UNIT],
									   NULL,
									   NULL,
									   NULL,
									   NULL,
									   SPT.CAUSE,
									   NULL,
									   SPT.STOCK_CODE,
									   SPT.DEPT_CODE,
									   HIS.IN_OUT as INT_OUT,
									   IVR.DATE AS [CREATE_DATE],
									   IVR.[USER_CREATE],
									   IVR.USER_SYS,
									   IVR.ORDER_CODE,
									   IVR.STATUS,
									   '' AS [TYPE_IN_OUT_CODE],
									   '',
									   SPT.[LOCATION],
									   0,
									   NULL,
									   NULL
								FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IVR 
								INNER JOIN  [dbo].[EWIP_STOCK_OUT] SPT ON IVR.CODE_NO = SPT.[STOCK_OUT_CODE]
								INNER JOIN [dbo].[EWIP_HISTORY_INVENTORY]  HIS ON IVR.CODE_NO = HIS.STOCK_IN_OUT_CODE
								WHERE IVR.CODE_NO = @A_RECEIPT_ISSUE_CODE
							END
					 END

					DELETE FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] WHERE CODE_NO = @A_RECEIPT_ISSUE_CODE
					DELETE FROM [dbo].[EWIP_SP_STOCKIN]  WHERE STOCK_IN_CODE = @A_RECEIPT_ISSUE_CODE
					DELETE FROM [dbo].[EWIP_HISTORY_INVENTORY]  WHERE STOCK_IN_OUT_CODE = @A_RECEIPT_ISSUE_CODE
					DELETE FROM [dbo].[EWIP_STOCK_OUT] WHERE [STOCK_OUT_CODE] = @A_RECEIPT_ISSUE_CODE

					-- RECACULATOR INVENTORY : Tinh lai ton kho khi insert/update/delete
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
						DECLARE @A_LOCATION NVARCHAR(max)
						DECLARE @A_QUANTITY_NG FLOAT = 0
						DECLARE @A_EXPIRED_DATE DATE
						DECLARE @A_QUANTITY_IN FLOAT = 0
						DECLARE @A_IS_INTEGRATED BIT

						--LOCATION: location_quantity_condition_expired date_in time_unit
						DECLARE @A_TMP_LOCATION NVARCHAR(200)
						DECLARE @A_TMP_L NVARCHAR(100)
						DECLARE @A_TMP_Q NVARCHAR(20)
						DECLARE @A_TMP_C NVARCHAR(50)
						DECLARE @A_TMP_EX NVARCHAR(50)
						DECLARE @A_TMP_IT NVARCHAR(50)
						DECLARE @A_TMP_UNIT NVARCHAR(20)
						DECLARE @A_CHECK int
						DECLARE @A_ISWAITE bit
					
						DECLARE cursorInventory CURSOR FOR
						SELECT [DEPT_CODE],[STOCK_CODE],[SPARE_PART_CODE],[UNIT],[CREATE_DATE],YEAR([CREATE_DATE]) AS [YEAR],MONTH([CREATE_DATE]) AS [MONTH],[USER_CREATE],[LOCATION],[QUANTITY_NG],[EXPRIRED_DATE],[QUANTITY],[IS_INTEGRATED]
						FROM @A_DATA

						OPEN cursorInventory

						FETCH NEXT FROM cursorInventory
						INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION,@A_QUANTITY_NG,@A_EXPIRED_DATE,@A_QUANTITY_IN,@A_IS_INTEGRATED

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

										  -- update so luong tai vi tri.
										  IF @A_INOUT = 'OUT'
										    BEGIN 
													DECLARE locationCursor CURSOR FOR
													select value from string_split(@A_LOCATION,',')

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

													SELECT @A_CHECK = COUNT(*)
													FROM  [dbo].[EWIP_SPAREPART_LOCATION]
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


													 IF @A_CHECK > 0
													   BEGIN
													 	UPDATE [dbo].[EWIP_SPAREPART_LOCATION]
													 	SET [QUANTITY] = [QUANTITY] + [dbo].[CONVERT_UNIT](@A_TMP_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE) * cast(@A_TMP_Q as float)
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
													 		END
													 ELSE
													 	  BEGIN
													 	        IF @A_TMP_L = '' or @A_TMP_L is null
													 				set @A_ISWAITE = 'True'
													 			ELSE
													 			    set @A_ISWAITE = 'False'
													 
													 			INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
													 			VALUES(@A_SPARE_PART_CODE,@A_TMP_L,@A_TMP_C,@A_ISWAITE,cast(@A_TMP_Q as float),@A_DEPT_CODE,@A_STOCK_CODE,'',@A_TMP_UNIT,@A_TMP_EX,@A_TMP_IT)
													 	  END
															FETCH NEXT FROM locationCursor
															INTO @A_TMP_LOCATION
														END

												CLOSE locationCursor
												DEALLOCATE locationCursor	

												DECLARE @LENDCODE1 NVARCHAR(50)
												SELECT @LENDCODE1 = [LEND_CODE] FROM [dbo].[EWIP_SPAREPART_LEND_EX] WHERE [RECEIPT_ISSUE_CODE] = @A_RECEIPT_ISSUE_CODE

												DELETE [dbo].[EWIP_SPAREPART_LEND] 
												WHERE [LEND_CODE] = @LENDCODE1

												DELETE [dbo].[EWIP_SPAREPART_LEND_EX]
												WHERE [LEND_CODE] = @LENDCODE1

											END
										  ELSE
										     BEGIN
											      IF @A_QUANTITY_NG = 0
												    BEGIN
															DECLARE @QUANTITY_IN_W3 FLOAT = 0;
															DECLARE @ID_IN_W3 INT
															DECLARE @CONDTION NVARCHAR(50)

															IF @A_IS_INTEGRATED = 'True'
															    set @CONDTION = 'INTEGRATED'
															else 
															   set @CONDTION = 'OK'

															SELECT @QUANTITY_IN_W3 = [dbo].[CONVERT_UNIT]([UNIT_ID],@A_UNIT,@A_SPARE_PART_CODE,@A_DEPT_CODE)*QUANTITY,@ID_IN_W3 =ID
															FROM [dbo].[EWIP_SPAREPART_LOCATION]
															WHERE [IS_WAITE] = 'True' AND 
															[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
															[DEPT_CODE] = @A_DEPT_CODE AND 
															[STOCK_CODE] = @A_STOCK_CODE AND
															CONDITION_CODE = @CONDTION AND
															EXPIRED_DATE = CAST(@A_EXPIRED_DATE AS DATE) AND
															TIME_IN = @A_DATE

															IF @QUANTITY_IN_W3 > 0 AND @QUANTITY_IN_W3 >= @A_QUANTITY_IN
															    BEGIN
																	UPDATE [dbo].[EWIP_SPAREPART_LOCATION]
																	SET QUANTITY = QUANTITY - @A_QUANTITY_IN * [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE)
																	WHERE ID = @ID_IN_W3

																END

                                                              DECLARE @LENDCODE NVARCHAR(50)
															  SELECT @LENDCODE = [LEND_CODE] FROM [dbo].[EWIP_SPAREPART_LEND_EX] WHERE [RECEIPT_ISSUE_CODE] = @A_RECEIPT_ISSUE_CODE

															  IF @LENDCODE IS NOT NULL AND @LENDCODE != ''
															     BEGIN
																	DECLARE @CHECK_IS_PAY FLOAT 
																	SELECT @CHECK_IS_PAY = ([QUANTITY_PAY] - @A_QUANTITY_IN * [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT],@A_SPARE_PART_CODE,@A_DEPT_CODE) - [QUANTITY])
																	FROM [dbo].[EWIP_SPAREPART_LEND]
																	WHERE [LEND_CODE] = @LENDCODE

																	IF @CHECK_IS_PAY < 0
																		BEGIN
																			UPDATE [dbo].[EWIP_SPAREPART_LEND]
																			SET [QUANTITY_PAY]=[QUANTITY_PAY] - @A_QUANTITY_IN * [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT],@A_SPARE_PART_CODE,@A_DEPT_CODE),[IS_PAY] = 'False'
																			WHERE [LEND_CODE] = @LENDCODE
																		END
																	else
																	   BEGIN
																			DELETE [dbo].[EWIP_SPAREPART_LEND] 
																			WHERE [LEND_CODE] = @LENDCODE

																			DELETE [dbo].[EWIP_SPAREPART_LEND_EX]
																			WHERE [LEND_CODE] = @LENDCODE 
																	   END
																 END
													END
												   ELSE
												      BEGIN
															DECLARE @QUANTITY_IN_W2 FLOAT = 0;
															DECLARE @QUANTITY_IN_W1_NG FLOAT = 0;
															DECLARE @ID_IN_W2 INT
															DECLARE @ID_IN_W1_NG INT

															SELECT @QUANTITY_IN_W2 = [dbo].[CONVERT_UNIT]([UNIT_ID],@A_UNIT,@A_SPARE_PART_CODE,@A_DEPT_CODE)*QUANTITY,@ID_IN_W2 =ID
															FROM [dbo].[EWIP_SPAREPART_LOCATION]
															WHERE [IS_WAITE] = 'True' AND 
															[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
															[DEPT_CODE] = @A_DEPT_CODE AND 
															[STOCK_CODE] = @A_STOCK_CODE AND
															CONDITION_CODE = 'OK' AND
															EXPIRED_DATE = CAST(@A_EXPIRED_DATE AS DATE) AND
															TIME_IN = @A_DATE

															SELECT @QUANTITY_IN_W1_NG = [dbo].[CONVERT_UNIT]([UNIT_ID],@A_UNIT,@A_SPARE_PART_CODE,@A_DEPT_CODE)*QUANTITY,@ID_IN_W1_NG =ID
															FROM [dbo].[EWIP_SPAREPART_LOCATION]
															WHERE [IS_WAITE] = 'True' AND 
															[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
															[DEPT_CODE] = @A_DEPT_CODE AND 
															[STOCK_CODE] = @A_STOCK_CODE AND
															CONDITION_CODE = 'NG' AND
															EXPIRED_DATE = CAST(@A_EXPIRED_DATE AS DATE) AND
															TIME_IN = @A_DATE
															
															IF @QUANTITY_IN_W2 > 0 AND @QUANTITY_IN_W2 >= @A_QUANTITY_IN - @A_QUANTITY_NG
															    BEGIN
																	UPDATE [dbo].[EWIP_SPAREPART_LOCATION]
																	SET QUANTITY = QUANTITY - (@A_QUANTITY_IN - @A_QUANTITY_NG)* [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE)
																	WHERE ID = @ID_IN_W2

																	IF @QUANTITY_IN_W2 = @A_QUANTITY_IN - @A_QUANTITY_NG
																	  BEGIN
																		DELETE [dbo].[EWIP_SPAREPART_LOCATION]
																		WHERE ID = @ID_IN_W2
																	  END
																END

															IF @QUANTITY_IN_W1_NG > 0 AND @QUANTITY_IN_W1_NG >= @A_QUANTITY_NG
															    BEGIN
																	UPDATE [dbo].[EWIP_SPAREPART_LOCATION]
																	SET QUANTITY = QUANTITY - @A_QUANTITY_NG* [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE)
																	WHERE ID = @ID_IN_W1_NG

																	IF  @QUANTITY_IN_W1_NG = @A_QUANTITY_NG
																	    BEGIN
																			DELETE [dbo].[EWIP_SPAREPART_LOCATION]
																			WHERE ID = @ID_IN_W1_NG
																		END
																END

													  END
											 END
									END
								
								
								SET @A_QUANTITY_NG = 0
								SET @A_QUANTITY_IN = 0

								FETCH NEXT FROM cursorInventory
								INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION,@A_QUANTITY_NG,@A_EXPIRED_DATE,@A_QUANTITY_IN,@A_IS_INTEGRATED
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