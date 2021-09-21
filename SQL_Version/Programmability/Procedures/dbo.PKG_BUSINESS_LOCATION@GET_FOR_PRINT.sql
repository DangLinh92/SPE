﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_LOCATION@GET_FOR_PRINT](
@A_DEPARTMENT       NVARCHAR(100),
@A_STOCK            VARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			SELECT CODE AS LOCATION,STOCK_CODE AS KHO FROM [EWIP_LOCATIONS] 
			WHERE DEPT_CODE = @A_DEPARTMENT AND STOCK_CODE =@A_STOCK  

			SELECT  lc.[CODE] AS LOCATION,[SPARE_PART_CODE],sp.NAME_VI,spc.NAME AS CONDITION_NAME,spl.UNIT_ID as UNIT,spl.QUANTITY,lc.STOCK_CODE AS KHO,spl.ID AS STT,spl.BARCODE, 1 as QUANTITY_PRINT_LABEL,
			          (CASE 
					       WHEN spl.[EXPIRED_DATE] = '2199-01-01' THEN null 
						   ELSE spl.[EXPIRED_DATE] END) AS EXPIRED_DATE,
					  [TIME_IN]
			FROM [dbo].[EWIP_LOCATIONS] lc
			    RIGHT JOIN [dbo].[EWIP_SPAREPART_LOCATION] spl ON lc.CODE = spl.LOCATION_CODE AND lc.DEPT_CODE = spl.DEPT_CODE AND lc.STOCK_CODE = spl.STOCK_CODE
				LEFT JOIN [dbo].[EWIP_SPARE_PART] sp ON spl.SPARE_PART_CODE = sp.CODE AND spl.DEPT_CODE = sp.[SP_DEPT_CODE]
				LEFT JOIN [dbo].[EWIP_SPAREPART_CONDITION] spc ON spl.CONDITION_CODE = spc.CODE
			WHERE spl.DEPT_CODE = @A_DEPARTMENT AND spl.STOCK_CODE =@A_STOCK --AND spl.QUANTITY > 0
			ORDER BY lc.[CODE]

SELECT  lc.[CODE] AS LOCATION,[SPARE_PART_CODE],sp.NAME_VI,spc.NAME AS CONDITION_NAME,
			  (CASE WHEN spl.UNIT_ID = 'EA' THEN 'EA' 
			      WHEN spl.UNIT_ID = 'PAIR' THEN 'PACK'
			      ELSE spl.UNIT_ID END
			) as UNIT,
			(CASE WHEN spl.UNIT_ID = 'EA' THEN [dbo].[CONVERT_UNIT]('EA','EA',spl.SPARE_PART_CODE,@A_DEPARTMENT)
			      WHEN spl.UNIT_ID = 'PAIR' THEN [dbo].[CONVERT_UNIT]('PAIR','PACK',spl.SPARE_PART_CODE,@A_DEPARTMENT)
			      ELSE 1 END
			) * spl.QUANTITY AS QUANTITY,lc.STOCK_CODE AS KHO,spl.ID AS STT,spl.BARCODE,
			(CASE WHEN spl.QUANTITY > 0 THEN 
			(((CASE WHEN spl.UNIT_ID = 'EA' THEN [dbo].[CONVERT_UNIT]('EA','EA',spl.SPARE_PART_CODE,@A_DEPARTMENT)
			      WHEN spl.UNIT_ID = 'PAIR' THEN [dbo].[CONVERT_UNIT]('PAIR','PACK',spl.SPARE_PART_CODE,@A_DEPARTMENT)
			      ELSE 1 END
			) * spl.QUANTITY)/(CEILING((CASE WHEN spl.UNIT_ID = 'EA' THEN [dbo].[CONVERT_UNIT]('EA','EA',spl.SPARE_PART_CODE,@A_DEPARTMENT)
			      WHEN spl.UNIT_ID = 'PAIR' THEN [dbo].[CONVERT_UNIT]('PAIR','PACK',spl.SPARE_PART_CODE,@A_DEPARTMENT)
			      ELSE 1 END
			) * spl.QUANTITY)))
			ELSE 0 END) as QUANTITY_A_UNIT, 
			CEILING((CASE WHEN spl.UNIT_ID = 'EA' THEN [dbo].[CONVERT_UNIT]('EA','EA',spl.SPARE_PART_CODE,@A_DEPARTMENT)
			      WHEN spl.UNIT_ID = 'PAIR' THEN [dbo].[CONVERT_UNIT]('PAIR','PACK',spl.SPARE_PART_CODE,@A_DEPARTMENT)
			      ELSE 1 END
			) * spl.QUANTITY) AS QUANTITY_PRINT_LABEL,
			        (CASE 
					       WHEN spl.[EXPIRED_DATE] = '2199-01-01' THEN null 
						   ELSE spl.[EXPIRED_DATE] END) AS EXPIRED_DATE,
					  [TIME_IN]
			FROM [dbo].[EWIP_LOCATIONS] lc
			    RIGHT JOIN [dbo].[EWIP_SPAREPART_LOCATION] spl ON lc.CODE = spl.LOCATION_CODE AND lc.DEPT_CODE = spl.DEPT_CODE AND lc.STOCK_CODE = spl.STOCK_CODE
				LEFT JOIN [dbo].[EWIP_SPARE_PART] sp ON spl.SPARE_PART_CODE = sp.CODE AND spl.DEPT_CODE = sp.[SP_DEPT_CODE]
				LEFT JOIN [dbo].[EWIP_SPAREPART_CONDITION] spc ON spl.CONDITION_CODE = spc.CODE
			WHERE spl.DEPT_CODE = @A_DEPARTMENT AND spl.STOCK_CODE =@A_STOCK --AND spl.QUANTITY > 0
			ORDER BY lc.[CODE]
		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO