SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_SPAREPART@GET_LOCATION_BY_SPAREPART](
@A_STOCK_CODE                VARCHAR(50),
@A_DEPT_CODE                 NVARCHAR(50),
@A_SPARE_PART_CODE           NVARCHAR(50),
@A_UNIT                      NVARCHAR(20),
@N_RETURN					 int OUTPUT,
@V_RETURN					 NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT [LOCATION_CODE] AS LOCATION,[CONDITION_CODE],[dbo].[CONVERT_UNIT](UNIT_ID,@A_UNIT,@A_SPARE_PART_CODE,@A_DEPT_CODE) * QUANTITY AS QUANTITY,0.0 AS QUANTITY_GET,@A_UNIT as UNIT,CASE WHEN [EXPIRED_DATE] = '2199-01-01' THEN NULL ELSE [EXPIRED_DATE] END AS [EXPIRED_DATE],TIME_IN
			FROM [dbo].[EWIP_SPAREPART_LOCATION] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPT_CODE AND [STOCK_CODE] = @A_STOCK_CODE AND QUANTITY > 0
			ORDER BY ISNULL([EXPIRED_DATE],'2199-01-01') ASC,TIME_IN ASC
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO