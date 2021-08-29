SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE  FUNCTION [dbo].[CHAR_TO_MONTHYEAR]
(
 @CHARDATETIME VARCHAR(14)
) 


RETURNS varchar(24)


AS 


 BEGIN 
  DECLARE @ReturnDate varchar(24)

  IF LEN(@CHARDATETIME) = 14
	BEGIN
  
	  SET @ReturnDate = 
		 left(@CHARDATETIME,4) + '-' 
		 + substring(@CHARDATETIME,5,2) +'-'
		 + substring(@CHARDATETIME,7,2) +' '
		 + substring(@CHARDATETIME,9,2) +':'
		 + substring(@CHARDATETIME,11,2) + ':' 
		 + right(@CHARDATETIME,2)
	END
  ELSE IF LEN(@CHARDATETIME) = 8
    BEGIN
	  SET @ReturnDate = 
		 left(@CHARDATETIME,4) + '-' 
		 + substring(@CHARDATETIME,5,2) +'-'
		 + substring(@CHARDATETIME,7,2);
	END
  ELSE
  BEGIN
      SET @ReturnDate = '';
  END;

  RETURN @ReturnDate
 END

GO