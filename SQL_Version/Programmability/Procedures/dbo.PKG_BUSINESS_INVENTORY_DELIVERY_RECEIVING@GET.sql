﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_INVENTORY_DELIVERY_RECEIVING@GET](
@A_DEPT_CODE NVARCHAR(50),
@A_STOCK_CODE NVARCHAR(50),
@N_RETURN	int				OUTPUT,
@V_RETURN	NVARCHAR(4000)	OUTPUT
)
AS
BEGIN TRY
		    SET NOCOUNT OFF;  
			SELECT * FROM
			(SELECT IDR.[IN_OUT],MONTH(IDR.[DATE]) AS [MONTH],YEAR(IDR.[DATE]) AS [YEAR],IDR.[DATE] AS CREATE_DATE,IDR.[TIME_INPUT],IDR.CODE_NO AS [STOCK_IN_OUT_CODE],IDR.[STOCK_CODE],INO.NAME,IDR.ORDER_CODE,IDR.USER_CREATE,IDR.[DELIVERET_RECEIVER],IDR.STATUS
			FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR 
			INNER join [dbo].[EWIP_SP_STOCKIN] SPIN ON IDR.CODE_NO = SPIN.STOCK_IN_CODE
			left join [dbo].[EWIP_TYPE_IN_OUT] INO ON SPIN.TYPE_IN_CODE = INO.CODE
			WHERE IDR.[DEPT_CODE] = @A_DEPT_CODE AND IDR.STOCK_CODE = @A_STOCK_CODE
			UNION
			SELECT IDR.[IN_OUT],MONTH(IDR.[DATE]) AS [MONTH],YEAR(IDR.[DATE]) AS [YEAR],IDR.[DATE] AS CREATE_DATE,IDR.[TIME_INPUT],IDR.CODE_NO AS [STOCK_IN_OUT_CODE],IDR.[STOCK_CODE],INO1.NAME,IDR.ORDER_CODE,IDR.USER_CREATE,IDR.[DELIVERET_RECEIVER],IDR.STATUS
			FROM [dbo].[EWIP_INVENTORY_DELIVERY_RECEIVING] IDR 
			INNER join [dbo].[EWIP_STOCK_OUT] SO ON SO.STOCK_OUT_CODE = IDR.CODE_NO
			left join [dbo].[EWIP_TYPE_IN_OUT] INO1 ON SO.TYPE_OUT_CODE = INO1.CODE
			WHERE IDR.[DEPT_CODE] = @A_DEPT_CODE AND IDR.STOCK_CODE = @A_STOCK_CODE) AS SUB
			ORDER BY SUB.CREATE_DATE DESC,ISNULL(SUB.TIME_INPUT,'00:00:00') DESC

	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

GO