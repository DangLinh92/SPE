SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_MRP@GETALL](
@A_DEPARTMENT		NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT MRP.SPAREPART_CODE,SP.NAME_VI,MRP.QUANTITY_NEED_BUY,MRP.UNIT,MRP.DATE_NEED_BUY,MRP.DATE_NEED_FINISH,MRP.DATE_END_ACTUAL,MRP.STATUS,MRP.MRP_CODE,PR.PR_CODE
			FROM  [dbo].[EWIP_MRP] MRP
			INNER JOIN [dbo].[EWIP_PURCHASE_REQUEST] PR ON MRP.MRP_CODE = PR.MRP_CODE AND MRP.DEPT_CODE = PR.DEPT_CODE
			INNER JOIN 	[dbo].[EWIP_SPARE_PART] SP ON SP.CODE = MRP.SPAREPART_CODE AND MRP.DEPT_CODE = SP.SP_DEPT_CODE
			WHERE MRP.[DEPT_CODE] = @A_DEPARTMENT AND MRP.OFF_NOTI <> 'True'  
			ORDER BY mrp.[DATE_NEED_BUY] desc

			select CODE,NAME from [dbo].[EWIP_STATUS_PUR]

			select CODE,NAME_VI from [dbo].[EWIP_SPARE_PART] where SP_DEPT_CODE = @A_DEPARTMENT

			select DISTINCT MRP_CODE from [dbo].[EWIP_MRP] where DEPT_CODE = @A_DEPARTMENT	AND MRP_CODE != '' AND MRP_CODE IS NOT NULL
       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
