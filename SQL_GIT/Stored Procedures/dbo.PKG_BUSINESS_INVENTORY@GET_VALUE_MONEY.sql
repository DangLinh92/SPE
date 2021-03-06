SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY@GET_VALUE_MONEY]
@A_DATE_GET NVARCHAR(50),
@A_DEPARTMENT    NVARCHAR(100),
@A_STOCK          NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
AS
BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
		
			DECLARE @SPARE_PART_CODE NVARCHAR(50)
			DECLARE @A_DATE DATE
			DECLARE @A_YEAR INT
			DECLARE @A_MONTH int

			SET @A_DATE = CAST(@A_DATE_GET AS DATE)--GETDATE()
			SET @A_YEAR = YEAR(@A_DATE)
			SET @A_MONTH = MONTH(@A_DATE)

			BEGIN TRAN
				
				             IF @A_MONTH = MONTH(GETDATE()) AND @A_YEAR = YEAR(GETDATE())
							   BEGIN
							  		DELETE FROM [dbo].[EWIP_SPARE_PART_LOCATION_BASE_LINE]
									WHERE [MONTH_BASE_LINE] = @A_MONTH AND [YEAR_BASE_LINE] = @A_YEAR AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

									INSERT INTO [dbo].[EWIP_SPARE_PART_LOCATION_BASE_LINE]
									SELECT [SPARE_PART_CODE],[LOCATION_CODE],[CONDITION_CODE],[IS_WAITE],[QUANTITY],[DEPT_CODE], 
									       [STOCK_CODE],[UNIT_ID],[EXPIRED_DATE],[TIME_IN],[PO_NO],
									        @A_DATE,@A_MONTH,@A_YEAR,SYSDATETIME()
									FROM [dbo].[EWIP_SPAREPART_LOCATION]
									WHERE DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK
                               END

								DECLARE cursorSparepart CURSOR LOCAL FOR
								SELECT [CODE] FROM [dbo].[EWIP_SPARE_PART] WHERE [SP_DEPT_CODE] = @A_DEPARTMENT
							  
								OPEN cursorSparepart

								FETCH NEXT FROM cursorSparepart
								INTO @SPARE_PART_CODE

								WHILE @@FETCH_STATUS = 0
							  	  BEGIN
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
												THROW @N_RETURN, @V_RETURN, 1;

											FETCH NEXT FROM cursorSparepart
											INTO @SPARE_PART_CODE
								   END
								   CLOSE cursorSparepart
								  DEALLOCATE cursorSparepart


								  DECLARE @LOCAL_DATA_QTY_IN TABLE
								  (
								  	SPARE_PART_CODE NVARCHAR(50),
								  	QTY FLOAT,
								  	MONTH INT,
								  	YEAR INT
								  )
								  
								  DECLARE @LOCAL_DATA_QTY_OUT TABLE
								  (
								  	SPARE_PART_CODE NVARCHAR(50),
								  	QTY FLOAT,
								  	MONTH INT,
								  	YEAR INT
								  )
								  				  							  
								  INSERT INTO @LOCAL_DATA_QTY_IN
								  SELECT ehi.SPARE_PART_CODE,SUM(ISNULL(ehi.QUANTITY,0) * dbo.CONVERT_UNIT(ehi.UNIT,'PACK',ehi.SPARE_PART_CODE,@A_DEPARTMENT)) AS QTY,ehi.MONTH,EHI.YEAR
								  FROM EWIP_HISTORY_INVENTORY ehi
								  WHERE ehi.IN_OUT = 'IN' AND ehi.STATUS = 'COMPLETE' AND ehi.DEPT_CODE = @A_DEPARTMENT AND ehi.MONTH = @A_MONTH AND EHI.YEAR = @A_YEAR
								  GROUP BY ehi.DEPT_CODE,ehi.SPARE_PART_CODE,EHI.YEAR,ehi.MONTH
								  ORDER BY ehi.SPARE_PART_CODE,EHI.YEAR,ehi.MONTH
								  
								  INSERT INTO @LOCAL_DATA_QTY_OUT
								  SELECT ehi.SPARE_PART_CODE,SUM(ISNULL(ehi.QUANTITY,0) * dbo.CONVERT_UNIT(ehi.UNIT,'PACK',ehi.SPARE_PART_CODE,@A_DEPARTMENT)) AS QTY,ehi.MONTH,EHI.YEAR
								  FROM EWIP_HISTORY_INVENTORY ehi
								  WHERE ehi.IN_OUT = 'OUT' AND ehi.STATUS = 'COMPLETE' AND ehi.DEPT_CODE = @A_DEPARTMENT AND ehi.MONTH = @A_MONTH AND EHI.YEAR = @A_YEAR
								  GROUP BY ehi.DEPT_CODE,ehi.SPARE_PART_CODE,EHI.YEAR,ehi.MONTH
								  ORDER BY ehi.SPARE_PART_CODE,EHI.YEAR,ehi.MONTH


								  SELECT V.[SPARE_PART_CODE],ESP.NAME_VI,ESP.NAME_KR,T.NAME AS TYPENAME,
										 ISNULL(IV.PRICE_VN,SUB.PRICE_VN/[dbo].[CONVERT_UNIT]('PACK',IV.UNIT,V.[SPARE_PART_CODE],@A_DEPARTMENT)) AS PRICE_VN,
										 ISNULL(IV.PRICE_US,SUB.PRICE_US/[dbo].[CONVERT_UNIT]('PACK',IV.UNIT,V.[SPARE_PART_CODE],@A_DEPARTMENT)) AS PRICE_US,
								         DI.QTY*  [dbo].[CONVERT_UNIT]('PACK',IV.UNIT,V.[SPARE_PART_CODE],@A_DEPARTMENT) AS IN_QTY,
										 DO.QTY * [dbo].[CONVERT_UNIT]('PACK',IV.UNIT,V.[SPARE_PART_CODE],@A_DEPARTMENT) AS OUT_QTY,
										 IV.QUANTITY AS INVENTORY_QTY,
										 IV.UNIT,
										 [IN_VALUES_VN],
										 [IN_VALUES_US],
										 [OUT_VALUES_VN],
										 [OUT_VALUES_US],
										 [INVENTORY_VALUES_VN],
										 [INVENTORY_VALUES_US]
										 ,CAST(V.[MONTH] AS NVARCHAR) AS MONTH,CAST(V.[YEAR] AS NVARCHAR) AS YEAR,V.[DEPT_CODE] 
								  FROM
								  [dbo].[EWIP_INVENTORY_VALUES_BY_TIME] V
								  INNER JOIN EWIP_SPARE_PART esp ON V.SPARE_PART_CODE = esp.CODE AND V.DEPT_CODE = ESP.SP_DEPT_CODE
								  LEFT JOIN [dbo].[EWIP_SPAREPART_TYPE] T ON ESP.TYPE = T.CODE
								  LEFT JOIN [dbo].[EWIP_INVENTORY_BY_TIME] IV ON V.DEPT_CODE = IV.DEPT_CODE AND V.SPARE_PART_CODE = IV.SPARE_PART_CODE AND IV.MONTH = @A_MONTH AND IV.YEAR = @A_YEAR AND IV.STOCK_CODE = V.STOCK_CODE
								  LEFT JOIN @LOCAL_DATA_QTY_IN DI ON DI.SPARE_PART_CODE = V.SPARE_PART_CODE
								  LEFT JOIN @LOCAL_DATA_QTY_OUT DO ON DO.SPARE_PART_CODE = V.SPARE_PART_CODE
								  LEFT JOIN (SELECT TOP 1 WITH TIES 
											[SPARE_PART_CODE],
											[PRICE_VN]/[dbo].[CONVERT_UNIT]([UNIT_CODE],'PACK',[SPARE_PART_CODE],@A_DEPARTMENT) AS [PRICE_VN],
											[PRICE_US]/[dbo].[CONVERT_UNIT]([UNIT_CODE],'PACK',[SPARE_PART_CODE],@A_DEPARTMENT) AS [PRICE_US]
											FROM [dbo].[EWIP_SPAREPART_PRICE]
											WHERE [DEPT_CODE] = @A_DEPARTMENT
											ORDER BY ROW_NUMBER() OVER(PARTITION BY SPARE_PART_CODE ORDER BY [DATE] DESC)) SUB ON SUB.SPARE_PART_CODE = V.SPARE_PART_CODE
								  WHERE V.[MONTH] = @A_MONTH AND V.[YEAR] = @A_YEAR AND V.DEPT_CODE = @A_DEPARTMENT AND V.STOCK_CODE = @A_STOCK
		END
	COMMIT TRAN
END TRY
	BEGIN CATCH
  ROLLBACK TRAN
END CATCH

GO
