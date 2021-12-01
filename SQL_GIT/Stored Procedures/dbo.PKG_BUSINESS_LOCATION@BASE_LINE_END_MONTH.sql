SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION@BASE_LINE_END_MONTH]
AS
BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @A_DEPARTMENT    NVARCHAR(100)
			DECLARE @A_STOCK          NVARCHAR(50)
			DECLARE @SPARE_PART_CODE NVARCHAR(50)
			DECLARE @N_RETURN	int	
			DECLARE @V_RETURN	NVARCHAR(4000)
			DECLARE @A_DATE DATE
			DECLARE @A_YEAR INT
			DECLARE @A_MONTH int

			SET @A_DATE = DATEADD(DAY,-1,GETDATE())
			SET @A_YEAR = YEAR(@A_DATE)
			SET @A_MONTH = MONTH(@A_DATE)

			DECLARE cursorDept3 CURSOR LOCAL FOR
			SELECT [CODE] FROM [dbo].[ESYSMSTDEPT]

			OPEN cursorDept3

			FETCH NEXT FROM cursorDept3
			INTO @A_DEPARTMENT

			WHILE @@FETCH_STATUS = 0
				BEGIN
					 PRINT @A_DEPARTMENT 
					 DECLARE cursorStock CURSOR LOCAL FOR
					 SELECT [CODE] FROM [dbo].[EWIP_STOCK] WHERE [DEPT_CODE] = @A_DEPARTMENT

					 OPEN cursorStock

					 FETCH NEXT FROM cursorStock
					 INTO @A_STOCK

					 WHILE @@FETCH_STATUS = 0
					    BEGIN						
							  	DELETE FROM [dbo].[EWIP_SPARE_PART_LOCATION_BASE_LINE]
								WHERE [MONTH_BASE_LINE] = @A_MONTH AND [YEAR_BASE_LINE] = @A_YEAR AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

								INSERT INTO [dbo].[EWIP_SPARE_PART_LOCATION_BASE_LINE]
								SELECT [SPARE_PART_CODE],[LOCATION_CODE],[CONDITION_CODE],[IS_WAITE],[QUANTITY],[DEPT_CODE], 
								       [STOCK_CODE],[UNIT_ID],[EXPIRED_DATE],[TIME_IN],[PO_NO],
								        @A_DATE,@A_MONTH,@A_YEAR,SYSDATETIME()
								FROM [dbo].[EWIP_SPAREPART_LOCATION]
								WHERE DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK
								
								IF CAST(DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0) AS date) = CAST(GETDATE() AS DATE)
								   BEGIN
										 	IF NOT EXISTS (SELECT * FROM [EWIP_SPARE_PART_LOCATION_BASE_LINE] WHERE [MONTH_BASE_LINE] = MONTH(GETDATE()) AND [YEAR_BASE_LINE] = YEAR(GETDATE()) AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK)
													INSERT INTO [dbo].[EWIP_SPARE_PART_LOCATION_BASE_LINE]
													SELECT [SPARE_PART_CODE],[LOCATION_CODE],[CONDITION_CODE],[IS_WAITE],[QUANTITY],[DEPT_CODE], 
													       [STOCK_CODE],[UNIT_ID],[EXPIRED_DATE],[TIME_IN],[PO_NO],
													        GETDATE(),MONTH(GETDATE()), YEAR(GETDATE()),SYSDATETIME()
													FROM [dbo].[EWIP_SPAREPART_LOCATION]
													WHERE DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK
								   END

								INSERT INTO [dbo].[EWIP_SPARE_PART_LOCATION_BASE_LINE_HISTORY]
								SELECT [SPARE_PART_CODE],[LOCATION_CODE],[CONDITION_CODE],[IS_WAITE],[QUANTITY],[DEPT_CODE], 
								       [STOCK_CODE],[UNIT_ID],[EXPIRED_DATE],[TIME_IN],[PO_NO],
								        @A_DATE,@A_MONTH,@A_YEAR,SYSDATETIME()
								FROM [dbo].[EWIP_SPAREPART_LOCATION]
								WHERE DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

								DECLARE cursorSparepart CURSOR LOCAL FOR
								SELECT [CODE] FROM [dbo].[EWIP_SPARE_PART] WHERE [SP_DEPT_CODE] = @A_DEPARTMENT
							  
								OPEN cursorSparepart

								FETCH NEXT FROM cursorSparepart
								INTO @SPARE_PART_CODE

								WHILE @@FETCH_STATUS = 0
							  	  BEGIN

								  -- LUU NHAP XUAT TON THEO NGAY
                                           EXEC [dbo].[PKG_BUSINESS_BASE_LINE_QTY_VALUE_BY_DAY_SPARE_PART@CALL]
												@A_DEPARTMENT	= @A_DEPARTMENT,
												@A_STOCK         = @A_STOCK,
												@A_SPARE_PART_CODE = @SPARE_PART_CODE,
												@A_DATE			 = @A_DATE,
												@N_RETURN = @N_RETURN	OUTPUT,
												@V_RETURN =@V_RETURN	OUTPUT

										IF @N_RETURN <> 0 
										   BEGIN
																	EXEC msdb.dbo.sp_send_dbmail 
																		 @profile_name = 'sparepart mail',  
																		 @recipients='whcpi1@wisol.co.kr',  
																		 @subject = 'BASE_LINE_END_MONTH-PKG_BUSINESS_BASE_LINE_QTY_VALUE_BY_DAY_SPARE_PART.CALL',  
																		 @body = @V_RETURN 
                                           end

								  --- LUU GIA TRI NHAP XUAT TON THEO THANG
										EXEC [dbo].[PKG_BUSINESS_BASE_LINE_VALUE_BY_SPARE_PART@CALL]
										      @A_DEPARTMENT = @A_DEPARTMENT,
											  @A_STOCK = @A_STOCK,
											  @A_SPARE_PART_CODE = @SPARE_PART_CODE,
											  @A_DATE = @A_DATE,
											  @A_YEAR = @A_YEAR,
											  @A_MONTH = @A_MONTH,
											  @N_RETURN = @N_RETURN	OUTPUT,
											  @V_RETURN =@V_RETURN	OUTPUT

										IF @N_RETURN <> 0 
										   BEGIN
												EXEC msdb.dbo.sp_send_dbmail 
																		 @profile_name = 'sparepart mail',  
																		 @recipients='whcpi1@wisol.co.kr',  
																		 @subject = 'BASE_LINE_END_MONTH-PKG_PKG_BUSINESS_BASE_LINE_VALUE_BY_SPARE_PART.CALL',  
																		 @body = @V_RETURN 
                                           end

										FETCH NEXT FROM cursorSparepart
										INTO @SPARE_PART_CODE
								   END
								   CLOSE cursorSparepart
								  DEALLOCATE cursorSparepart

								FETCH NEXT FROM cursorStock
								INTO @A_STOCK
						END

						CLOSE cursorStock
						DEALLOCATE cursorStock

					 FETCH NEXT FROM cursorDept3
					INTO @A_DEPARTMENT
				END

			CLOSE cursorDept3
			DEALLOCATE cursorDept3
		END
END TRY
	BEGIN CATCH
END CATCH
GO
