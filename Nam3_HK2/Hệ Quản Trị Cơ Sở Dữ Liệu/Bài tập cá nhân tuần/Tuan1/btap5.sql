-- Vì ta không có dữ liệu thực tế nên bài code được thực hiện trên 100% là ý tưởng

CREATE PROC sp_KetQua_Mon 
    @maSinhVien varchar(20), 
    @maMonHoc varchar(20)
AS
    BEGIN
        IF (EXISTS(SELECT * FROM SinhVien SV WHERE SV.MaSV = @maSinhVien))
            BEGIN
                -- Khởi tạo biến
                DECLARE @DiemSoCuaSinhVien FLOAT 
                DECLARE @TenSinhVien NVARCHAR(30)
                DECLARE @TenMonHoc NVARCHAR(30)
                
                -- Gán giá trị ta select được vào biến vừa được khởi tạo
                -- Tên Sinh Viên
                SELECT @TenSinhVien = SV.TenSinhVien FROM SinhVien SV
                WHERE SV.MaSV = @maSinhVien

                -- Tên Môn Học
                SELECT @TenMonHoc = MH.TenMonHoc FROM MonHoc MH
                WHERE MH.MaMH = @maMonHoc

                -- Điểm số
                SELECT @DiemSoCuaSinhVien = KQ.Diem FROM KetQua KQ
                WHERE KQ.MaSV = @maSinhVien AND KQ.MaMH = @maMonHoc

                IF (@DiemSoCuaSinhVien > 5) 
                    BEGIN 
                        PRINT CONCAT(@TenSinhVien, " | ", @TenMonHoc, " | ", N'Đạt', " | ")
                    END
                ELSE
                    BEGIN
                        PRINT CONCAT(@TenSinhVien, " | ", @TenMonHoc, " | ", N'Chưa Đạt', " | ")
                    END
            END
        ELSE 
            BEGIN
                PRINT N'Không tồn tại sinh viên này'
            END
    END 
GO

-- Thực hiện hàm
EXEC sp_KetQua_Mon N'SV001', N'MH001' -- Giả định