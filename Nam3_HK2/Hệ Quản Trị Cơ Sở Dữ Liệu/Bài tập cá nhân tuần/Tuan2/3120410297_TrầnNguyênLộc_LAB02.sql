-- Bài 1
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

-----------------------------------------------------------------------------------------------------------------
-- Bài 2
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

-----------------------------------------------------------------------------------------------------------------
-- Bài 3
-- Cách 1: DÙNG ALTER(FOR)
CREATE TRIGGER tg_SV_Xoa_AfterFor ON dbo.SINH_VIEN
FOR DELETE
AS
	BEGIN
		DECLARE @MaSinhVien VARCHAR(20)
		SELECT @MaSinhVien = Ma_sinh_vien FROM deleted

		-- Kiểm tra sinh viên có tồn tại không
		IF(EXISTS(SELECT * FROM SINH_VIEN WHERE Ma_sinh_vien = @MaSinhVien))
			BEGIN
				DECLARE @CountMonHocDiemDuoi5 INT = 0
				
				-- Lấy số lượng môn có điểm dưới 5
				SELECT @CountMonHocDiemDuoi5 = COUNT(*) FROM dbo.KET_QUA
				WHERE Ma_sinh_vien = @MaSinhVien AND Diem < 5

				-- Kiểm tra nghiệp vụ bài toán
				IF(@CountMonHocDiemDuoi5 < 4) 
					BEGIN
						PRINT N'Có thể xóa sinh viên này!'
						PRINT N'Xóa sinh viên thành công!'

						ROLLBACK TRANSACTION -- Quay lại trans trước đó
						
						-- Thực hiện nghiệp vụ
						-- Xóa ràng buộc dữ liệu trước
						DELETE FROM dbo.KET_QUA
						WHERE Ma_sinh_vien = @MaSinhVien
						-- Xóa thông tin sinh viên
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

		-- Kiểm tra mã sinh viên nhập vào có tồn tại hay không
		IF(NOT EXISTS(SELECT * FROM SINH_VIEN WHERE Ma_sinh_vien = @MaSinhVien))
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Không tìm thấy sinh viên!'
			END
		
		-- Kiểm tra nghiệp vụ có hợp lệ hay không
		IF((SELECT COUNT(*) FROM dbo.KET_QUA WHERE Ma_sinh_vien = @MaSinhVien AND Diem < 5) >= 4)
			BEGIN
				ROLLBACK TRANSACTION
				PRINT N'Không thể xóa sinh viên có số môn dưới 5 điểm vượt quá 4 môn'
			END


		-- Thực hiện lại lệnh delete để hoàn thành nghiệp vụ
		PRINT N'Xóa sinh viên thành công!'
		-- Xóa ràng buộc dữ liệu trước
		DELETE FROM dbo.KET_QUA
		WHERE Ma_sinh_vien = @MaSinhVien
		-- Xóa thông tin sinh viên
		DELETE FROM dbo.SINH_VIEN
		WHERE Ma_sinh_vien = @MaSinhVien
	END
GO

-----------------------------------------------------------------------------------------------------------------
-- Bài 4
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



