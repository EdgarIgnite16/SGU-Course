-- Cách 1: DÙNG ALTER(FOR)
CREATE TRIGGER tg_KQ_Sua_AfterFor ON dbo.KET_QUA
FOR UPDATE
AS
	BEGIN	
		DECLARE @MaSinhVien VARCHAR(20), @MaMonHoc VARCHAR(20), @Diem INT

		SELECT @MaSinhVien = Ma_Sinh_Vien FROM inserted
		SELECT @MaMonHoc = Ma_mon FROM inserted
		SELECT @Diem = Diem FROM inserted

		IF (EXISTS(SELECT * FROM MON_HOC WHERE Ma_mon = @MaMonHoc) AND EXISTS(SELECT * FROM SINH_VIEN WHERE Ma_sinh_vien = @MaSinhVien))
			BEGIN
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
				PRINT N'Không được phép sửa đổi giá trị của cột Mã sinh viên và Mã môn học'
			END
	END
GO

-- Cách 2: DÙNG INSTEAD OF
CREATE TRIGGER tg_KQ_Sua_InsteadOf ON dbo.KET_QUA
INSTEAD OF UPDATE
AS
	BEGIN
		DECLARE @MaSinhVien VARCHAR(20), @MaMonHoc VARCHAR(20), @Diem INT

		SELECT @MaSinhVien = Ma_Sinh_Vien FROM inserted
		SELECT @MaMonHoc = Ma_mon FROM inserted
		SELECT @Diem = Diem FROM inserted

		IF (NOT EXISTS(SELECT * FROM MON_HOC WHERE Ma_mon = @MaMonHoc) AND EXISTS(SELECT * FROM SINH_VIEN WHERE Ma_sinh_vien = @MaSinhVien))
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Không được phép sửa đổi giá trị của cột Mã sinh viên và Mã môn học'
				RETURN
			END

		IF (@Diem < 0 OR @Diem > 10)
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Điểm số phải nằm trong khoảng từ 0 - 10'
				RETURN
			END

		PRINT N'Thay đổi thành công'

		UPDATE dbo.KET_QUA
		SET Diem = @Diem
		WHERE Ma_sinh_vien = @MaSinhVien AND Ma_mon = @MaMonHoc 
	END
GO


