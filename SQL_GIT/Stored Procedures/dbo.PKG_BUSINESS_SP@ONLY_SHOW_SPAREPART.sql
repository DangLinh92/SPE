SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP@ONLY_SHOW_SPAREPART](
@A_DEPARTMENT		NVARCHAR(50),
@A_CODE				NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		BEGIN
			SELECT 
			   sp.CODE,
			   sp.NAME_VI,
			   sp.NAME_KR,
			   sp.VENDER_ID,
			   SP.GL_ACCOUNT,
			   SP.TYPE,
			   SP.MATERIAL,
			   SP.SIZE,
			   SP.WEIGHT,
			   SP.USES,
			   SP.EQUIPMENT_USED,
			   SP.SPECIFICATIONS as SPECIFICATION,
			   SP.UNIT_ID,
			   SP.DESCRIPTION,
			   '' AS COST_CTR,
			   SP.IMAGE,
			   sp.MIN_ORDER,
			   sp.[LEAD_TIME]
			FROM EWIP_SPARE_PART sp 
			WHERE sp.CODE = @A_CODE AND sp.[SP_DEPT_CODE] = @A_DEPARTMENT;


			SELECT [UNIT_CODE],[UNIT_CODE_MIN],[RATE] 
			FROM [dbo].[EWIP_SPAREPART_UNIT] su
			     INNER JOIN EWIP_SPARE_PART sp ON su.SPARE_PART_CODE = sp.CODE AND sp.[SP_DEPT_CODE] = su.DEPT_CODE
			WHERE su.SPARE_PART_CODE = @A_CODE AND su.DEPT_CODE = @A_DEPARTMENT AND [UNIT_CODE] <> [UNIT_CODE_MIN]
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO