SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@GET_SPARE_PART_PAY](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT [ID],[SPARE_PART_CODE],[DATE_LEND],[QUANTITY],[QUANTITY_PAY],[UNIT],[DATE_PAY],[DATE_PAY_ACTUAL],[IS_PAY],[LEND_CODE]
			FROM [dbo].[EWIP_SPAREPART_LEND]
			WHERE DEPT_CODE = @A_DEPARTMENT 
			ORDER BY [DATE_PAY] 
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH


GO
