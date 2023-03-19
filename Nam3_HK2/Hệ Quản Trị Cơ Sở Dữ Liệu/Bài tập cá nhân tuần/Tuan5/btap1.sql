CREATE FUNCTION fn_TinhHocBong(@Ma_Sinh_Vien VARCHAR(30))
RETURNS INT
AS
    BEGIN
        DECLARE @TienHocBong FLOAT = 0, @SoMonCoDiemTren8 INT = 0

        SELECT @SoMonCoDiemTren8 = Count(*) FROM KET_QUA KQ
        WHERE KQ.Ma_Sinh_Vien = @Ma_Sinh_Vien AND @Diem >= 8

        IF(@SoMonCoDiemTren8 >= 4)
            BEGIN
                SET @TienHocBong = 400000
                RETURN @TienHocBong
            END

        IF(@SoMonCoDiemTren8 = 3)
            BEGIN
                SET @TienHocBong = 300000
                RETURN @TienHocBong
            END

        IF(@SoMonCoDiemTren8 = 2)
            BEGIN
                SET @TienHocBong = 200000
                RETURN @TienHocBong
            END

            
        -- Trường hợp còn lại
        SET @TienHocBong = 0
        RETURN @TienHocBong
    END
GO