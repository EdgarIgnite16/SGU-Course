CREATE PROC spud_InBangCuuChuong
    @x int
AS
    BEGIN
        DECLARE @i INT = 1
        WHILE @i <= 10
            BEGIN
                DECLARE @kq INT = @x * @i
                PRINT CONCAT(@x, ' x ', @i, ' = ', @kq)
                
                -- tang gia tri
                SET @i = @i + 1
            END    
    END
GO

EXEC spud_InBangCuuChuong 4
