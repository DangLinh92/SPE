﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_UNIT@PUT](
@A_SPARE_PART_CODE			NVARCHAR(50),
@A_UNIT						NVARCHAR(20),
@A_UNIT_MIN					NVARCHAR(20),
@A_DEPARTMENT				NVARCHAR(50),
@A_RATE                     FLOAT,
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY


   DECLARE @CHECK INT;

   SELECT @CHECK = COUNT(*) FROM [dbo].[EWIP_SPAREPART_UNIT] WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT

   IF @CHECK > 0
      UPDATE [dbo].[EWIP_SPAREPART_UNIT]
	  SET UNIT_CODE = @A_UNIT, UNIT_CODE_MIN = @A_UNIT_MIN
	  WHERE [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND [DEPT_CODE] = @A_DEPARTMENT
  ELSE
     INSERT INTO [dbo].[EWIP_SPAREPART_UNIT]
	 VALUES(@A_SPARE_PART_CODE,@A_UNIT,@A_UNIT_MIN,@A_RATE,@A_DEPARTMENT)

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
	COMMIT TRANSACTION;

	END TRY
	BEGIN CATCH
	SET @N_RETURN = ERROR_NUMBER();
	SET @V_RETURN = ERROR_MESSAGE();
	ROLLBACK TRANSACTION;
END CATCH
GO