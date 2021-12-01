SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PKG_BUSINESS_SYNC_EQUIPEMNT_SEGMENT@DAILY_GET]
AS
BEGIN TRY
		BEGIN
		    SET NOCOUNT OFF;  

			DECLARE @A_MACHINE  NVARCHAR(100)
			DECLARE @A_GantryID  NVARCHAR(100)
			DECLARE @A_SegmentID  NVARCHAR(100)
			DECLARE @A_ID INT
			DECLARE @A_SERIAL VARCHAR(50)
			DECLARE @A_DATE_IN VARCHAR(50)

			BEGIN TRAN
			DECLARE cursorMachine CURSOR LOCAL FOR
			SELECT DISTINCT E.[EQUIPMENT_NAME],M.[GANTRY_ID],M.[SEGMENT_ID],MAINTAIN_ID
			FROM [dbo].[EWIP_EQUIPMENT_MAINTAIN] M
			INNER JOIN [dbo].[EWIP_EQUIPMENT] E ON M.EQUIPMENT_ID = E.EQUIPMENT_ID
			WHERE M.[SERIAL_AFTER] IS NULL OR M.[SERIAL_AFTER] = ''

			OPEN cursorMachine

			FETCH NEXT FROM cursorMachine
			INTO @A_MACHINE,@A_GantryID,@A_SegmentID,@A_ID

			WHILE @@FETCH_STATUS = 0
				BEGIN
				   SET @A_SERIAL = ''
				   SET @A_DATE_IN = ''

					SELECT TOP 1 @A_SERIAL = [SerialNumber],@A_DATE_IN = [DateOfLastMaintenance] 
					FROM WHNP1.[dbo].[ASM_SEGMENT]
					WHERE [MachineName] = @A_MACHINE AND 
					      [GantryID] = @A_GantryID AND 
						  [SegmentID] = @A_SegmentID
                    ORDER BY [InputTime] DESC 

					IF @A_SERIAL != '' AND @A_SERIAL IS NOT NULL
					   BEGIN
								UPDATE [dbo].[EWIP_EQUIPMENT_MAINTAIN]
								SET [SERIAL_AFTER] = @A_SERIAL ,
								    [DATE_IN_AFTER] = CAST(REPLACE(@A_DATE_IN,'.','/') AS DATE),
									[SYS_TIME] = SYSDATETIME()
								WHERE [MAINTAIN_ID] = @A_ID
					   END
					
					FETCH NEXT FROM cursorMachine
					INTO @A_MACHINE,@A_GantryID,@A_SegmentID,@A_ID
				END

			CLOSE cursorMachine
			DEALLOCATE cursorMachine
		END
	COMMIT TRAN
END TRY
	BEGIN CATCH
  ROLLBACK TRAN
END CATCH
GO