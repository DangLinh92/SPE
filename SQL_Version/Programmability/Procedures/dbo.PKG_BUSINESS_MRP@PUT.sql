SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_MRP@PUT](
@A_ID     NVARCHAR(20),
@A_DEPARTMENT		NVARCHAR(50),
@A_MRP_CODE         NVARCHAR(50),
@A_SPAREPART_CODE  NVARCHAR(50),
@A_QUANTITY_NEED_BUY NVARCHAR(50),
@A_UNIT             NVARCHAR(50),
@A_DATE_NEED_BUY    NVARCHAR(50),
@A_DATE_NEED_FINISH  NVARCHAR(50),
@A_DATE_END_ACTUAL  NVARCHAR(50),
@A_USER             NVARCHAR(50),
@A_OFF_NOTI         NVARCHAR(50),
@A_STATUS           NVARCHAR(50),
@A_DATE_NEED_REQUIRED  NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN

			DECLARE @CHECK INT = 0
		    -- MRP-20210728-001
		   
		   IF @A_ID != '' AND @A_ID IS NOT NULL 
				SELECT @CHECK = COUNT(*) 
				FROM [dbo].EWIP_MRP
				WHERE ID = @A_ID

				  IF @A_DATE_NEED_BUY = '' SET @A_DATE_NEED_BUY =  NULL
				  IF @A_DATE_NEED_FINISH = '' SET @A_DATE_NEED_FINISH =  NULL
				  IF @A_DATE_END_ACTUAL = '' SET @A_DATE_END_ACTUAL =  NULL
				  IF @A_DATE_NEED_REQUIRED = '' SET @A_DATE_NEED_REQUIRED =  NULL

		   IF @CHECK > 0
				BEGIN
			      UPDATE [dbo].[EWIP_MRP]
				  SET [SPAREPART_CODE] = @A_SPAREPART_CODE,
				       [QUANTITY_NEED_BUY]= CAST(@A_QUANTITY_NEED_BUY AS float),
					   [UNIT] = @A_UNIT,
					   [STATUS] = @A_STATUS,
					   [MRP_CODE] = @A_MRP_CODE,
					   [DATE_NEED_BUY] = CAST(@A_DATE_NEED_BUY AS DATE),
					   [DATE_NEED_FINISH] = CAST(@A_DATE_NEED_FINISH AS DATE),
					   [DATE_END_ACTUAL]= CAST(@A_DATE_END_ACTUAL AS DATE),
					   [USER_UPDATE] = @A_USER,
					   [DATE_UPDATE] = GETDATE(),
					   [OFF_NOTI] = @A_OFF_NOTI,
					  [DATE_NEED_REQUIRED] =  CAST(@A_DATE_NEED_REQUIRED AS date)
				  WHERE ID = @A_ID
				END
			 ELSE
			    BEGIN
						INSERT INTO [dbo].[EWIP_MRP]
						VALUES(@A_SPAREPART_CODE,CAST(@A_QUANTITY_NEED_BUY AS float),@A_UNIT,@A_STATUS,@A_MRP_CODE,@A_DEPARTMENT,CAST(@A_DATE_NEED_BUY AS DATE),CAST(@A_DATE_NEED_FINISH AS DATE),CAST(@A_DATE_END_ACTUAL AS DATE),@A_USER,GETDATE(),@A_OFF_NOTI,CAST(@A_DATE_NEED_REQUIRED AS date))
				END

       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH

SELECT CAST('' AS date)
GO