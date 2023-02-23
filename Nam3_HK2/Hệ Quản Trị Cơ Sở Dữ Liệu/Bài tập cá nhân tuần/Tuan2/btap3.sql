-- Cách 1: DÙNG ALTER(FOR)
CREATE TRIGGER tg_SV_Xoa_AfterFor ON dbo.SINH_VIEN
FOR DELETE
AS
	BEGIN
		DECLARE @MaSinhVien VARCHAR(20)
		SELECT @MaSinhVien = Ma_sinh_vien FROM deleted

		IF(EXISTS(SELECT * FROM SINH_VIEN WHERE Ma_sinh_vien = @MaSinhVien))
			BEGIN
				DECLARE @CountMonHocDiemDuoi5 INT = 0
				SELECT @CountMonHocDiemDuoi5 = COUNT(*) FROM dbo.KET_QUA
				WHERE Ma_sinh_vien = @MaSinhVien AND Diem < 5

				IF(@CountMonHocDiemDuoi5 < 4) 
					BEGIN
						PRINT N'Có thể xóa sinh viên này!'
						PRINT N'Xóa sinh viên thành công!'

						ROLLBACK TRANSACTION
						
						DELETE FROM dbo.KET_QUA
						WHERE Ma_sinh_vien = @MaSinhVien

						DELETE FROM dbo.SINH_VIEN
						WHERE Ma_sinh_vien = @MaSinhVien
					END
				ELSE
					BEGIN
						ROLLBACK TRANSACTION
						PRINT N'Không thể xóa sinh viên có số môn dưới 5 điểm vượt quá 4 môn'
					END
			END
		ELSE
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Không tìm thấy sinh viên!'
			END
	END
GO

-- Cách 2: DÙNG INSTEAD OF
CREATE TRIGGER tg_SV_Xoa_InsteadOf ON dbo.SINH_VIEN
INSTEAD OF DELETE
AS
	BEGIN
		DECLARE @MaSinhVien VARCHAR(20)
		SELECT @MaSinhVien = Ma_sinh_vien FROM deleted
		
		IF(NOT EXISTS(SELECT * FROM SINH_VIEN WHERE Ma_sinh_vien = @MaSinhVien))
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Không tìm thấy sinh viên!'
			END

		IF((SELECT COUNT(*) FROM dbo.KET_QUA WHERE Ma_sinh_vien = @MaSinhVien AND Diem < 5) >= 4)
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Không thể xóa sinh viên có số môn dưới 5 điểm vượt quá 4 môn'
			END


		PRINT N'Xóa sinh viên thành công!'
		DELETE FROM dbo.KET_QUA
		WHERE Ma_sinh_vien = @MaSinhVien
		
		DELETE FROM dbo.SINH_VIEN
		WHERE Ma_sinh_vien = @MaSinhVien
	END
GO


