SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_EXCHANGE_RATE@GET_BY_TIME](
@A_DATE             NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			
			DECLARE @EX_RATE_US_VN FLOAT
			SELECT TOP 1 @EX_RATE_US_VN = [RATE] 
			FROM [dbo].[EWIP_EXCHANGE_RATE] 
			WHERE [FROM] = 'USD' AND [TO] = 'VND' AND  year([VALID_TIME]) = YEAR(CAST(@A_DATE as date)) and MONTH([VALID_TIME]) = MONTH(CAST(@A_DATE as date))
			ORDER BY [VALID_TIME] DESC

			IF @EX_RATE_US_VN IS NULL 
			   SELECT TOP 1 @EX_RATE_US_VN = [RATE] 
				FROM [dbo].[EWIP_EXCHANGE_RATE] 
				WHERE [FROM] = 'USD' AND [TO] = 'VND' AND  CAST(@A_DATE as date) >= [VALID_TIME] 
				ORDER BY [VALID_TIME] DESC

			SELECT ISNULL(@EX_RATE_US_VN,23000) AS RATE
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
