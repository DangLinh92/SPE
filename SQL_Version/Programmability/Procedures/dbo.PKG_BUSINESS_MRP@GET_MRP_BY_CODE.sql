﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_MRP@GET_MRP_BY_CODE](
@A_DEPARTMENT		NVARCHAR(50),
@A_MRP_CODE         NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT [SPAREPART_CODE],SP.NAME_VI,[QUANTITY_NEED_BUY],[UNIT],[MRP_CODE],[DATE_NEED_REQUIRED],[DATE_NEED_BUY],[DATE_NEED_FINISH],[DATE_END_ACTUAL],[DEPT_CODE],USER_UPDATE as [USER],[STATUS],[OFF_NOTI],MRP.ID
			FROM [dbo].[EWIP_MRP] MRP
			inner join [dbo].[EWIP_SPARE_PART] SP ON MRP.DEPT_CODE = SP.SP_DEPT_CODE AND MRP.SPAREPART_CODE = SP.CODE
			WHERE [DEPT_CODE] = @A_DEPARTMENT AND MRP.MRP_CODE = @A_MRP_CODE
			ORDER BY [DATE_NEED_REQUIRED] DESC,[DATE_NEED_BUY] DESC,[DATE_NEED_FINISH] DESC
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO