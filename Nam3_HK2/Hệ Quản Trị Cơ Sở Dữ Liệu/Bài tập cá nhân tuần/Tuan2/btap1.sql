-- Cách 1: DÙNG ALTER(FOR)
CREATE TRIGGER tg_SV_Them_AfterFor ON dbo.SINH_VIEN
FOR INSERT
AS
	BEGIN
		DECLARE @MaKhoa VARCHAR(30), @TuoiSinhVien SMALLINT

		-- Lấy thông tin mã khoa và tính tuổi sinh viên được nhập vào
		SELECT @MaKhoa = Ma_khoa FROM inserted
		SELECT @TuoiSinhVien = YEAR(GETDATE()) - YEAR(NG_SINH) FROM inserted

		-- Kiểm tra mã khoa được nhập có tồn tại hay không
		IF(EXISTS(SELECT * FROM KHOA WHERE Ma_Khoa = @MaKhoa)) 
			BEGIN
				-- Kiểm tra tuổi sinh viên phải lớn hơn 18
				IF(@TuoiSinhVien >= 18) 
					BEGIN
						PRINT N'Nhập dữ liệu thành công!'
					END
				ELSE
					BEGIN
						PRINT N'Tuổi sinh viên phải lơn hơn 18!'
						ROLLBACK TRANSACTION
					END	
			END
		ELSE
			BEGIN		
				PRINT N'Mã khoa nhập vào không tồn tại trong bảng khoa!'
				ROLLBACK TRANSACTION
			END
		
	END
GO

-- Cách 2: DÙNG INSTEAD OF
CREATE TRIGGER tg_SV_Them_InsteadOf ON dbo.SINH_VIEN
INSTEAD OF INSERT
AS
	BEGIN
		DECLARE @MaKhoa VARCHAR(20), @TuoiSinhVien SMALLINT, @MaSV VARCHAR(20), @TenSV VARCHAR(20)
		DECLARE @HoSV VARCHAR(20), @GioiTinh SMALLINT, @DiaChi NVARCHAR(50), @NgaySinh DATETIME, @HocBong BOOLEAN

		-- Lấy tất cả thông tin của sinh viên được nhập vào 
		SELECT @MaSV = Ma_Sinh_Vien FROM inserted
		SELECT @HoSV = Ho_Sinh_Vien FROM inserted
		SELECT @TenSV = Ten_Sinh_Vien FROM inserted
		SELECT @NgaySinh = Ngay_Sinh FROM inserted
		SELECT @GioiTinh = Gioi_Tinh FROM inserted
		SELECT @DiaChi = Gioi_Tinh FROM inserted
		SELECT @HocBong = Hoc_bong FROM inserted
		SELECT @MaKhoa = Ma_khoa FROM inserted
		SELECT @TuoiSinhVien = YEAR(GETDATE()) - YEAR(NG_SINH) FROM inserted

		-- Kiểm tra mã khoa được nhập có tồn tại hay không
		IF (NOT EXISTS(SELECT * FROM KHOA WHERE Ma_Khoa = @MaKhoa))
			BEGIN
				ROLLBACK TRANSACTION
				-- RAISERROR(N'Mã khoa không tn tại trong bảng khoa', 16, 1)
				PRINT N'Mã khoa không tồn tại trong bảng khoa'
				RETURN --End
			END

		-- Kiểm tra tuổi sinh viên phải lớn hơn 18
		IF (@TuoiSinhVien < 18)
			BEGIN
				ROLLBACK TRANSACTION
				-- RAISERROR(N'Mã khoa không tồn tại trong bảng khoa', 16, 1)
				PRINT N'Mã khoa không tồn tại trong bảng khoa'
				RETURN
			END
		
		-- Xác nhận thay đổi thành công
		PRINT N'Nhập dữ liệu thành công'
		
		-- Thực hiện câu lệnh INSERT để thực hiện truy vấn thêm mới sinh viên 
		INSERT dbo.SINH_VIEN(Ma_Sinh_Vien, Ho_Sinh_Vien, Ten_Sinh_Vien, Ngay_Sinh, Gioi_Tinh, Dia_Chi, Hoc_bong, Ma_Khoa)
		VALUES (@MaSV, @HoSV, @TenSV, @NgaySinh, @GioiTinh, @DiaChi, @HocBong, @MaKhoa)
	END
GO