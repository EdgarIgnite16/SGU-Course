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