-- Thêm một cột vào trong bảng KHOA
ALTER TABLE KHOA
ADD Tong_so_SV INT
GO

-- Tạo một view bao gồm các thông tin mã sinh viên, họ tên, giới tính, mã khoa
CREATE VIEW vw_SINH_VIEN AS
SELECT SV.Ma_sinh_vien, Concat(SV.Ho_sinh_vien, ' ', SV.Ten_sinh_vien) 'Ho_ten', SV.Ma_khoa FROM SINH_VIEN SV
GO

-- Note: CHỉ có trường hợp trigger INSTEAD OF thì mới có thể sử dụng được trên VIEW 
-- Tạo trigger cho 3 trường hợp thêm xóa, sửa (insert || delete || update)
-- Trigger cho trường hợp Thêm (Insert)
CREATE TRIGGER tg_vwSV_Them ON vw_SINH_VIEN
INSTEAD OF INSERT
AS 
    BEGIN
        DECLARE @MaKhoa VARCHAR(10), @SoLuongSV INT

        -- Lấy thông tin: Mã khoa của sinh viên vừa Insert vào trong
        SELECT @MaKhoa = Ma_khoa FROM inserted
        
        IF (EXISTS(SELECT * FROM dbo.KHOA K WHERE K.Ma_Khoa = @MaKhoa))
            BEGIN
                PRINT N'Thông tin nhập vào chính xác!'
                PRINT N'Cập nhật tăng số lượng sinh viên trong khoa!'

                -- Lấy số lượng sinh viên của khoa hiện tại ra trước
                SELECT @SoLuongSV = K.Tong_so_SV FROM KHOA K WHERE K.MA_Khoa = @MaKhoa

                -- Tăng số lượng sinh viên lên 1
                SET @SoLuongSV = @SoLuongSV + 1

                -- Thực hiện lại câu lệnh update số lượng sinh viên
                UPDATE dbo.KHOA SET Tong_so_SV = @SoLuongSV
                WHERE Ma_Khoa = @MaKhoa
            END
        ELSE
            BEGIN
                PRINT N'Sinh viên nhập vào có mã khoa không hợp lệ!'
                ROLLBACK TRANSACTION
            END
    END
GO

-- Trigger cho trường hợp Xóa (Delete)
CREATE TRIGGER tg_vwSV_Xoa ON vw_SINH_VIEN
INSTEAD OF DELETE
AS 
    BEGIN
        DECLARE @MaKhoa VARCHAR(10), @SoLuongSV INT

        -- Lấy thông tin: Mã khoa của sinh viên vừa Delete vào trong
        SELECT @MaKhoa = Ma_khoa FROM deleted
        
        IF (EXISTS(SELECT * FROM dbo.KHOA K WHERE K.Ma_Khoa = @MaKhoa))
            BEGIN
                PRINT N'Thông tin nhập vào chính xác!'
                PRINT N'Cập nhật giảm số lượng sinh viên trong khoa!'

                -- Lấy số lượng sinh viên của khoa hiện tại ra trước
                SELECT @SoLuongSV = K.Tong_so_SV FROM KHOA K WHERE K.MA_Khoa = @MaKhoa

                -- Giảm số lượng sinh viên xuống 1
                SET @SoLuongSV = @SoLuongSV - 1

                -- Thực hiện lại câu lệnh update số lượng sinh viên
                UPDATE dbo.KHOA SET Tong_so_SV = @SoLuongSV
                WHERE Ma_Khoa = @MaKhoa
            END
        ELSE
            BEGIN
                PRINT N'Sinh viên nhập vào có mã khoa không hợp lệ!'
                ROLLBACK TRANSACTION
            END
    END
GO

-- Trigger cho trường hợp Sửa (Update)
CREATE TRIGGER tg_vwSV_Sua ON vw_SINH_VIEN
INSTEAD OF UPDATE
AS 
    BEGIN
        DECLARE @MaSinhVien VARCHAR(10), @MaKhoaTruoc VARCHAR(10), @MaKhoaSau VARCHAR(10)
        DECLARE @SoLuongSVMaTruoc INT, @SoLuongSVMaSau INT
            
        -- Lấy thông tin mã khoa muốn thay đổi
        SELECT @MaKhoaSau = Ma_khoa FROM inserted
        SELECT @MaSinhVien = Ma_Sinh_Vien FROM inserted
        SELECT @MaKhoaTruoc = Ma_Khoa FROM vw_SINH_VIEN WHERE Ma_sinh_vien = @MaSinhVien

        -- Kiểm tra mã khoa nhập vào có tồn tại hay không
        IF (EXISTS(SELECT * FROM dbo.KHOA K WHERE K.Ma_Khoa = @MaKhoaSau))
            BEGIN
                PRINT N'Thông tin nhập vào chính xác!'
                PRINT N'Cập nhật thay đổi số lượng sinh viên của khoa!'

                -- Cập nhật số lượng sinh viên Của khoa thay đổi trước
                -- Lấy số lượng sinh viên hiện tại của Mã khoa trước đó
                SELECT @SoLuongSVMaTruoc = K.Tong_so_SV FROM KHOA K WHERE K.MA_Khoa = @MaKhoaTruoc
                SET @SoLuongSVMaTruoc = @SoLuongSVMaTruoc - 1 -- Giảm số lượng sinh viên xuống 1

                -- Cập nhật số lượng sinh viên Của khoa thay đổi sau
                -- Lấy số lượng sinh viên hiện tại của Mã khoa sau đó
                SELECT @SoLuongSVMaSau = K.Tong_so_SV FROM KHOA K WHERE K.MA_Khoa = @MaKhoaSau
                SET @SoLuongSVMaSau = @SoLuongSVMaSau + 1 -- Tăng số lượng sinh viên lên 1

                --------------------------------------------------------------------------------

                -- Thực hiện lại câu lệnh update số lượng sinh viên cho khoa trước và sau
                UPDATE dbo.KHOA SET Tong_so_SV = @SoLuongSVMaTruoc
                WHERE Ma_Khoa = @MaKhoaTruoc

                UPDATE dbo.KHOA SET Tong_so_SV = @SoLuongSVMaSau
                WHERE Ma_Khoa = @MaKhoaSau
            END
        ELSE
            BEGIN
                PRINT N'Sinh viên nhập vào có mã khoa không hợp lệ!'
                ROLLBACK TRANSACTION
            END
    END
GO

