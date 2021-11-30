SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_MRP@CREATE_LEND_CODE](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN

			DECLARE @MAX_CODE nvarchar(50)
		    -- PAYSMT-20210728-001
		    SET NOCOUNT OFF;  

					SELECT TOP 1 @MAX_CODE = [LEND_CODE]
					FROM [dbo].[EWIP_SPAREPART_LEND]
					WHERE [DEPT_CODE] = @A_DEPARTMENT AND FORMAT(GETDATE(),'yyyyMMdd') = CAST(SUBSTRING([LEND_CODE],LEN(@A_DEPARTMENT) + 5,8) AS date)
					ORDER BY CAST(SUBSTRING([LEND_CODE],LEN(@A_DEPARTMENT) + 5,8) AS date) DESC, CAST(SUBSTRING([LEND_CODE],LEN([LEND_CODE])-2,3) AS INT) DESC

					IF @MAX_CODE IS NULL OR @MAX_CODE = ''
						 BEGIN
							SET @MAX_CODE = 'PAY' + @A_DEPARTMENT + '-' + FORMAT(GETDATE(),'yyyyMMdd') +'-'+ '001'
						 END
					ELSE 
					        BEGIN	
								SELECT @MAX_CODE = SUBSTRING(@MAX_CODE,1,LEN(@A_DEPARTMENT) + 13) +  REPLACE(STR((CAST(SUBSTRING(@MAX_CODE,LEN(@A_DEPARTMENT) + 14,3) AS INT)+1), 3), SPACE(1), '0')  
							END
					SELECT @MAX_CODE as CODE

       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
