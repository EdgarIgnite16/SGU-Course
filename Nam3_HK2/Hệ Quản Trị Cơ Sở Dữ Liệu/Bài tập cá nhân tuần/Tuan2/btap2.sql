-- Cách 1: DÙNG ALTER(FOR)
CREATE TRIGGER tg_KQ_Sua_AfterFor ON dbo.KET_QUA
FOR UPDATE
AS
	BEGIN	
		DECLARE @MaSinhVien VARCHAR(20), @MaMonHoc VARCHAR(20), @Diem INT

		-- Lấy dữ liệu được nhập vào từ bảng inserted
		SELECT @MaSinhVien = Ma_Sinh_Vien FROM inserted
		SELECT @MaMonHoc = Ma_mon FROM inserted
		SELECT @Diem = Diem FROM inserted

		-- Kiểm tra môn học có tồn tại và mã sinh viên có tồn tại hay không
		IF (EXISTS(SELECT * FROM MON_HOC WHERE Ma_mon = @MaMonHoc) AND EXISTS(SELECT * FROM SINH_VIEN WHERE Ma_sinh_vien = @MaSinhVien))
			-- Kiểm tra xem cột Mã môn và Mã sinh viên có bị cập nhật hay không
			IF(UPDATE(Ma_mon) AND UPDATE(Ma_sinh_vien)) 
				BEGIN
					ROLLBACK TRANSACTION
					PRINT N'Không được thay dổi giá trị Mã sinh viên và mã môn học'
				END
			ELSE
				BEGIN
					-- Kiểm tra xem khoảng điểm thay đổi có trong 0 - 10 hay không
					IF (@Diem >= 0 OR @Diem <= 10)
						BEGIN
							PRINT N'Thay đổi thành công!'
						END
					ELSE
						BEGIN
							ROLLBACK TRANSACTION
							PRINT N'Điểm số phải nằm trong khoảng từ 0 - 10'
						END
				END
		ELSE
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Mã sinh viên hoặc mã môn học không tồn tại!'
			END
	END
GO

-- Cách 2: DÙNG INSTEAD OF
CREATE TRIGGER tg_KQ_Sua_InsteadOf ON dbo.KET_QUA
INSTEAD OF UPDATE
AS
	BEGIN
		DECLARE @MaSinhVien VARCHAR(20), @MaMonHoc VARCHAR(20), @Diem INT

		-- Lấy dữ liệu được nhập vào từ bảng inserted
		SELECT @MaSinhVien = Ma_Sinh_Vien FROM inserted
		SELECT @MaMonHoc = Ma_mon FROM inserted
		SELECT @Diem = Diem FROM inserted

		-- Kiểm tra môn học có tồn tại và mã sinh viên có tồn tại hay không
		IF (NOT EXISTS(SELECT * FROM MON_HOC WHERE Ma_mon = @MaMonHoc) AND EXISTS(SELECT * FROM SINH_VIEN WHERE Ma_sinh_vien = @MaSinhVien))
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Không được phép sửa đổi giá trị của cột Mã sinh viên và Mã môn học'
				RETURN
			END

		-- Kiểm tra xem cột Mã môn và Mã sinh viên có bị cập nhật hay không
		IF (UPDATE(Ma_mon) AND UPDATE(Ma_sinh_vien))
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Không được phép sửa đổi giá trị của cột Mã sinh viên và Mã môn học'
				RETURN
			END

		-- Kiểm tra xem khoảng điểm thay đổi có trong 0 - 10 hay không
		IF (@Diem < 0 OR @Diem > 10)
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Điểm số phải nằm trong khoảng từ 0 - 10'
				RETURN
			END

		-- Xác nhận thay đổi thành công
		PRINT N'Thay đổi thành công'

		-- Thực hiện câu lệnh UPDATE để thực hiện truy vấn cập nhật 
		UPDATE dbo.KET_QUA
		SET Diem = @Diem
		WHERE Ma_sinh_vien = @MaSinhVien AND Ma_mon = @MaMonHoc 
	END
GO


