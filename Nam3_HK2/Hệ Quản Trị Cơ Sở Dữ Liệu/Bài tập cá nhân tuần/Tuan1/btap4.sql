-- Vì ta không có dữ liệu thực tế nên bài code được thực hiện trên 100% là ý tưởng

CREATE PROC spud_KetQuaHocTap @maSinhVien varchar(20)
AS
    BEGIN
        IF (EXISTS(SELECT * FROM SinhVien SV WHERE SV.MaSV = @maSinhVien))
            BEGIN
                -- In ra bảng
                SELECT SV.TenSinhVien as N'Tên Sinh Viên', MH.TenMon as N'Tên Môn Học', KQ.Diem as N'Điểm' 
                FROM SinhVien SV, KetQua KQ, MonHoc MH
                WHERE SV.MaSV = KQ.MaSV AND KQ.MaMH = MH.MaMH AND SV.MaSV = @maSinhVien
            END
        ELSE 
            BEGIN
                PRINT N'Không tồn tại sinh viên này'
            END
    END 
GO

-- Thực hiện hàm
EXEC spud_KetQuaHocTap N'SV001' -- Giả định