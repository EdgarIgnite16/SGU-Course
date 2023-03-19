-- Bài tập 1
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

--------------------------------------------------------------------------------
-- Bài tập 2
CREATE FUNCTION fn_DSXepHang(@k INT)
RETURNS TABLE
AS
        RETURN SELECT TOP(@k) SV.Ten_sinh_vien FROM SINH_VIEN SV, KET_QUA KQ
        WHERE SV.Ma_Sinh_Vien = KQ.Ma_sinh_vien
        GROUP BY KQ.Ma_sinh_vien, SV.Ten_sinh_vien
        ORDER BY SUM(KQ.Diem) / COUNT(KQ.Ma_mon_hoc) DESC 
GO 

--------------------------------------------------------------------------------
-- Bài tập 3
CREATE FUNCTION fn_DSKhongDat(@nguong FLOAT)
RETURNS TABLE
AS
    RETURN SELECT SV.MaSV, TenSV, AVG(DIEM) AS DiemTB 
    FROM SINH_VIEN SV, KET_QUA KQ 
    WHERE SV.MaSV = KQ.MaSV 
    GROUP BY SV.MaSV, TenSV
    HAVING AVG(Diem) <= @nguong
GO

--------------------------------------------------------------------------------
-- Bài tập 4
-- Tạo 1 Function Xử lí Rating điểm số đầu vào => Trả Xếp loại
CREATE FUNCTION fn_Rating(@DiemTrungBinh FLOAT) 
RETURNS VARCHAR(20)
AS
    BEGIN
        IF(@DiemTrungBinh >= 9)
            BEGIN
                RETURN N'loại Xuất xắc'
            END

        IF(@DiemTrungBinh >= 8 AND @DiemTrungBinh < 9)
            BEGIN
                RETURN N'loại Giỏi'
            END

        IF(@DiemTrungBinh >= 7 AND @DiemTrungBinh < 8)
            BEGIN
                RETURN N'loại Khá'
            END

        IF(@DiemTrungBinh >= 6.5 AND @DiemTrungBinh < 7)
            BEGIN
                RETURN N'loại Trung bình - Khá'
            END

        IF(@DiemTrungBinh >= 5 AND @DiemTrungBinh < 6.5)
            BEGIN
                RETURN N'loại Trung bình'
            END

        -- Trường hợp còn lại
        RETURN N'loại Yếu/Kém'
    END
GO

-- Hàm xử lí trả về bảng xếp loại
CREATE FUNCTION fn_XepLoai()
RETURNS TABLE
AS 
    RETURN SELECT SV.Ten_sinh_vien, AVG(KQ.Diem), fn_Rating(AVG(KQ.Diem)) FROM SINH_VIEN SV, KET_QUA KQ
            WHERE SV.Ma_sinh_vien = KQ.Ma_sinh_vien
            GROUP BY KQ.Ma_sinh_vien
GO