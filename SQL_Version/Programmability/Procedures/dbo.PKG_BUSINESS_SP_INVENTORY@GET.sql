SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SP_INVENTORY@GET](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT inv.[SPARE_PART_CODE] AS CODE,sp.NAME_VI,sp.NAME_KR,sp.SPECIFICATIONS as SPECIFICATION,
			     [dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)* inv.[QUANTITY] AS [QUANTITY],
				 [dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)*inv.QUANTITY_REAL as QUANTITY_REAL,
			     ([dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)* inv.[QUANTITY] - [dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)*inv.QUANTITY_REAL) as DIFFERENCE_QUANTITY,
			     [dbo].[CONVERT_UNIT](mins.UNIT_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)* mins.MIN_STOCK AS MIN_STOCK ,
				 'PACK' as UNIT,sp.VENDER_ID as VENDER_NAME,inv.STOCK_CODE as KHO,inv.ID,mins.[RATE_ALARM]
			FROM [dbo].[EWIP_SPAREPART_INVENTORY] inv
			INNER JOIN [dbo].[EWIP_SPARE_PART] sp ON inv.SPARE_PART_CODE = sp.CODE AND inv.DEPT_CODE = sp.SP_DEPT_CODE
			LEFT JOIN [dbo].[EWIP_SETUP_MINSTOCK] mins ON inv.SPARE_PART_CODE = mins.SPARE_PART_CODE AND inv.DEPT_CODE = mins.DEPT_CODE AND inv.STOCK_CODE =mins.STOCK_CODE
			WHERE inv.DEPT_CODE = @A_DEPARTMENT
			GROUP BY inv.ID,inv.[SPARE_PART_CODE] ,sp.NAME_VI,sp.NAME_KR,sp.SPECIFICATIONS ,inv.UNIT_IN_CODE,inv.[QUANTITY],inv.QUANTITY_REAL ,mins.MIN_STOCK,sp.VENDER_ID ,inv.STOCK_CODE,mins.[RATE_ALARM],mins.UNIT_CODE
			ORDER BY ([dbo].[CONVERT_UNIT](inv.UNIT_IN_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)* ISNULL(inv.[QUANTITY],0) - [dbo].[CONVERT_UNIT](mins.UNIT_CODE,'PACK',inv.SPARE_PART_CODE,@A_DEPARTMENT)* ISNULL(mins.MIN_STOCK,-9999999))
			
			SELECT sp.CODE,sp.NAME_VI
			FROM EWIP_SPARE_PART sp 
			     INNER JOIN EWIP_SPARE_PART_DEPT spd ON sp.CODE = spd.SPARE_PART_CODE AND spd.DEPT_CODE = sp.SP_DEPT_CODE
			where sp.SP_DEPT_CODE = @A_DEPARTMENT
			ORDER BY SP.ID DESC;

			SELECT CODE,NAME FROM [dbo].[EWIP_STOCK] WHERE DEPT_CODE = @A_DEPARTMENT

			SELECT CODE,NAME FROM [dbo].[EWIP_UNITS]

			SELECT PO_ID,[TITLE] FROM [dbo].[EWIP_ORDER]

			SELECT [CODE],[NAME] FROM [dbo].[EWIP_TYPE_IN_OUT]

			SELECT [FROM],[TO],[RATE] 
			FROM  [dbo].[EWIP_EXCHANGE_RATE]
			WHERE [FROM] = 'USD' AND [TO] = 'VN'

		END

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO