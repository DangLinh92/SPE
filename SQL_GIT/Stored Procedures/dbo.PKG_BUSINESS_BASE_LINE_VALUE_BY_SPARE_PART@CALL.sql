SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_BASE_LINE_VALUE_BY_SPARE_PART@CALL](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_DATE				NVARCHAR(50), -- 2021-06-15
@A_YEAR             NVARCHAR(4),
@A_MONTH			NVARCHAR(2),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			BEGIN TRAN;
			
		  -- CACULATOR VALUE MONEY
		  DECLARE @IN_VALUES_OF_DATE_VN FLOAT = 0
		  DECLARE @OUT_VALUES_OF_DATE_VN FLOAT = 0
		  DECLARE @IN_VALUES_OF_DATE_US FLOAT = 0
		  DECLARE @OUT_VALUES_OF_DATE_US FLOAT =0
		  DECLARE @INVENTORY_VALUES_US FLOAT = 0
		  DECLARE @INVENTORY_VALUES_VN FLOAT = 0

		  DECLARE @PACK_UNIT NVARCHAR(50) = 'PACK'

		 SELECT @IN_VALUES_OF_DATE_VN = SUM((ISNULL(dbo.CONVERT_UNIT(ehi.UNIT,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)* ISNULL(Ehi.QUANTITY,0),0) - ISNULL(dbo.CONVERT_UNIT(ehi.UNIT,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT) * ISNULL(EHI.QUANTITY_NG,0),0) - CASE WHEN STIN.IS_INTEGRATED = 'True' THEN ISNULL(ISNULL(STIN.QUANTITY,0) * dbo.CONVERT_UNIT(STIN.UNIT_CODE,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT) ,0) ELSE 0 END)* ISNULL(SUB2.PRICE_VN,ISNULL(SUB3.PRICE_VN,SUB.PRICE_VN))),
		        @IN_VALUES_OF_DATE_US = SUM((ISNULL(dbo.CONVERT_UNIT(ehi.UNIT,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT) * ISNULL(EHI.QUANTITY,0),0) - ISNULL(dbo.CONVERT_UNIT(ehi.UNIT,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)* ISNULL(EHI.QUANTITY_NG,0),0) - CASE WHEN STIN.IS_INTEGRATED = 'True' THEN ISNULL(ISNULL(STIN.QUANTITY,0) * dbo.CONVERT_UNIT(STIN.UNIT_CODE,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT) ,0) ELSE 0 END)* ISNULL(SUB2.PRICE_US,ISNULL(SUB3.PRICE_US,SUB.PRICE_US)))
		 FROM EWIP_HISTORY_INVENTORY ehi
		 LEFT JOIN [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR ON ehi.STOCK_IN_OUT_CODE = IDR.CODE_NO AND IDR.STATUS = 'COMPLETE' AND ehi.DEPT_CODE = idr.DEPT_CODE
		 INNER JOIN [dbo].[EWIP_SP_STOCKIN] STIN ON ehi.STOCK_IN_OUT_CODE = stin.STOCK_IN_CODE AND EHI.SPARE_PART_CODE = STIN.SPARE_PART_CODE AND ehi.DEPT_CODE = STIN.DEPT_CODE
		 LEFT JOIN (
					  SELECT EO.PO_ID AS PO_NO,eprd.SPAREPART_CODE ,'PACK' as UNIT,eprd.DEPT_CODE,
					  eprd.PRICE_VN/[dbo].[CONVERT_UNIT](eprd.UNIT,@PACK_UNIT,eprd.SPAREPART_CODE,@A_DEPARTMENT) AS PRICE_VN,
					  eprd.PRICE_US/[dbo].[CONVERT_UNIT](eprd.UNIT,@PACK_UNIT,eprd.SPAREPART_CODE,@A_DEPARTMENT) AS PRICE_US
					  FROM EWIP_ORDER eo
					  INNER JOIN EWIP_ORDER_PR eop ON EO.PO_ID_TEMP = eop.PO_ID_TEMP
					  INNER JOIN EWIP_PURCHASE_REQUEST epr ON EOP.PR_CODE = EPR.PR_CODE AND EOP.DEPT_CODE = EPR.DEPT_CODE
					  INNER JOIN EWIP_PURCHASE_REQUEST_DETAIL eprd ON EPR.PR_CODE = eprd.PR_CODE AND EPR.DEPT_CODE = eprd.DEPT_CODE
					) SUB2 ON SUB2.SPAREPART_CODE = EHI.SPARE_PART_CODE AND SUB2.DEPT_CODE = EHI.DEPT_CODE AND SUB2.PO_NO = IDR.ORDER_CODE
		 LEFT JOIN (SELECT TOP 1
		              SPARE_PART_CODE,
		              [PRICE_VN]/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) AS PRICE_VN,
					  [PRICE_US]/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT)  AS PRICE_US
		            FROM [dbo].[EWIP_INVENTORY_BY_TIME]
					WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [MONTH] =  CAST(@A_MONTH AS int) AND [YEAR] = CAST(@A_YEAR AS INT)
					) AS SUB3 ON SUB3.SPARE_PART_CODE = ehi.SPARE_PART_CODE
		 LEFT JOIN (SELECT TOP 1 WITH TIES 
						[SPARE_PART_CODE],
						[PRICE_VN]/[dbo].[CONVERT_UNIT]([UNIT_CODE],@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) AS [PRICE_VN],
						[PRICE_US]/[dbo].[CONVERT_UNIT]([UNIT_CODE],@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) AS [PRICE_US], 
						@PACK_UNIT AS UNIT
						FROM [dbo].[EWIP_SPAREPART_PRICE] 
						WHERE [DEPT_CODE] = @A_DEPARTMENT AND SPARE_PART_CODE = @A_SPARE_PART_CODE
						ORDER BY ROW_NUMBER() OVER(PARTITION BY SPARE_PART_CODE ORDER BY [DATE] DESC)) SUB ON SUB.SPARE_PART_CODE = EHI.SPARE_PART_CODE
		 WHERE 
		    ehi.IN_OUT = 'IN' AND ehi.DEPT_CODE = @A_DEPARTMENT AND 
		    ehi.STOCK_CODE = @A_STOCK 
			AND ehi.SPARE_PART_CODE = @A_SPARE_PART_CODE AND
			CAST(@A_MONTH AS int) = EHI.MONTH AND 
			CAST(@A_YEAR AS INT) = EHI.YEAR
		 GROUP BY ehi.SPARE_PART_CODE 
		  
		  -- TINH GIA TRI OUT --
		DECLARE @LOCATION_OUT NVARCHAR(MAX)
		DECLARE @QUANTITY_OUT_SP FLOAT
		DECLARE @UNIT_OUT NVARCHAR(50)
		DECLARE @VALUES_OUT_VN FLOAT = 0
		DECLARE @VALUES_OUT_US FLOAT = 0
		DECLARE @A_TMP_LOCATION NVARCHAR(MAX)
		DECLARE @CHECK_COUNT INT

		DECLARE @A_TMP_L NVARCHAR(100)
		DECLARE @A_TMP_Q NVARCHAR(20)
		DECLARE @A_TMP_C NVARCHAR(50)
		DECLARE @A_TMP_EX NVARCHAR(50)
		DECLARE @A_TMP_IT NVARCHAR(50)
		DECLARE @A_TMP_UNIT NVARCHAR(20)
		DECLARE @A_TMP_PO_NO NVARCHAR(50)
		DECLARE @A_PRICE_US_TMP FLOAT = 0
		DECLARE @A_PRICE_VN_TMP FLOAT = 0

		DECLARE cursorOutSparepart CURSOR FOR
		SELECT eso.LOCATION,eso.QUANTITY,eso.UNIT_ID AS UNIT
		FROM EWIP_STOCK_OUT eso  
				INNER JOIN EWIP_INVENTORY_DELIVERY_RECEIVING eidr ON eso.STOCK_OUT_CODE = eidr.CODE_NO AND eso.DEPT_CODE = eidr.DEPT_CODE
		WHERE 
			ESO.SPARE_PART_CODE = @A_SPARE_PART_CODE AND 
			ESO.DEPT_CODE = @A_DEPARTMENT AND 
			ESO.STOCK_CODE = @A_STOCK AND 
			ESO.MONTH = CAST(@A_MONTH AS INT) AND 
			eso.YEAR = CAST(@A_YEAR AS INT)
		 
		 OPEN cursorOutSparepart

		 FETCH NEXT FROM cursorOutSparepart
			INTO @LOCATION_OUT,@QUANTITY_OUT_SP,@UNIT_OUT

		WHILE @@FETCH_STATUS = 0
			 BEGIN
					DECLARE cursorOutSub CURSOR FOR
					SELECT value FROM STRING_SPLIT(@LOCATION_OUT,',')

					OPEN cursorOutSub

					FETCH NEXT FROM cursorOutSub
					INTO @A_TMP_LOCATION

					WHILE @@FETCH_STATUS = 0
					  BEGIN
							SELECT @CHECK_COUNT = COUNT(value)
							from 
							STRING_SPLIT(@A_TMP_LOCATION,'_')
					
							IF @CHECK_COUNT = 7
							  BEGIN
									SET @A_TMP_L = SUBSTRING(@A_TMP_LOCATION,1,CHARINDEX('_',@A_TMP_LOCATION) - 1)
									SET @A_TMP_Q = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L)+2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L)+2)-LEN(@A_TMP_L)- 2)
									SET @A_TMP_C = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q) + 2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q) - 2)
									SET @A_TMP_EX = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C) + 2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C) - 2)
									SET @A_TMP_IT = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX) + 2,
									                                          CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX) - 2)

									SET @A_TMP_UNIT = SUBSTRING(@A_TMP_LOCATION,
									                           LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) + 2,
															   CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) - 2)

									SET @A_TMP_PO_NO = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT + '_' + @A_TMP_UNIT) + 2,LEN(@A_TMP_LOCATION) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT + '_' + @A_TMP_UNIT) - 1)
									   
									SET @A_PRICE_VN_TMP = 0
									SET @A_PRICE_US_TMP = 0

									IF @A_TMP_C NOT IN ('NG','INTEGRATED')
									   BEGIN
											 SELECT @A_PRICE_VN_TMP = ISNULL(eprd.PRICE_VN,0)/[dbo].[CONVERT_UNIT](eprd.UNIT,@PACK_UNIT,eprd.SPAREPART_CODE,@A_DEPARTMENT),
											        @A_PRICE_US_TMP = ISNULL(eprd.PRICE_US,0)/[dbo].[CONVERT_UNIT](eprd.UNIT,@PACK_UNIT,eprd.SPAREPART_CODE,@A_DEPARTMENT)
											 FROM EWIP_ORDER eo
													INNER JOIN EWIP_ORDER_PR eop ON EO.PO_ID_TEMP = eop.PO_ID_TEMP
													INNER JOIN EWIP_PURCHASE_REQUEST epr ON EOP.PR_CODE = EPR.PR_CODE AND EOP.DEPT_CODE = EPR.DEPT_CODE
													INNER JOIN EWIP_PURCHASE_REQUEST_DETAIL eprd ON EPR.PR_CODE = eprd.PR_CODE AND EPR.DEPT_CODE = eprd.DEPT_CODE
											 WHERE EO.PO_ID = @A_TMP_PO_NO AND eprd.SPAREPART_CODE = @A_SPARE_PART_CODE AND eprd.DEPT_CODE = @A_DEPARTMENT
									  
											IF @A_PRICE_VN_TMP IS NULL OR @A_PRICE_US_TMP IS NULL
											   BEGIN
														SELECT TOP 1 
															@A_PRICE_VN_TMP = ISNULL([PRICE_VN],0)/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) ,
															@A_PRICE_US_TMP = ISNULL([PRICE_US],0)/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) 
														FROM [dbo].[EWIP_INVENTORY_BY_TIME]
														WHERE DEPT_CODE = @A_DEPARTMENT AND SPARE_PART_CODE = @A_SPARE_PART_CODE AND STOCK_CODE = @A_STOCK 
														ORDER BY DATE DESC
											   END
										END
									   --PRINT 'Q:' + CAST(@A_TMP_Q AS NVARCHAR)

									SET @VALUES_OUT_VN += [dbo].[CONVERT_UNIT](@A_TMP_UNIT,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT) * ISNULL(@A_TMP_Q,0) *	ISNULL(@A_PRICE_VN_TMP,0);
									SET @VALUES_OUT_US += [dbo].[CONVERT_UNIT](@A_TMP_UNIT,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT) * ISNULL(@A_TMP_Q,0) *	ISNULL(@A_PRICE_US_TMP,0);
						   END
							  ELSE
							    BEGIN
										SET @A_TMP_L = SUBSTRING(@A_TMP_LOCATION,1,CHARINDEX('_',@A_TMP_LOCATION) - 1)
										SET @A_TMP_Q = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L)+2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L)+2)-LEN(@A_TMP_L)- 2)
										SET @A_TMP_C = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q) + 2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q) - 2)
										SET @A_TMP_EX = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C) + 2,CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C) - 2)
										SET @A_TMP_IT = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX) + 2,
										                                          CHARINDEX('_',@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX)+2) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX) - 2)

                                        SET @A_TMP_UNIT = SUBSTRING(@A_TMP_LOCATION,LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) + 2,LEN(@A_TMP_LOCATION) - LEN(@A_TMP_L + '_'+@A_TMP_Q + '_'+@A_TMP_C + '_' + @A_TMP_EX + '_' + @A_TMP_IT) - 1)

										SET @A_PRICE_VN_TMP = 0
										SET @A_PRICE_US_TMP = 0

										  IF @A_TMP_C NOT IN ('NG','INTEGRATED')
											BEGIN
													SELECT TOP 1 
													     @A_PRICE_VN_TMP = ISNULL([PRICE_VN],0)/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) ,
														 @A_PRICE_US_TMP = ISNULL([PRICE_US],0)/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) 
													FROM [dbo].[EWIP_INVENTORY_BY_TIME]
													WHERE DEPT_CODE = @A_DEPARTMENT AND SPARE_PART_CODE = @A_SPARE_PART_CODE AND STOCK_CODE = @A_STOCK AND ((CAST(@A_MONTH AS int) = [MONTH] AND CAST(@A_YEAR AS INT) = [YEAR]) OR CAST(@A_DATE AS DATE) >= [DATE])
													ORDER BY DATE DESC

													IF @A_PRICE_VN_TMP IS NULL OR @A_PRICE_US_TMP IS NULL
													   BEGIN
																SELECT TOP 1 
																	@A_PRICE_VN_TMP = ISNULL([PRICE_VN],0)/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) ,
																	@A_PRICE_US_TMP = ISNULL([PRICE_US],0)/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) 
																FROM [dbo].[EWIP_INVENTORY_BY_TIME]
																WHERE DEPT_CODE = @A_DEPARTMENT AND SPARE_PART_CODE = @A_SPARE_PART_CODE AND STOCK_CODE = @A_STOCK 
																ORDER BY DATE DESC
													   END
										    END

										SET @VALUES_OUT_VN += [dbo].[CONVERT_UNIT](@A_TMP_UNIT,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT) * ISNULL(@A_TMP_Q,0) *	ISNULL(@A_PRICE_VN_TMP,0);
									    SET @VALUES_OUT_US += [dbo].[CONVERT_UNIT](@A_TMP_UNIT,@PACK_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT) * ISNULL(@A_TMP_Q,0) *	ISNULL(@A_PRICE_US_TMP,0);
								END

							FETCH NEXT FROM cursorOutSub
							INTO @A_TMP_LOCATION
                     END
					 CLOSE cursorOutSub
					 DEALLOCATE cursorOutSub

					 FETCH NEXT FROM cursorOutSparepart
					 INTO @LOCATION_OUT,@QUANTITY_OUT_SP,@UNIT_OUT
			 END
		 CLOSE cursorOutSparepart
		 DEALLOCATE cursorOutSparepart

		 SET @OUT_VALUES_OF_DATE_VN = @VALUES_OUT_VN
		 SET @OUT_VALUES_OF_DATE_US = @VALUES_OUT_US

		 -- VALUE INVENTORY OF DATE
		 SELECT @INVENTORY_VALUES_VN = SUM([dbo].[CONVERT_UNIT](BL.UNIT_ID,@PACK_UNIT,BL.SPARE_PART_CODE,@A_DEPARTMENT) * ISNULL(BL.QUANTITY,0) * ISNULL(SUB2.PRICE_VN,ISNULL(SUB3.PRICE_VN,SUB.PRICE_VN))),
		        @INVENTORY_VALUES_US = SUM([dbo].[CONVERT_UNIT](BL.UNIT_ID,@PACK_UNIT,BL.SPARE_PART_CODE,@A_DEPARTMENT) * ISNULL(BL.QUANTITY,0) * ISNULL(SUB2.PRICE_US,ISNULL(SUB3.PRICE_US,SUB.PRICE_US)))
		 FROM [dbo].[EWIP_SPARE_PART_LOCATION_BASE_LINE] BL
		  LEFT JOIN (
					  SELECT EO.PO_ID AS PO_NO,eprd.SPAREPART_CODE ,'PACK' as UNIT,
					        eprd.DEPT_CODE,
							eprd.PRICE_VN/[dbo].[CONVERT_UNIT](eprd.UNIT,@PACK_UNIT,eprd.SPAREPART_CODE,@A_DEPARTMENT) AS PRICE_VN,
					        eprd.PRICE_US/[dbo].[CONVERT_UNIT](eprd.UNIT,@PACK_UNIT,eprd.SPAREPART_CODE,@A_DEPARTMENT) AS PRICE_US
					  FROM EWIP_ORDER eo
					  INNER JOIN EWIP_ORDER_PR eop ON EO.PO_ID_TEMP = eop.PO_ID_TEMP
					  INNER JOIN EWIP_PURCHASE_REQUEST epr ON EOP.PR_CODE = EPR.PR_CODE AND EOP.DEPT_CODE = EPR.DEPT_CODE
					  INNER JOIN EWIP_PURCHASE_REQUEST_DETAIL eprd ON EPR.PR_CODE = eprd.PR_CODE AND EPR.DEPT_CODE = eprd.DEPT_CODE
					) SUB2 ON SUB2.SPAREPART_CODE = BL.SPARE_PART_CODE AND SUB2.DEPT_CODE = BL.DEPT_CODE AND SUB2.PO_NO = BL.PO_NO
		 LEFT JOIN (SELECT TOP 1
		              SPARE_PART_CODE,
		              [PRICE_VN]/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) AS PRICE_VN,
					  [PRICE_US]/[dbo].[CONVERT_UNIT](UNIT,@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT)  AS PRICE_US
		            FROM [dbo].[EWIP_INVENTORY_BY_TIME]
					WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [MONTH] =  CAST(@A_MONTH AS int) AND [YEAR] = CAST(@A_YEAR AS INT)
					) AS SUB3 ON SUB3.SPARE_PART_CODE = BL.SPARE_PART_CODE
		 LEFT JOIN (SELECT TOP 1 WITH TIES 
						[SPARE_PART_CODE],
						[PRICE_VN]/[dbo].[CONVERT_UNIT]([UNIT_CODE],@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) AS [PRICE_VN],
						[PRICE_US]/[dbo].[CONVERT_UNIT]([UNIT_CODE],@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT) AS [PRICE_US], 
						@PACK_UNIT AS UNIT
						FROM [dbo].[EWIP_SPAREPART_PRICE]
						WHERE [DEPT_CODE] = @A_DEPARTMENT AND SPARE_PART_CODE = @A_SPARE_PART_CODE
						ORDER BY ROW_NUMBER() OVER(PARTITION BY SPARE_PART_CODE ORDER BY [DATE] DESC)) SUB ON SUB.SPARE_PART_CODE =BL.SPARE_PART_CODE
         WHERE BL.[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND BL.DEPT_CODE = @A_DEPARTMENT AND BL.STOCK_CODE = @A_STOCK AND 
		       BL.CONDITION_CODE NOT IN('INTEGRATED','NG') AND BL.MONTH_BASE_LINE = CAST(@A_MONTH AS INT) AND BL.YEAR_BASE_LINE = CAST(@A_YEAR AS INT)

		 IF @INVENTORY_VALUES_VN IS NULL OR @INVENTORY_VALUES_US IS NULL
		     BEGIN
						DECLARE @PRICE_VN FLOAT = 0
						DECLARE @PRICE_US FLOAT = 0

						SELECT TOP 1 
						@PRICE_VN = ISNULL([PRICE_VN],0)/[dbo].[CONVERT_UNIT]([UNIT_CODE],@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT),
						@PRICE_US = ISNULL([PRICE_US],0)/[dbo].[CONVERT_UNIT]([UNIT_CODE],@PACK_UNIT,[SPARE_PART_CODE],@A_DEPARTMENT)
						FROM [dbo].[EWIP_SPAREPART_PRICE]
						WHERE [DEPT_CODE] = @A_DEPARTMENT AND SPARE_PART_CODE = @A_SPARE_PART_CODE
						ORDER BY [DATE] DESC

						SELECT @INVENTORY_VALUES_VN = SUM(ISNULL(QUANTITY,0) * dbo.CONVERT_UNIT(BT.UNIT,'PACK',@A_SPARE_PART_CODE,@A_DEPARTMENT)) * @PRICE_VN -  ISNULL(BD.QTY_INVENTORY_INCLUDE,0) * dbo.CONVERT_UNIT(BD.UNIT,'PACK',@A_SPARE_PART_CODE,@A_DEPARTMENT) * @PRICE_VN,
						      @INVENTORY_VALUES_US = SUM(ISNULL(QUANTITY,0) * dbo.CONVERT_UNIT(BT.UNIT,'PACK',@A_SPARE_PART_CODE,@A_DEPARTMENT)) * @PRICE_US -  ISNULL(BD.QTY_INVENTORY_INCLUDE,0) * dbo.CONVERT_UNIT(BD.UNIT,'PACK',@A_SPARE_PART_CODE,@A_DEPARTMENT) * @PRICE_US
						FROM [dbo].[EWIP_INVENTORY_BY_TIME] BT
						LEFT JOIN 
						(SELECT TOP 1 * 
						FROM [dbo].[EWIP_INVENTORY_QTY_VALUE_BY_DAY] 
						WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND CAST(@A_MONTH AS INT) = MONTH(DATE) AND CAST(@A_YEAR AS INT) = YEAR([DATE]) 
						ORDER BY [DATE] DESC) BD ON BT.SPARE_PART_CODE = BD.SPARE_PART_CODE AND BT.DEPT_CODE = BD.DEPT_CODE
						WHERE BT.SPARE_PART_CODE = @A_SPARE_PART_CODE AND BT.DEPT_CODE = @A_DEPARTMENT AND MONTH = CAST(@A_MONTH AS INT) AND YEAR =  CAST(@A_YEAR AS INT)
						GROUP BY BT.DEPT_CODE,BT.SPARE_PART_CODE,BD.UNIT,BD.QTY_INVENTORY_INCLUDE
			 END

		 IF EXISTS(SELECT TOP 1 * FROM [dbo].[EWIP_INVENTORY_VALUES_BY_TIME] WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [MONTH] =  CAST(@A_MONTH AS int) AND [YEAR] = CAST(@A_YEAR AS INT))
		    BEGIN
					UPDATE [dbo].[EWIP_INVENTORY_VALUES_BY_TIME]
					SET IN_VALUES_VN = ISNULL(@IN_VALUES_OF_DATE_VN,0), 
					    IN_VALUES_US = ISNULL(@IN_VALUES_OF_DATE_US,0),
						[OUT_VALUES_VN] = ISNULL(@OUT_VALUES_OF_DATE_VN,0),
						[OUT_VALUES_US] = ISNULL(@OUT_VALUES_OF_DATE_US,0),
						[INVENTORY_VALUES_VN] = ISNULL(@INVENTORY_VALUES_VN,0),
						[INVENTORY_VALUES_US] = ISNULL(@INVENTORY_VALUES_US,0),
						DATE = @A_DATE,
						[SYS_DATE] = SYSDATETIME()
					WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND 
					      DEPT_CODE = @A_DEPARTMENT AND 
						  STOCK_CODE = @A_STOCK AND 
						  [MONTH] =  CAST(@A_MONTH AS int) AND 
						  [YEAR] = CAST(@A_YEAR AS INT)
			END
		 ELSE 
		    BEGIN

					INSERT INTO [dbo].[EWIP_INVENTORY_VALUES_BY_TIME]
					VALUES(@A_SPARE_PART_CODE,@A_DEPARTMENT,@A_STOCK,@A_DATE,@A_MONTH,@A_YEAR,ISNULL(@IN_VALUES_OF_DATE_VN,0),ISNULL(@OUT_VALUES_OF_DATE_VN,0),ISNULL(@INVENTORY_VALUES_VN,0),ISNULL(@IN_VALUES_OF_DATE_US,0),ISNULL(@OUT_VALUES_OF_DATE_US,0),ISNULL(@INVENTORY_VALUES_US,0),SYSDATETIME())

			END
		END

        IF CAST(DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0) AS DATE) = CAST(GETDATE() AS DATE)
   	       BEGIN
   					IF EXISTS(SELECT TOP 1 * FROM [dbo].[EWIP_INVENTORY_VALUES_BY_TIME] WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [MONTH] =  MONTH(GETDATE()) AND [YEAR] = YEAR(GETDATE()))
   					   BEGIN
   								UPDATE [dbo].[EWIP_INVENTORY_VALUES_BY_TIME]
   								SET IN_VALUES_VN = ISNULL(@IN_VALUES_OF_DATE_VN,0), 
   								    IN_VALUES_US = ISNULL(@IN_VALUES_OF_DATE_US,0),
   									[OUT_VALUES_VN] = ISNULL(@OUT_VALUES_OF_DATE_VN,0),
   									[OUT_VALUES_US] = ISNULL(@OUT_VALUES_OF_DATE_US,0),
   									[INVENTORY_VALUES_VN] = ISNULL(@INVENTORY_VALUES_VN,0),
   									[INVENTORY_VALUES_US] = ISNULL(@INVENTORY_VALUES_US,0),
   									DATE = GETDATE(),
   									[SYS_DATE] = SYSDATETIME()
   								WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND 
   								      DEPT_CODE = @A_DEPARTMENT AND 
   									  STOCK_CODE = @A_STOCK AND 
   									  [MONTH] =  MONTH(GETDATE()) AND 
   									  [YEAR] =   YEAR(GETDATE())
   					   END
   					ELSE
   					    BEGIN
   								INSERT INTO [dbo].[EWIP_INVENTORY_VALUES_BY_TIME]
   								VALUES(@A_SPARE_PART_CODE,@A_DEPARTMENT,@A_STOCK,GETDATE(),MONTH(GETDATE()),YEAR(GETDATE()),ISNULL(@IN_VALUES_OF_DATE_VN,0),ISNULL(@OUT_VALUES_OF_DATE_VN,0),ISNULL(@INVENTORY_VALUES_VN,0),ISNULL(@IN_VALUES_OF_DATE_US,0),ISNULL(@OUT_VALUES_OF_DATE_US,0),ISNULL(@INVENTORY_VALUES_US,0),SYSDATETIME())
   						END
   		   END


	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRAN;
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = @A_DEPARTMENT + '  ' + @A_SPARE_PART_CODE + ' '+ ERROR_MESSAGE();
  Print @A_DEPARTMENT
  print @A_SPARE_PART_CODE
  print '2:' + @V_RETURN
  ROLLBACK TRAN;
END CATCH

GO
