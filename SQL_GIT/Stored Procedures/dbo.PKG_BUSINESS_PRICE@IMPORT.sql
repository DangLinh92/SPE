SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_PRICE@IMPORT](
@A_DATE NVARCHAR(50),
@A_DEPT_CODE  NVARCHAR(50),
@A_DATA [dbo].[SPAREPART_PRICE_TYPE] READONLY,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			BEGIN TRAN

			MERGE [dbo].[EWIP_SPAREPART_PRICE] AS TARGET
			USING @A_DATA AS SOURCE
			ON (
			    TARGET.[SPARE_PART_CODE] = SOURCE.SPARE_PART_CODE AND
				TARGET.[DEPT_CODE] = @A_DEPT_CODE
				)
			WHEN MATCHED
			    THEN UPDATE SET 
				     TARGET.[PRICE_VN] =ISNULL(SOURCE.[PRICE_VN],0),
					 TARGET.[PRICE_US] = ISNULL(SOURCE.[PRICE_US],0), 
					 TARGET.DATE = CAST(@A_DATE AS DATE),
					 TARGET.[UNIT_CODE] = SOURCE.[UNIT],
					 TARGET.[INPUT_DEFAULT] = SOURCE.[INPUT_DEFAULT]
			WHEN NOT MATCHED BY TARGET 
			    THEN INSERT ([SPARE_PART_CODE],[STOCK_IN_CODE],[PRICE_VN],[PRICE_US],[UNIT_CODE],[DEPT_CODE],[DATE],[INPUT_DEFAULT])
				VALUES(SOURCE.[SPARE_PART_CODE],NULL,SOURCE.[PRICE_VN], SOURCE.[PRICE_US],SOURCE.[UNIT],@A_DEPT_CODE,CAST(@A_DATE AS DATE),SOURCE.[INPUT_DEFAULT]);

            MERGE [dbo].[EWIP_INVENTORY_BY_TIME] AS TARGET
			USING @A_DATA AS SOURCE
			ON (
			    TARGET.[SPARE_PART_CODE] = SOURCE.SPARE_PART_CODE AND
				TARGET.[DEPT_CODE] = @A_DEPT_CODE AND 
				TARGET.[MONTH] = MONTH(CAST(@A_DATE AS date)) AND 
				TARGET.[YEAR] = YEAR(CAST(@A_DATE AS date))
				)
			WHEN MATCHED
			    THEN UPDATE SET TARGET.[PRICE_VN] = SOURCE.[PRICE_VN]/[dbo].[CONVERT_UNIT](SOURCE.[UNIT],TARGET.[UNIT],TARGET.[SPARE_PART_CODE],@A_DEPT_CODE),TARGET.[PRICE_US] = SOURCE.[PRICE_US]/[dbo].[CONVERT_UNIT](SOURCE.[UNIT],TARGET.[UNIT],TARGET.[SPARE_PART_CODE],@A_DEPT_CODE);

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
