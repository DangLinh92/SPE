﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_BOM_SPAREPART@PUT](
@A_DEPARTMENT		NVARCHAR(50),
@A_SPARE_PART_CODE  NVARCHAR(50),
@A_QUANTITY_IN_PACK NVARCHAR(50),
@A_UNIT             NVARCHAR(50),
@A_WORKING_DAY      NVARCHAR(50),
@A_LINE             NVARCHAR(50),
@A_WORKING_A_LINE   NVARCHAR(50),
@A_WORKING_A_LINE_PACK NVARCHAR(50),
@A_MONTHLY_USING    NVARCHAR(50),
@A_RATE             NVARCHAR(20),
@A_TIME_FROM        NVARCHAR(50),
@A_TIME_TO          NVARCHAR(50),
@N_RETURN			int				OUTPUT,
@V_RETURN			NVARCHAR(4000)	OUTPUT
)
AS

BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			IF @A_TIME_FROM = '' OR @A_TIME_FROM IS NULL
			         SET @A_TIME_FROM = GETDATE()

			IF @A_TIME_TO = '' OR @A_TIME_TO IS NULL
			         SET @A_TIME_TO = DATEADD(month,1,GETDATE())

			DELETE FROM [dbo].[EWIP_BOM]
			WHERE SPARE_PART_CODE = @A_SPARE_PART_CODE AND DEPT_CODE = @A_DEPARTMENT

			INSERT INTO [dbo].[EWIP_BOM]
			VALUES(@A_SPARE_PART_CODE,@A_QUANTITY_IN_PACK,@A_UNIT,@A_WORKING_DAY,@A_LINE,@A_WORKING_A_LINE,@A_MONTHLY_USING,@A_DEPARTMENT,@A_WORKING_A_LINE_PACK,CAST(@A_RATE AS float),CAST(@A_TIME_FROM as date),CAST(@A_TIME_TO AS date))

			DECLARE @CHECK int 
			DECLARE @DAY int

			SET @DAY = DAY(CAST(@A_TIME_FROM AS date))

			SELECT @CHECK = COUNT(*) 
			FROM  [dbo].[EWIP_BOM_BY_MONTH] AS BOMM
			INNER JOIN [dbo].[EWIP_BOM] BOM ON BOM.DEPT_CODE = BOMM.[DEPT_CODE] AND BOM.SPARE_PART_CODE = BOMM.[SPARE_PART_CODE]
			WHERE BOMM.[DEPT_CODE] = @A_DEPARTMENT AND BOMM.[SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
					DATEFROMPARTS(BOMM.[YEART],BOMM.[MONTH],@DAY) >= CAST(@A_TIME_FROM AS date) AND 
					DATEFROMPARTS(BOMM.[YEART],BOMM.[MONTH],@DAY) <= CAST(@A_TIME_TO AS date)

			IF @CHECK > 0
			  BEGIN
					UPDATE [dbo].[EWIP_BOM_BY_MONTH]
					SET [WORKING_A_MONTH] = @A_MONTHLY_USING ,[UNIT] = 'PACK',[RATE] = @A_RATE,[WORKING_DAY_NUMBER] = @A_WORKING_DAY,[WORKING_LINE_NUMBER]=@A_LINE,[WORKING_A_LINE_PACK] = @A_WORKING_A_LINE_PACK
					WHERE [DEPT_CODE] = @A_DEPARTMENT AND [SPARE_PART_CODE] = @A_SPARE_PART_CODE AND 
					DATEFROMPARTS([YEART],[MONTH],@DAY) >= CAST(@A_TIME_FROM AS date) AND 
					DATEFROMPARTS([YEART],[MONTH],@DAY) <= CAST(@A_TIME_TO AS date)
			  END
			ELSE
			  BEGIN
			        
					DECLARE @CountMonth int = DATEDIFF(month, CAST(@A_TIME_FROM AS date),CAST(@A_TIME_TO AS date))

					WHILE @CountMonth >= 0
						BEGIN 

						      DECLARE @newDate date = DATEADD(month,@CountMonth, CAST(@A_TIME_FROM AS date))
							  DECLARE @year nvarchar(4) = YEAR(@newDate)
							  DECLARE @month nvarchar(2) = MONTH(@newDate)

							  INSERT INTO [dbo].[EWIP_BOM_BY_MONTH]
							  VALUES(@A_SPARE_PART_CODE,@A_MONTHLY_USING,'PACK',@A_DEPARTMENT,@A_RATE,@month,@year,@A_WORKING_A_LINE_PACK,@A_WORKING_DAY,@A_LINE)

							  SET @CountMonth = @CountMonth - 1
						 END
			  END

       END
	SET @N_RETURN = 0;
	SET @V_RETURN = 'MSG_COM_004';
END TRY
	BEGIN CATCH
  SET @N_RETURN = ERROR_NUMBER();
  SET @V_RETURN = ERROR_MESSAGE();
END CATCH
GO