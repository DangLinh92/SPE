SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_EQUIPMENT@GET](
@A_CODE             NVARCHAR(50),-- MA THIET BI
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
				SELECT * FROM [dbo].[EWIP_EQUIPMENT]
				WHERE [EQUIPMENT_ID] = @A_CODE AND [DEPT_CODE] = @A_DEPARTMENT

				SELECT * FROM [dbo].[EWIP_SPAREPART_DOCUMENT]
				WHERE CODE = @A_CODE AND DEPT_CODE = @A_DEPARTMENT AND [IS_EQUIPMENT] = '1'

				SELECT BOM.[SPARE_PART_CODE],SP.NAME_VI
				FROM [dbo].[EWIP_EQUIPMENT_BOM] BOM
				INNER JOIN [dbo].[EWIP_SPARE_PART] SP ON SP.CODE = BOM.[SPARE_PART_CODE] AND SP.SP_DEPT_CODE = BOM.[DEP_CODE]
				WHERE [EQUIPMENT_ID] = @A_CODE AND [DEP_CODE] = @A_DEPARTMENT

				SELECT * FROM [dbo].[EWIP_EQUIPMENT_LOCATION_RELATION]
				WHERE [EQUIPMENT_ID] = @A_CODE  AND [DEPT_CODE] = @A_DEPARTMENT
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH


GO
