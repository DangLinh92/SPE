SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION_INIT@GET](
@A_DEPARTMENT		NVARCHAR(50),
@A_STOCK_CODE       NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
			SELECT CODE FROM [dbo].[EWIP_LOCATIONS] WHERE DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE = @A_STOCK_CODE
			SELECT CODE,NAME FROM [dbo].[EWIP_STOCK] WHERE DEPT_CODE = @A_DEPARTMENT
			SELECT CODE,NAME FROM [dbo].[EWIP_SPAREPART_CONDITION]
			SELECT CODE,NAME FROM [dbo].[EWIP_UNITS] 

			SELECT sp.CODE,sp.NAME_VI
			FROM EWIP_SPARE_PART sp 
			     INNER JOIN EWIP_SPARE_PART_DEPT spd ON sp.CODE = spd.SPARE_PART_CODE AND spd.DEPT_CODE = sp.[SP_DEPT_CODE]
			WHERE sp.[SP_DEPT_CODE] =  @A_DEPARTMENT
			ORDER BY SP.ID DESC;
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
