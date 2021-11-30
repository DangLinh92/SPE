SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SAP_PO_PR@GET](
@A_DEPARTMENT		NVARCHAR(50),
@A_PO_ID_SYS        NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			SELECT DISTINCT 
			PR.[PR_CODE],
			[MRP_CODE],
			SPO.PO_ID,
			SPO.SAP_PO_ID,
			VENDOR_ID,
			PR.SPAREPART_CODE,
			QUANTITY_NEED_BUY,
			UNIT,
			PR.STATUS,
			PRICE_VN,
			PRICE_US,
			PR.[DATE_CREATE],
			PR.[DATE_NEED_FINISH],
			PR.[USER_UPDATE],PR.[DATE_UPDATE]
			FROM [dbo].[EWIP_PURCHASE_REQUEST_DETAIL] PR
			LEFT JOIN [dbo].[EWIP_ORDER_PR] OPR ON PR.PR_CODE = OPR.PR_CODE AND PR.DEPT_CODE = OPR.DEPT_CODE
			LEFT JOIN [dbo].[EWIP_SAP_PO] SPO ON OPR.PO_ID = SPO.PO_ID AND PR.VENDOR_ID = SPO.VENDOR
			WHERE PR.DEPT_CODE = @A_DEPARTMENT AND OPR.PO_ID = @A_PO_ID_SYS
			ORDER BY PR.[DATE_CREATE] DESC,PR.[DATE_NEED_FINISH] ASC
        END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
