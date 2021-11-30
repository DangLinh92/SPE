SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_GOODS_RECEIPT_ISSUE@PUT](
@A_DATA   GOODS_RECEIPT_ISSUE_TYPE_DATA_TABLE READONLY,
@A_USER    NVARCHAR(50),
@A_DELIVER_RECEIVER NVARCHAR(100),
@A_RETURN_SPARE_PART_ID NVARCHAR(50),
@A_DEPARMENT NVARCHAR(50),
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
			DECLARE @CURRENT_DATE DATETIME = GETDATE();
			DECLARE @FLUX_TSF_8818HF NVARCHAR(50);

			SELECT TOP 1 @A_RECEIPT_ISSUE_CODE = [RECEIPT_ISSUE_CODE],@A_STATUS = [STATUS],@A_INOUT =[INT_OUT],@FLUX_TSF_8818HF = SPARE_PART_CODE  
			FROM @A_DATA 
			--GROUP BY [RECEIPT_ISSUE_CODE],[STATUS],[INT_OUT]

			BEGIN TRAN;
			    IF @A_RECEIPT_ISSUE_CODE = 'N'
					SET @A_RECEIPT_ISSUE_CODE = NEWID()
				ELSE
					BEGIN
						DELETE FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] WHERE CODE_NO = @A_RECEIPT_ISSUE_CODE AND DEPT_CODE = @A_DEPARMENT
						DELETE FROM [dbo].[EWIP_HISTORY_INVENTORY]  WHERE STOCK_IN_OUT_CODE = @A_RECEIPT_ISSUE_CODE AND DEPT_CODE = @A_DEPARMENT

						IF @A_INOUT = 'IN'
							DELETE FROM [dbo].[EWIP_SP_STOCKIN]  WHERE STOCK_IN_CODE = @A_RECEIPT_ISSUE_CODE AND DEPT_CODE = @A_DEPARMENT
						ELSE 
							BEGIN
								DELETE FROM [dbo].[EWIP_STOCK_OUT]  WHERE [STOCK_OUT_CODE] = @A_RECEIPT_ISSUE_CODE AND DEPT_CODE = @A_DEPARMENT
							END
					END
				  
					INSERT INTO [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING]
					SELECT @A_RECEIPT_ISSUE_CODE,[CREATE_DATE],[INT_OUT],[STOCK_CODE],[DEPT_CODE],[USER_CREATE],[USER_SYS],[ORDER_CODE],[STATUS],@A_DELIVER_RECEIVER AS [DELIVERET_RECEIVER],CONVERT(VARCHAR(8),@CURRENT_DATE,108) AS [TIME_INPUT]
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

								IF @FLUX_TSF_8818HF = 'FLUX TSF-8818HF' AND @A_USER = 'WHNP1-DB'
								   BEGIN
								         DECLARE @FLUX_LOCATION NVARCHAR(50)
										 DECLARE @FLUX_TIME_IN NVARCHAR(50)
										 DECLARE @FLUX_EX_DATE NVARCHAR(50)
										 DECLARE @LOCATION_UPDATE NVARCHAR(500)

										 IF EXISTS( SELECT * FROM EWIP_SPAREPART_LOCATION WHERE SPARE_PART_CODE = 'FLUX TSF-8818HF' AND DEPT_CODE = 'SMT')
										    BEGIN
													SELECT TOP 1 @FLUX_LOCATION = LOCATION_CODE, @FLUX_TIME_IN = TIME_IN,@FLUX_EX_DATE = EXPIRED_DATE
													FROM EWIP_SPAREPART_LOCATION
													WHERE SPARE_PART_CODE = 'FLUX TSF-8818HF' AND DEPT_CODE = 'SMT'

													IF @FLUX_LOCATION = '' SET @FLUX_LOCATION = 'W'
													SET @LOCATION_UPDATE = @FLUX_LOCATION+ '_1_OK_' + ISNULL(@FLUX_EX_DATE,'2199-01-01') + '_' + @FLUX_TIME_IN + '_EA';

													UPDATE [EWIP_STOCK_OUT]
													SET [LOCATION] = @LOCATION_UPDATE
													WHERE [STOCK_OUT_CODE] = @A_RECEIPT_ISSUE_CODE AND [DEPT_CODE] = 'SMT' AND [SPARE_PART_CODE] = 'FLUX TSF-8818HF'
										    END
								   END
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
						DECLARE @A_PO_NO NVARCHAR(50)
						DECLARE @A_UNIT_MIN NVARCHAR(50)
						DECLARE @A_PO_ID NVARCHAR(50)

						--LOCATION: location_quantity_condition_expired date_in time_unit
						DECLARE @A_TMP_LOCATION NVARCHAR(200)
						DECLARE @A_TMP_L NVARCHAR(100)
						DECLARE @A_TMP_Q NVARCHAR(20)
						DECLARE @A_TMP_C NVARCHAR(50)
						DECLARE @A_TMP_EX NVARCHAR(50)
						DECLARE @A_TMP_IT NVARCHAR(50)
						DECLARE @A_TMP_UNIT NVARCHAR(20)
						DECLARE @A_TMP_PO_NO NVARCHAR(50)
					
						DECLARE cursorInventory CURSOR FOR
						SELECT [DEPT_CODE],[STOCK_CODE],[SPARE_PART_CODE],[UNIT],[CREATE_DATE],YEAR([CREATE_DATE]) AS [YEAR],MONTH([CREATE_DATE]) AS [MONTH],
						       [USER_CREATE],[LOCATION],[PRICE_VN],[PRICE_US],[QUANTITY_NG],[EXPRIRED_DATE],[QUANTITY],[IS_INTEGRATED],[TYPE_IN_OUT_CODE],[RETURN_TIME],ORDER_CODE
						FROM @A_DATA

						OPEN cursorInventory

						FETCH NEXT FROM cursorInventory
						INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION,@A_PRICE_VN,@A_PRICE_US,@A_QUANTITY_NG,@A_EXPIRED_DATE,@A_QUANTITY_IN,@A_IS_INTEGRATED,@A_TYPE_IN_OUT,@A_RETURN_TIME,@A_PO_NO

						IF @A_USER_CREATE = '' OR @A_USER_CREATE IS NULL 
							SET @A_USER_CREATE = @A_USER

						SET @A_PO_ID = @A_PO_NO

						WHILE @@FETCH_STATUS = 0
							BEGIN

								IF(@A_DATE <= @CURRENT_DATE)
									BEGIN
										DECLARE @CountMonth int = DATEDIFF(month,@A_DATE,@CURRENT_DATE)

										WHILE @CountMonth >= 0
										  BEGIN TRY
										        DECLARE @newDate date = DATEADD(month,-@CountMonth,@CURRENT_DATE)
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

												IF @A_SPARE_PART_CODE = 'FLUX TSF-8818HF' AND @A_USER = 'WHNP1-DB'
												   BEGIN
												         DECLARE @FLUX_LOCATION1 NVARCHAR(50)
														 DECLARE @FLUX_TIME_IN1 NVARCHAR(50)
														 DECLARE @FLUX_EX_DATE1 NVARCHAR(50)

														 IF EXISTS( SELECT * FROM EWIP_SPAREPART_LOCATION WHERE SPARE_PART_CODE = 'FLUX TSF-8818HF' AND DEPT_CODE = 'SMT')
														    BEGIN
																	SELECT TOP 1 @FLUX_LOCATION1 = LOCATION_CODE, @FLUX_TIME_IN1 = TIME_IN,@FLUX_EX_DATE1 = EXPIRED_DATE
																	FROM EWIP_SPAREPART_LOCATION
																	WHERE SPARE_PART_CODE = 'FLUX TSF-8818HF' AND DEPT_CODE = 'SMT'

																	
																	IF @FLUX_LOCATION1 = '' SET @FLUX_LOCATION1 = 'W'
																	SET @A_LOCATION = @FLUX_LOCATION1+ '_1_OK_' + ISNULL(@FLUX_EX_DATE1,'2199-01-01') + '_' + @FLUX_TIME_IN1 + '_EA';
														    END
														ELSE
														   BEGIN
																SET @N_RETURN = 0;
																SET @V_RETURN = 'MSG_COM_004';
																RETURN;
														   END
												   END

													DECLARE locationCursor CURSOR FOR
													select TRIM(value) from string_split(@A_LOCATION,',') -- W_20_OK_2021-07-30,01-03_10_OK_2021-07-30 : old ->
													--new: 17-07_250_OK_2199-01-01_2021-06-30_EA,17-07_250_NG_2199-01-01_2021-07-20_EA,W_99.99999_OK_2199-01-01_2021-06-30_EA
													-- W_1_OK_2199-01-01_2021-06-30_PACK
													-- location_quantity_condition_expired date_in time_unit
													-- location_quantity_condition_expired date_in time_unit_poNo : NEW 29-08-2021
													 
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
																SET @A_TMP_IT = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX) + 2,
																                                          CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX) - 2)

																IF (LEN(@A_TMP_LOCATION) - LEN(REPLACE(@A_TMP_LOCATION, '_', ''))) = 5
																   BEGIN
																		SET @A_TMP_UNIT = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) + 2,LEN(@A_TMP_LOCATION) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) - 1)
																		SET @A_TMP_PO_NO = ''
																   END
																ELSE
																   BEGIN
																		SET @A_TMP_UNIT = SUBSTRING(@A_TMP_LOCATION,
																		                           LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) + 2,
																								   CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) - 2)

																		SET @A_TMP_PO_NO = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT + '_' + @A_TMP_UNIT) + 2,LEN(@A_TMP_LOCATION) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT + '_' + @A_TMP_UNIT) - 1)
																   END

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
																	[EXPIRED_DATE] = CAST(@A_TMP_EX AS date) AND TIME_IN = CAST(@A_TMP_IT AS date) AND CONDITION_CODE = @A_TMP_C AND ISNULL(PO_NO,'') = ISNULL(@A_TMP_PO_NO,'')

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
																	[EXPIRED_DATE] = CAST(@A_TMP_EX AS date) AND TIME_IN = CAST(@A_TMP_IT AS date) AND CONDITION_CODE = @A_TMP_C AND ISNULL(PO_NO,'') = ISNULL(@A_TMP_PO_NO,'')

																	
																	INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION]
																	VALUES(@A_SPARE_PART_CODE,@A_TMP_L,'OUT',@A_TMP_C,cast(@A_TMP_Q as float),@A_DEPT_CODE,@A_STOCK_CODE,@A_TMP_UNIT,CAST(@A_TMP_EX AS date),CAST(@A_TMP_IT AS date),@CURRENT_DATE,@A_USER,ISNULL(@A_TMP_PO_NO,''))

																	
																	IF @A_TYPE_IN_OUT = '3' -- XUAT TRA LAI
																	  BEGIN
																		 INSERT INTO [dbo].[EWIP_SPAREPART_LEND]
																		 VALUES(@A_SPARE_PART_CODE,@CURRENT_DATE,cast(@A_TMP_Q as float),@A_TMP_UNIT,CAST(@A_RETURN_TIME AS date),NULL,@A_USER,NULL,NULL,@A_DEPT_CODE,'False',0,@A_RETURN_SPARE_PART_ID);

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
																			     [DATE_PAY_ACTUAL] = @CURRENT_DATE,[USER_UPDATE] = @A_USER,[DATE_UPDATE] = @CURRENT_DATE,[IS_PAY] = @ISPAY
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
															TIME_IN = @A_DATE AND
														 	ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'') 

															IF @QUANTITY_IN_W4 = 0
																INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
																VALUES(@A_SPARE_PART_CODE,'',@CONDTION,'True',@A_QUANTITY_IN,@A_DEPT_CODE,@A_STOCK_CODE,NULL,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,ISNULL(@A_PO_NO,''))
															ELSE
															     UPDATE  [dbo].[EWIP_SPAREPART_LOCATION]
																 SET QUANTITY = QUANTITY + @A_QUANTITY_IN * [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE)
																 WHERE ID = @ID_IN_W4 

															INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION]
															VALUES(@A_SPARE_PART_CODE,'IN','',@CONDTION,@A_QUANTITY_IN,@A_DEPT_CODE,@A_STOCK_CODE,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,@CURRENT_DATE,@A_USER,ISNULL(@A_PO_NO,''))
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
																	 TIME_IN = @A_DATE AND
																	 ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'') 
																    
																	IF @QUANTITY_IN_W3 = 0
																		INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
																		VALUES(@A_SPARE_PART_CODE,'','OK','True',@QUANTITY_OKE,@A_DEPT_CODE,@A_STOCK_CODE,NULL,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,ISNULL(@A_PO_NO,''))
																	ELSE
																		UPDATE  [dbo].[EWIP_SPAREPART_LOCATION]
																		SET QUANTITY = QUANTITY + @QUANTITY_OKE * [dbo].[CONVERT_UNIT](@A_UNIT,[UNIT_ID],@A_SPARE_PART_CODE,@A_DEPT_CODE)
																		WHERE ID = @ID_IN_W3 

																	INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION]
																	VALUES(@A_SPARE_PART_CODE,'IN','','OK',@QUANTITY_OKE,@A_DEPT_CODE,@A_STOCK_CODE,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,@CURRENT_DATE,@A_USER,ISNULL(@A_PO_NO,''))

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
																				TIME_IN = @A_DATE AND  
																				ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'') 

																				INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION]
																				VALUES(@A_SPARE_PART_CODE,'IN','','NG',@A_QUANTITY_NG,@A_DEPT_CODE,@A_STOCK_CODE,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,@CURRENT_DATE,@A_USER,ISNULL(@A_PO_NO,''))

																				IF @QUANTITY_IN_W1_NG = 0
																					INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
																					VALUES(@A_SPARE_PART_CODE,'','NG','True',@A_QUANTITY_NG,@A_DEPT_CODE,@A_STOCK_CODE,NULL,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,ISNULL(@A_PO_NO,''))
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
																				TIME_IN = @A_DATE AND 
																				ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'') 

																				IF @QUANTITY_IN_W2_NG = 0
																					INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION]
																					VALUES(@A_SPARE_PART_CODE,'','NG','True',@A_QUANTITY_NG,@A_DEPT_CODE,@A_STOCK_CODE,NULL,@A_UNIT,@A_EXPIRED_DATE,@A_DATE,ISNULL(@A_PO_NO,''))
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
								INTO @A_DEPT_CODE,@A_STOCK_CODE,@A_SPARE_PART_CODE,@A_UNIT,@A_DATE,@A_YEAR,@A_MONTH,@A_USER_CREATE,@A_LOCATION,@A_PRICE_VN,@A_PRICE_US,@A_QUANTITY_NG,@A_EXPIRED_DATE,@A_QUANTITY_IN,@A_IS_INTEGRATED,@A_TYPE_IN_OUT,@A_RETURN_TIME,@A_PO_NO
							END

					CLOSE cursorInventory
					DEALLOCATE cursorInventory

					  IF @A_INOUT = 'IN' AND @A_PO_NO IS NOT NULL AND @A_PO_NO != ''
					    BEGIN
					    -- update status when in 
					        DECLARE @SPARE_PART_CODE_CHECK NVARCHAR(50)
							DECLARE @DEPT_CODE_CHECK NVARCHAR(50)
							DECLARE @QUANTITY_CHECK FLOAT
							DECLARE @UNIT_CHECK NVARCHAR(50) = 'PACK'
							DECLARE @TOTAL1 FLOAT = 0
							DECLARE @TOTAL2 FLOAT = 0
							DECLARE @STATUS_COMPLETE NVARCHAR(50) = 'COMPLETE'
                                            
                            DECLARE checkPOCursor CURSOR FAST_FORWARD READ_ONLY LOCAL FOR
                            SELECT HIS.SPARE_PART_CODE,HIS.DEPT_CODE,SUM(ISNULL(HIS.QUANTITY,0)*dbo.CONVERT_UNIT(HIS.[UNIT],'PACK',HIS.SPARE_PART_CODE,HIS.DEPT_CODE))
                            FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR
							INNER JOIN [dbo].[EWIP_HISTORY_INVENTORY] HIS ON IDR.CODE_NO = HIS.STOCK_IN_OUT_CODE AND HIS.DEPT_CODE = IDR.DEPT_CODE
							WHERE IDR.ORDER_CODE = @A_PO_ID
							GROUP BY HIS.DEPT_CODE,HIS.SPARE_PART_CODE
                           
                            OPEN checkPOCursor
                            FETCH NEXT FROM checkPOCursor INTO @SPARE_PART_CODE_CHECK,@DEPT_CODE_CHECK,@QUANTITY_CHECK
                           
                             WHILE @@FETCH_STATUS = 0 BEGIN

								SELECT TOP 1 @A_UNIT_MIN = [UNIT_CODE_MIN] 
								FROM [dbo].[EWIP_SPAREPART_UNIT] 
								WHERE SPARE_PART_CODE = @SPARE_PART_CODE_CHECK AND DEPT_CODE = @DEPT_CODE_CHECK

								SELECT @TOTAL2 = SUM(ISNULL(eprd.QUANTITY_NEED_BUY,0) * dbo.CONVERT_UNIT(eprd.UNIT,@A_UNIT_MIN,@SPARE_PART_CODE_CHECK,@DEPT_CODE_CHECK))
								FROM EWIP_PURCHASE_REQUEST_DETAIL eprd
								INNER JOIN EWIP_ORDER_PR eop ON eprd.PR_CODE = EOP.PR_CODE AND eprd.DEPT_CODE = EOP.DEPT_CODE
								WHERE EOP.DEPT_CODE = @DEPT_CODE_CHECK AND EOP.PO_ID = @A_PO_ID AND eprd.SPAREPART_CODE = @SPARE_PART_CODE_CHECK
                             	
								SET @TOTAL1 =  @QUANTITY_CHECK * dbo.CONVERT_UNIT('PACK',@A_UNIT_MIN,@SPARE_PART_CODE_CHECK,@DEPT_CODE_CHECK)

								 IF @TOTAL2 <= @TOTAL1 AND @TOTAL1 > 0
								       BEGIN
											UPDATE EWIP_MRP
											SET STATUS = @STATUS_COMPLETE
											WHERE SPAREPART_CODE = @SPARE_PART_CODE_CHECK AND DEPT_CODE = @DEPT_CODE_CHECK AND STATUS != 'CANCEL'
											    AND MRP_CODE IN (SELECT eprd.MRP_CODE 
												                    FROM EWIP_PURCHASE_REQUEST_DETAIL eprd
																	    INNER JOIN EWIP_ORDER_PR eop ON eprd.PR_CODE = EOP.PR_CODE AND eprd.DEPT_CODE = EOP.DEPT_CODE
																    WHERE EOP.DEPT_CODE = @DEPT_CODE_CHECK AND EOP.PO_ID = @A_PO_ID)

										    UPDATE EWIP_PURCHASE_REQUEST_DETAIL
											SET STATUS = @STATUS_COMPLETE
											WHERE SPAREPART_CODE = @SPARE_PART_CODE_CHECK AND DEPT_CODE = @DEPT_CODE_CHECK AND 
											      STATUS != 'CANCEL' AND PR_CODE IN (SELECT eop.PR_CODE FROM EWIP_ORDER_PR eop WHERE eop.PO_ID = @A_PO_ID)

											IF NOT EXISTS(SELECT TOP 1 *
														FROM EWIP_MRP em 
														WHERE em.DEPT_CODE = @DEPT_CODE_CHECK AND em.STATUS != @STATUS_COMPLETE AND 
																 MRP_CODE IN (SELECT eprd.MRP_CODE 
																				FROM EWIP_PURCHASE_REQUEST_DETAIL eprd
																					INNER JOIN EWIP_ORDER_PR eop ON eprd.PR_CODE = EOP.PR_CODE AND eprd.DEPT_CODE = EOP.DEPT_CODE
																				WHERE EOP.DEPT_CODE = @DEPT_CODE_CHECK AND EOP.PO_ID = @A_PO_ID))
												BEGIN
														    UPDATE EWIP_MRP_LIST
															SET STATUS = @STATUS_COMPLETE
															WHERE DEPT_CODE = @DEPT_CODE_CHECK AND STATUS != 'CANCEL' AND MRP_CODE IN (SELECT eprd.MRP_CODE 
																                    FROM EWIP_PURCHASE_REQUEST_DETAIL eprd
																					    INNER JOIN EWIP_ORDER_PR eop ON eprd.PR_CODE = EOP.PR_CODE AND eprd.DEPT_CODE = EOP.DEPT_CODE
																				    WHERE EOP.DEPT_CODE = @DEPT_CODE_CHECK AND EOP.PO_ID = @A_PO_ID) 

														   UPDATE EWIP_PURCHASE_REQUEST
														   SET PR_STATUS = @STATUS_COMPLETE
														   WHERE DEPT_CODE = @A_DEPT_CODE AND PR_STATUS != 'CANCEL' AND PR_CODE IN (SELECT eop.PR_CODE FROM EWIP_ORDER_PR eop WHERE eop.PO_ID = @A_PO_ID)

														   UPDATE EWIP_ORDER_PR
														   SET STATUS = @STATUS_COMPLETE
														   WHERE DEPT_CODE = @A_DEPT_CODE AND STATUS != 'CANCEL' AND PO_ID = @A_PO_ID
												END
									   END
                             
                             	 FETCH NEXT FROM checkPOCursor INTO @SPARE_PART_CODE_CHECK,@DEPT_CODE_CHECK,@QUANTITY_CHECK
                             END
                             
                             CLOSE checkPOCursor
                             DEALLOCATE checkPOCursor

							 IF NOT EXISTS(SELECT TOP 1 *
										FROM EWIP_PURCHASE_REQUEST epr 
										 WHERE epr.PR_CODE IN (SELECT eop.PR_CODE FROM EWIP_ORDER_PR eop WHERE eop.PO_ID = @A_PO_ID) AND epr.PR_STATUS != @STATUS_COMPLETE)
								BEGIN
										UPDATE EWIP_ORDER
										SET STATUS = @STATUS_COMPLETE
										WHERE PO_ID = @A_PO_ID
								END
						END
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
