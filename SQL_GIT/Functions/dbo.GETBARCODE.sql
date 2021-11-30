SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GETBARCODE] 
(
	@A_LOCATION  NVARCHAR(50),
	@A_SPAREPART  NVARCHAR(50),
	@A_CONDITION  NVARCHAR(50)
)
RETURNS NVARCHAR(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @BARCODE NVARCHAR(50)

	SET @BARCODE = CASE 
				          WHEN @A_LOCATION = '' OR @A_LOCATION IS NULL THEN  CASE 
					                                                                WHEN @A_CONDITION = 'NG' THEN @A_SPAREPART+'.NG'
																					ELSE @A_SPAREPART
																				END
							ELSE 
								CASE  
										WHEN @A_CONDITION = 'NG' THEN @A_SPAREPART+'.'+@A_LOCATION+'.NG'
										ELSE @A_SPAREPART+'.'+@A_LOCATION
								END
				      END

	-- Return the result of the function
	RETURN @BARCODE

END
GO
