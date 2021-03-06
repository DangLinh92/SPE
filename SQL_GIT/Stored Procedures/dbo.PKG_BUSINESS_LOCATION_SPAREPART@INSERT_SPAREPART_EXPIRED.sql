SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@INSERT_SPAREPART_EXPIRED](
@A_STT        INT,
@A_SPARE_PART_CODE NVARCHAR(50),
@A_LOCATION        NVARCHAR(50),
@A_CONDITION       VARCHAR(50),
@A_ISWATE          BIT,
@A_QUANTITY        FLOAT,
@A_DEPART_MENT     NVARCHAR(50),
@A_STOCK           VARCHAR(50),
@A_BARCODE         NVARCHAR(100),
@A_UNIT            VARCHAR(20),
@A_EXPIRED_DATE    NVARCHAR(50),
@A_TIME_IN         NVARCHAR(50),
@A_PO_NO           NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK int;
			DECLARE @CHECK1 int;
			DECLARE @STT INT;
			DECLARE @IS_WAITE BIT;
			DECLARE @QUANTITY INT;
			DECLARE @UNIT_OLD VARCHAR(20)

			BEGIN TRAN
			SELECT @CHECK = COUNT(*) 
			FROM [EWIP_SPAREPART_LOCATION] 
			WHERE ID = @A_STT

			SELECT @CHECK1 = COUNT(*) 
			FROM [EWIP_SPAREPART_LOCATION] 
			WHERE
				ISNULL(LOCATION_CODE,'') = ISNULL(@A_LOCATION,'')
				AND SPARE_PART_CODE = @A_SPARE_PART_CODE
				AND UNIT_ID = @A_UNIT 
				AND CONDITION_CODE = @A_CONDITION
				AND DEPT_CODE =@A_DEPART_MENT 
				AND STOCK_CODE = @A_STOCK
				AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date)
				AND [TIME_IN] = CAST(@A_TIME_IN as date)
				AND ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')

			IF @CHECK > 0 
			   BEGIN
			     SELECT @IS_WAITE = IS_WAITE,@QUANTITY = QUANTITY,@UNIT_OLD = UNIT_ID FROM [EWIP_SPAREPART_LOCATION] WHERE ID = @A_STT

				 IF @IS_WAITE = 'False' -- DA CO VI TRI
				       BEGIN
							IF @A_ISWATE = 'True' -- chuyen tu rack ra vi tri wait
							  BEGIN
									IF @A_QUANTITY >= @QUANTITY * [dbo].[CONVERT_UNIT](@UNIT_OLD,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) -- CHUYEN TOAN BO
										BEGIN
											DECLARE @Check4 int
											SELECT @Check4 = COUNT(*) 
											FROM [EWIP_SPAREPART_LOCATION]  
											WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND 
											       STOCK_CODE = @A_STOCK AND
												   IS_WAITE = 'True' AND 
												   CONDITION_CODE = @A_CONDITION AND 
												   [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND 
												   [TIME_IN] = CAST(@A_TIME_IN as date) AND
												    ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')

											IF @Check4 > 0
											  BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION]
													SET
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														QUANTITY= QUANTITY * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT)+@A_QUANTITY,
														BARCODE = @A_BARCODE
													WHERE 
														DEPT_CODE = @A_DEPART_MENT AND 
														SPARE_PART_CODE = @A_SPARE_PART_CODE AND 
														STOCK_CODE = @A_STOCK AND 
														IS_WAITE = 'True' AND 
														CONDITION_CODE = @A_CONDITION AND 
														[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND 
														[TIME_IN] = CAST(@A_TIME_IN as date) AND
														ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')

														DELETE FROM [EWIP_SPAREPART_LOCATION]  WHERE ID = @A_STT
											  END
											ELSE
											   BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION] 
													SET
													    LOCATION_CODE = ISNULL(@A_LOCATION,''),
														CONDITION_CODE = @A_CONDITION,
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														BARCODE=@A_BARCODE,
														QUANTITY= QUANTITY * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT),
														[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date),
														[TIME_IN] = CAST(@A_TIME_IN as date),
														PO_NO = ISNULL(@A_PO_NO,'')
													WHERE ID = @A_STT
												END
										END
									ELSE
									  BEGIN
										   -- chuyen 1 phan
										  -- update cho vi tri hien tai
											UPDATE [EWIP_SPAREPART_LOCATION]
											SET    QUANTITY = QUANTITY*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) - @A_QUANTITY,
												   UNIT_ID = @A_UNIT
											WHERE ID = @A_STT
											-- insert vao vi tri waite

											DECLARE @Check5 int
											SELECT @Check5 = COUNT(*) 
											FROM [EWIP_SPAREPART_LOCATION] 
											WHERE 
											   DEPT_CODE = @A_DEPART_MENT AND 
											   SPARE_PART_CODE = @A_SPARE_PART_CODE AND 
											   STOCK_CODE = @A_STOCK AND 
											   IS_WAITE = 'True' AND 
											   CONDITION_CODE = @A_CONDITION AND 
											   [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND 
											   [TIME_IN] = CAST(@A_TIME_IN as date) AND
											   ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')

											IF @Check5 > 0
												BEGIN
														UPDATE [EWIP_SPAREPART_LOCATION]
														SET    QUANTITY = QUANTITY*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) + @A_QUANTITY,
																UNIT_ID = @A_UNIT
														WHERE 
														DEPT_CODE = @A_DEPART_MENT AND
														STOCK_CODE = @A_STOCK AND 
														SPARE_PART_CODE = @A_SPARE_PART_CODE AND
														IS_WAITE = 'True' AND 
														CONDITION_CODE = @A_CONDITION AND
														[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND
														[TIME_IN] = CAST(@A_TIME_IN as date) AND
														ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')
												END
											ELSE
												BEGIN
													INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION](SPARE_PART_CODE,LOCATION_CODE,CONDITION_CODE,IS_WAITE,QUANTITY,DEPT_CODE,STOCK_CODE,BARCODE,UNIT_ID,[EXPIRED_DATE],TIME_IN,PO_NO)
													VALUES(@A_SPARE_PART_CODE,ISNULL(@A_LOCATION,''),@A_CONDITION,@A_ISWATE,@A_QUANTITY,@A_DEPART_MENT,@A_STOCK,@A_BARCODE,@A_UNIT, CAST(@A_EXPIRED_DATE AS date),CAST(@A_TIME_IN as date),ISNULL(@A_PO_NO,''))
												END
									  END

							  END
							ELSE
							   BEGIN
									 -- SUA VI TRI,UPDATE THONG TIN 
									  UPDATE [EWIP_SPAREPART_LOCATION]
										SET [LOCATION_CODE]= ISNULL(@A_LOCATION,''),[SPARE_PART_CODE] =@A_SPARE_PART_CODE ,
										[CONDITION_CODE] =@A_CONDITION, [IS_WAITE] = @A_ISWATE,
										[QUANTITY] = @A_QUANTITY,UNIT_ID = @A_UNIT,BARCODE=@A_BARCODE,
										[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) ,
										[TIME_IN] = CAST(@A_TIME_IN as date),
										PO_NO = ISNULL(@A_PO_NO,'')
										WHERE ID = @A_STT
							  END
						END
				 ELSE -- UPDATE FOR SPARE PART IS WAITE
				      BEGIN
							IF @A_LOCATION <> '' AND @A_LOCATION IS NOT NULL
								BEGIN
								      -- chuyen tu vi tri wait ra vi tri rack
								      IF @A_QUANTITY >= @QUANTITY * [dbo].[CONVERT_UNIT](@UNIT_OLD,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) -- chuyen toan bo
									   BEGIN
											DECLARE @Check3 int
											SELECT @Check3 = COUNT(*) 
											FROM [EWIP_SPAREPART_LOCATION] 
											WHERE 
											   DEPT_CODE = @A_DEPART_MENT AND 
											   STOCK_CODE = @A_STOCK AND 
											   SPARE_PART_CODE = @A_SPARE_PART_CODE AND 
											   ISNULL(LOCATION_CODE,'') = ISNULL(@A_LOCATION,'') AND 
											   CONDITION_CODE = @A_CONDITION AND 
											   [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND 
											   [TIME_IN] = CAST(@A_TIME_IN as date) AND
											   ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')

											IF @Check3 > 0
											  BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION]
													SET
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														QUANTITY= ISNULL(QUANTITY,0) * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT)+@A_QUANTITY
													WHERE 
														DEPT_CODE = @A_DEPART_MENT AND 
														STOCK_CODE = @A_STOCK AND 
														SPARE_PART_CODE = @A_SPARE_PART_CODE AND 
														ISNULL(LOCATION_CODE,'') = ISNULL(@A_LOCATION,'') AND 
														CONDITION_CODE = @A_CONDITION AND 
														[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND 
														[TIME_IN] = CAST(@A_TIME_IN as date) AND
														ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')

													DELETE FROM [EWIP_SPAREPART_LOCATION]  WHERE ID = @A_STT
											  END
											ELSE
											   BEGIN
													UPDATE [EWIP_SPAREPART_LOCATION]
													SET
													    LOCATION_CODE = ISNULL(@A_LOCATION,''),
														CONDITION_CODE = @A_CONDITION,
														[IS_WAITE] = @A_ISWATE,
														UNIT_ID = @A_UNIT,
														BARCODE=@A_BARCODE,
														QUANTITY= ISNULL(QUANTITY,0) * [dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT),
														[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date),
														[TIME_IN] = CAST(@A_TIME_IN as date),
														PO_NO = ISNULL(@A_PO_NO,'')
													WHERE ID = @A_STT
												END
										 END
									  ELSE
									     BEGIN
										  -- chuyen 1 phan
										  -- update cho vi tri wait
											UPDATE [EWIP_SPAREPART_LOCATION]
											SET    QUANTITY = ISNULL(QUANTITY,0)*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) - @A_QUANTITY,
												   UNIT_ID = @A_UNIT,
												   [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date),
												   [TIME_IN] = CAST(@A_TIME_IN as date),
												    PO_NO = ISNULL(@A_PO_NO,'')
											WHERE ID = @A_STT
											-- insert vao rack

											DECLARE @Check2 int
											SELECT @Check2 = COUNT(*) 
											FROM [EWIP_SPAREPART_LOCATION] 
											WHERE DEPT_CODE = @A_DEPART_MENT AND 
												STOCK_CODE = @A_STOCK AND 
												SPARE_PART_CODE = @A_SPARE_PART_CODE AND
												ISNULL(LOCATION_CODE,'') = ISNULL(@A_LOCATION,'') AND 
												CONDITION_CODE = @A_CONDITION AND
												[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND 
												[TIME_IN] = CAST(@A_TIME_IN as date) AND
												ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')

											IF @Check2 > 0
												BEGIN
														UPDATE [EWIP_SPAREPART_LOCATION]
														SET    QUANTITY = ISNULL(QUANTITY,0)*[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPART_MENT) + @A_QUANTITY,
																UNIT_ID = @A_UNIT
														WHERE 
														DEPT_CODE = @A_DEPART_MENT AND 
														STOCK_CODE = @A_STOCK AND 
														SPARE_PART_CODE = @A_SPARE_PART_CODE AND 
														ISNULL(LOCATION_CODE,'') = ISNULL(@A_LOCATION,'') AND 
														CONDITION_CODE = @A_CONDITION AND 
														[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) AND 
														[TIME_IN] = CAST(@A_TIME_IN as date) AND
														ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')
												END
											ELSE
												BEGIN
													INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION](SPARE_PART_CODE,LOCATION_CODE,CONDITION_CODE,IS_WAITE,QUANTITY,DEPT_CODE,STOCK_CODE,BARCODE,UNIT_ID,[EXPIRED_DATE],TIME_IN,PO_NO)
													VALUES(@A_SPARE_PART_CODE,ISNULL(@A_LOCATION,''),@A_CONDITION,@A_ISWATE,@A_QUANTITY,@A_DEPART_MENT,@A_STOCK,@A_BARCODE,@A_UNIT, CAST(@A_EXPIRED_DATE AS date),CAST(@A_TIME_IN as date),ISNULL(@A_PO_NO,''))
												END
                                         END
								END
							ELSE
									UPDATE [EWIP_SPAREPART_LOCATION]
									SET 
										[LOCATION_CODE]= ISNULL(@A_LOCATION,''),[SPARE_PART_CODE] =@A_SPARE_PART_CODE ,
										[CONDITION_CODE] =@A_CONDITION, [IS_WAITE] = @A_ISWATE,
										[QUANTITY] = @A_QUANTITY,UNIT_ID = @A_UNIT,
										BARCODE=@A_BARCODE,[EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date),
										[TIME_IN] = CAST(@A_TIME_IN as date),
										PO_NO =  ISNULL(@A_PO_NO,'')
									WHERE ID = @A_STT
				   END
			    END
			ELSE 
			    IF @CHECK1 > 0
				   BEGIN
						SELECT @STT = ID 
						FROM [EWIP_SPAREPART_LOCATION] 
						WHERE ISNULL(LOCATION_CODE,'') = ISNULL(@A_LOCATION,'')
								AND SPARE_PART_CODE = @A_SPARE_PART_CODE
								AND UNIT_ID = @A_UNIT 
								AND CONDITION_CODE = @A_CONDITION
								AND DEPT_CODE =@A_DEPART_MENT 
								AND STOCK_CODE = @A_STOCK
								AND [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date)
								AND [TIME_IN] = CAST(@A_TIME_IN as date)
								AND ISNULL(PO_NO,'') = ISNULL(@A_PO_NO,'')

						IF @STT  <> '' AND @STT IS NOT NULL
							UPDATE [EWIP_SPAREPART_LOCATION]
							SET 
								[LOCATION_CODE]= ISNULL(@A_LOCATION,''),[SPARE_PART_CODE] =@A_SPARE_PART_CODE ,
								[CONDITION_CODE] =@A_CONDITION, [IS_WAITE] = @A_ISWATE,[QUANTITY] = @A_QUANTITY,
								UNIT_ID = @A_UNIT,BARCODE=@A_BARCODE, [EXPIRED_DATE] = CAST(@A_EXPIRED_DATE AS date) ,
								[TIME_IN] = CAST(@A_TIME_IN as date),
								PO_NO =ISNULL(@A_PO_NO,'')
							WHERE ID = @STT;
					END				
				ELSE
			        INSERT INTO [dbo].[EWIP_SPAREPART_LOCATION](SPARE_PART_CODE,LOCATION_CODE,CONDITION_CODE,IS_WAITE,QUANTITY,DEPT_CODE,STOCK_CODE,BARCODE,UNIT_ID,[EXPIRED_DATE],TIME_IN,PO_NO)
				    VALUES(@A_SPARE_PART_CODE,ISNULL(@A_LOCATION,''),@A_CONDITION,@A_ISWATE,@A_QUANTITY,@A_DEPART_MENT,@A_STOCK,@A_BARCODE,@A_UNIT,CAST(@A_EXPIRED_DATE AS date),CAST(@A_TIME_IN as date),ISNULL(@A_PO_NO,''))
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRAN
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  ROLLBACK TRAN
END CATCH
GO
