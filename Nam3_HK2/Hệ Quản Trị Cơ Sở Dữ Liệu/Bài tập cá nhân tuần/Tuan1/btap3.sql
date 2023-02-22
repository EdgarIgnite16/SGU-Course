-- Vì ta không có dữ liệu thực tế nên bài code được thực hiện trên 100% là ý tưởng

CREATE PROC spud_SoLuongSV @tenKhoa nvarchar(50)
AS
    BEGIN
        IF (EXISTS(SELECT * FROM Khoa K WHERE K.TenKhoa = @tenKhoa))
            BEGIN
                IF (EXISTS(SELECT * FROM Khoa K WHERE K.SoLuong >= 100 AND K.TenKhoa = @tenKhoa))
                    BEGIN
                        PRINT N'Đã tuyển sinh đủ'
                    END
                ELSE
                    BEGIN
                        PRINT N'Cần tuyển thêm'
                    END
            END
        ELSE 
            BEGIN
                PRINT N'Không tồn tại tên khoa này'
            END
    END 
GO

-- Thực hiện hàm
EXEC spud_SoLuongSV N'Khoa Toán' -- Giả định