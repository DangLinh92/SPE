SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_EQUIPMENT_MAINTAIN@PUT](
@A_ID NVARCHAR(50),
@A_DEPARTMENT  NVARCHAR(50),
@A_EQUIPMENT_CODE NVARCHAR(50),
@A_SPAREPART_CODE NVARCHAR(50),
@A_DATE_MAINTAIN    NVARCHAR(50),
@A_SERIAL_PRE     NVARCHAR(50),
@A_DATE_IN_PRE    NVARCHAR(50),
@A_CONDITION_PRE  NVARCHAR(250),
@A_SERIAL_AFTER   NVARCHAR(50),
@A_DATE_IN_AFTER  NVARCHAR(50),
@A_CONDITION_AFTER NVARCHAR(250),
@A_TIME_MAINTAIN  NVARCHAR(50),
@A_USER   NVARCHAR(50),
@A_USER_UPDATE NVARCHAR(50),
@A_CAUSE_MAINTAIN NVARCHAR(MAX),
@A_IMG_ERROR NVARCHAR(MAX),
@A_DATE_SUCCESS NVARCHAR(50),
@A_GANTRY_ID  NVARCHAR(50),
@A_SEGMENT_ID   NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  
			
			IF @A_DATE_MAINTAIN = ''
			   SET  @A_DATE_MAINTAIN = NULL

			IF @A_DATE_IN_AFTER = ''
			    SET @A_DATE_IN_AFTER = NULL
			  

			IF EXISTS(SELECT * FROM [dbo].[EWIP_EQUIPMENT_MAINTAIN] WHERE [MAINTAIN_ID] = CAST(@A_ID AS INT))
			   BEGIN
					 UPDATE [dbo].[EWIP_EQUIPMENT_MAINTAIN]
					 SET [EQUIPMENT_ID] = @A_EQUIPMENT_CODE,
					     [SPARE_PART_CODE] = @A_SPAREPART_CODE,
						 [SERIAL_PRE] = @A_SERIAL_PRE,
						 [DATE_MAINTAIN] = CAST(@A_DATE_MAINTAIN AS DATE),
						 [MONTH_MAINTAIN] = MONTH(CAST(@A_DATE_MAINTAIN AS DATE)),
						 [YEAR_MAINTAIN] = YEAR(CAST(@A_DATE_MAINTAIN AS DATE)),
						 [WEEK] = DATEPART(WEEK,@A_DATE_MAINTAIN),
						 [QUARTER] = DATEPART(QUARTER,@A_DATE_MAINTAIN),
						 [TIME_MAINTAIN] = CAST(@A_TIME_MAINTAIN AS INT),
						 [CAUSE_MAINTAIN] = @A_CAUSE_MAINTAIN,
						 [USER_MAINTAIN] = @A_USER,
						 [IMAGE_ERROR] = @A_IMG_ERROR,
						 [CONDITION_PRE] = @A_CONDITION_PRE,
						 [DATE_IN_PRE] = @A_DATE_IN_PRE,
						 [SERIAL_AFTER] = @A_SERIAL_AFTER,
						 [CONDITION_AFTER] = @A_CONDITION_AFTER,
						 [DATE_IN_AFTER] = @A_DATE_IN_AFTER,
						 [USER_UPDATE] =@A_USER_UPDATE,
						 [SYS_TIME] = SYSDATETIME(),
						 [DEPT_CODE] = @A_DEPARTMENT,
						 [GANTRY_ID]  = @A_GANTRY_ID,
						 [SEGMENT_ID] = @A_SEGMENT_ID
					WHERE [MAINTAIN_ID] = CAST(@A_ID AS INT)
			    END
			 ELSE
			      BEGIN
						INSERT INTO [dbo].[EWIP_EQUIPMENT_MAINTAIN]
						VALUES(@A_EQUIPMENT_CODE,@A_SPAREPART_CODE,@A_SERIAL_PRE,CAST(@A_DATE_MAINTAIN AS DATE),MONTH(CAST(@A_DATE_MAINTAIN AS DATE)),YEAR(CAST(@A_DATE_MAINTAIN AS DATE)),
						       DATEPART(WEEK,@A_DATE_MAINTAIN),DATEPART(QUARTER,@A_DATE_MAINTAIN),@A_DATE_SUCCESS,CAST(@A_TIME_MAINTAIN AS INT),@A_CAUSE_MAINTAIN,@A_USER,@A_IMG_ERROR,@A_CONDITION_PRE,
							   @A_DATE_IN_PRE,@A_SERIAL_AFTER,@A_CONDITION_AFTER,@A_DATE_IN_AFTER,@A_USER_UPDATE,SYSDATETIME(),@A_DEPARTMENT,@A_GANTRY_ID,@A_SEGMENT_ID)
				  END

			SET @N_RETURN = 0;
			SET @V_RETURN = 'MSG_COM_004';
		END
END TRY
BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO
