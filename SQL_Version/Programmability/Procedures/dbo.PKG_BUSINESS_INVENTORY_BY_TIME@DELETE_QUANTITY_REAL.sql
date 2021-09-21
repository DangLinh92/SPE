﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_BY_TIME@DELETE_QUANTITY_REAL](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK            VARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_YEAR             NVARCHAR(4),
@A_MONTH			NVARCHAR(2),
@A_USER				NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			DECLARE @CHECK1 int;
			DECLARE @CHECK2 int;

			SELECT @CHECK1 = COUNT(*) 
			FROM [dbo].[EWIP_INVENTORY_BY_TIME] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)

			SELECT @CHECK2 = COUNT(*) 
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] 
			WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK

			IF @CHECK1 > 0
			   BEGIN
					DELETE FROM [dbo].[EWIP_INVENTORY_BY_TIME] WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK AND [YEAR] = CAST(@A_YEAR AS int) AND [MONTH] = CAST(@A_MONTH AS int)

					IF @CHECK2 > 0
						IF  YEAR(GETDATE()) = CAST(@A_YEAR AS int) AND MONTH(GETDATE()) = CAST(@A_MONTH AS int)
							BEGIN
								UPDATE [dbo].[EWIP_SPAREPART_INVENTORY] 
								SET QUANTITY_REAL = 0,UPDATE_DATE = GETDATE(),USER_UPDATE = @A_USER
								WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK 
							END
			   END
			
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO