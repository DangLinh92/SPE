SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@PUT_QUANTITY_REAL](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_QUANTITY_REAL    FLOAT,
@A_UNIT             VARCHAR(20),
@A_DATE				NVARCHAR(50), -- 2021-06-15
@A_YEAR             NVARCHAR(4),
@A_MONTH			NVARCHAR(2),
@A_QUANTITY         FLOAT,
@A_USER             NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK1 int;
			DECLARE @CHECK2 int;
			DECLARE @TABLE_QUANTITY TABLE(QUANTITY float,IN_OUT NVARCHAR(50));

			begin tran;
			SELECT @CHECK1 = COUNT(*) FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)

			SELECT @CHECK2 = COUNT(*) 
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			DECLARE @QUANTITY FLOAT;
			DECLARE @QUANTITY_IN FLOAT;
			DECLARE @QUANTITY_OUT FLOAT;

			-- GET quantity of pre month
			SELECT @QUANTITY =[dbo].[CONVERT_UNIT](UNIT,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)*QUANTITY 
			FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE  [SPARE_PART_CODE] = @A_SPARE_PART_CODE  AND [MONTH] = MONTH(DATEADD(month,-1,@A_DATE)) AND [YEAR] = YEAR(DATEADD(month,-1,@A_DATE)) AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			INSERT INTO @TABLE_QUANTITY
			SELECT SUM([dbo].[CONVERT_UNIT](UNIT,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPARTMENT)* ISNULL([QUANTITY],0)) AS QUANTITY, IN_OUT
			FROM [dbo].[EWIP_HISTORY_INVENTORY] 
			WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE  AND [MONTH] =  CAST(@A_MONTH AS int) AND [YEAR] = CAST(@A_YEAR AS int) AND DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [STATUS] = 'COMPLETE'
			GROUP BY IN_OUT

			-- SO LUONG NHAP XUAT KHO
			SELECT @QUANTITY_IN = QUANTITY FROM @TABLE_QUANTITY WHERE IN_OUT = 'IN';
			SELECT @QUANTITY_OUT = QUANTITY FROM @TABLE_QUANTITY WHERE IN_OUT = 'OUT';

			IF(@QUANTITY IS NULL) SET @QUANTITY = 0;
			IF(@QUANTITY_IN IS NULL) SET @QUANTITY_IN = 0;
			IF(@QUANTITY_OUT IS NULL) SET @QUANTITY_OUT = 0;

			DECLARE @QUANTITY_MONTH FLOAT;

			-- TON KHO LY THUYET
			SET @QUANTITY_MONTH = @QUANTITY + @QUANTITY_IN - @QUANTITY_OUT;

			IF @A_QUANTITY IS NOT NULL AND @A_QUANTITY >= 0
					SET @QUANTITY_MONTH = @A_QUANTITY

			DECLARE @PRICE_VN float
			DECLARE @PRICE_US float

			SELECT TOP 1 @PRICE_VN = PRICE_VN/[dbo].[CONVERT_UNIT]([UNIT_CODE],@A_UNIT,SPARE_PART_CODE,@A_DEPARTMENT) ,@PRICE_US = PRICE_US/[dbo].[CONVERT_UNIT]([UNIT_CODE],@A_UNIT,SPARE_PART_CODE,@A_DEPARTMENT) 
			FROM [dbo].[EWIP_SPAREPART_PRICE]
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT AND CAST(@A_DATE AS date) >=  [DATE]
			ORDER BY [DATE] DESC

			IF @CHECK1 > 0
					UPDATE [dbo].[EWIP_INVENTORY_BY_TIME] 
					SET QUANTITY_REAL = @A_QUANTITY_REAL,UNIT = @A_UNIT,[DATE] = CAST(@A_DATE AS date),[YEAR] = CAST(@A_YEAR AS int),[MONTH] = CAST(@A_MONTH AS int),QUANTITY = @QUANTITY_MONTH,
					[PRICE_VN] = @PRICE_VN,[PRICE_US] = @PRICE_US
					WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)
			ELSE
			    BEGIN
					INSERT INTO [dbo].[EWIP_INVENTORY_BY_TIME]
					VALUES(@A_SPARE_PART_CODE,@QUANTITY_MONTH,@A_UNIT,@A_DEPARTMENT,@A_STOCK,CAST(@A_DATE AS date),CAST(@A_MONTH AS int),CAST(@A_YEAR AS int),@A_QUANTITY_REAL,@PRICE_VN,@PRICE_US)
				END

			IF @CHECK2 > 0
			  IF  YEAR(GETDATE()) = CAST(@A_YEAR AS int) AND MONTH(GETDATE()) = CAST(@A_MONTH AS int)
				BEGIN
					UPDATE [dbo].[EWIP_SPAREPART_INVENTORY] 
					SET QUANTITY_REAL = [dbo].[CONVERT_UNIT](@A_UNIT,UNIT_IN_CODE,@A_SPARE_PART_CODE,@A_DEPARTMENT)* @A_QUANTITY_REAL,UPDATE_DATE = GETDATE(),
					    QUANTITY = [dbo].[CONVERT_UNIT](@A_UNIT,UNIT_IN_CODE,@A_SPARE_PART_CODE,@A_DEPARTMENT)* @QUANTITY_MONTH
					WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK 
				END
			   ELSE
			     PRINT('EXIST')
			 ELSE
			   INSERT INTO [dbo].[EWIP_SPAREPART_INVENTORY] 
			   VALUES(@A_SPARE_PART_CODE,@QUANTITY_MONTH,@A_UNIT,@A_QUANTITY_REAL,@A_DEPARTMENT,@A_STOCK,GETDATE(),GETDATE(),@A_USER)
			    
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	Commit tran;
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
  rollback tran;
END CATCH
GO
