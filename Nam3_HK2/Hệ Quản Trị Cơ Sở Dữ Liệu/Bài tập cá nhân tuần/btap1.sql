CREATE PROC spud_PTBac01
@a INT, @b INT, @c INT
AS
	BEGIN
		IF (@a =0 AND @b=0)
			BEGIN 
				PRINT 'phuong trinh vô số nghiệm'
			END 
		IF (@a !=0 AND @b != 0 )
			BEGIN
				PRINT'phuong trinh vo nghiem'
			END
		IF (@a!=0 )
			BEGIN 
				PRINT'phuong trinh có một nghiệm duy nhất'
			END
	END
GO

EXEC spud_PTBac01 2, 3, 0
