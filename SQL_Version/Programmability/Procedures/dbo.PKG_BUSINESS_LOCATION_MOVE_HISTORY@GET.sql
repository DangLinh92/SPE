﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE  PROC [dbo].[PKG_BUSINESS_LOCATION_MOVE_HISTORY@GET](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK_CODE       NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT [SPARE_PART_CODE],SP.NAME_VI,[LOCATION_CODE_FROM],[LOCATION_CODE_TO],[CONDITION_CODE],[QUANTITY],[DEPT_CODE],[STOCK_CODE],T.[UNIT_ID],[EXPIRED_DATE],[TIME_IN],[DATE_MOVE],FORMAT ([DATE_MOVE], 'hh:mm:ss tt') as TIME,[USER_MOVE] 
			FROM [dbo].[EWIP_SPAREPART_LOCATION_TRANSACTION] T
			INNER JOIN [dbo].[EWIP_SPARE_PART] SP ON T.DEPT_CODE = SP.SP_DEPT_CODE AND T.SPARE_PART_CODE = SP.CODE
			WHERE DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK_CODE AND DATE_MOVE BETWEEN DATEADD(MONTH,-2,GETDATE()) AND GETDATE()
			ORDER BY [DATE_MOVE] DESC
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO