-- Cau 1
BEGIN TRANSACTION
    -- Thêm dữ liệu vào bảng SVIEN
    INSERT INTO dbo.SVIEN
    VALUES('SV002', 'CNTT', 'Tran Nguyen Loc' , 2002)
    
    -- Thêm dữ liệu vào bảng HPHAN
    INSERT INTO dbo.HPHAN
    VALUES(4, 'COMP01', 1, 2022, 'Johnny Dang')

    -- Thêm dữ liệu vảo bảng KETQUA
    INSERT INTO dbo.KETQUA
    VALUES('SV002', 4, 0)

    COMMIT TRANSACTION
GO

-- Cau 2
CREATE PROC proc_CapNhatDiemSo 
@MASV varchar(8),
@MAHP int,
@DIEM int
AS
    BEGIN
        BEGIN TRANSACTION
            -- Cập nhật điểm số cho đối tượng
            UPDATE dbo.KETQUA
            SET DIEM = @DIEM
            WHERE MASV = @MASV AND MAHP = @MAHP

            COMMIT TRANSACTION
    END
GO

-- Câu 3
-- Câu 4
CREATE TRIGGER trg_UpdateHocPhan ON dbo.HPHAN
INSTEAD OF UPDATE
AS
    BEGIN
        DECLARE @MaHP INT
        -- Lấy thông tin record: MãHP của HPHAN đã xóa trong bảng deleted
        SELECT @MaHP = MAHP FROM deleted

        -- Kiểm tra: Nếu học phần đã có điểm số tồn tại trong bảng KETQUA
        IF(EXISTS(SELECT * FROM KQUA WHERE MAHP = @MaHP))
            BEGIN
                ROLLBACK TRANSACTION
                PRINT N'Học phần đã có dữ liệu điểm số! Không thể xóa!'
                    RETURN -- Kết thúc trigger
            END 

        PRINT N'Xóa thành công!'
        DELETE dbo.HPHAN
        WHERE MAHP = @MaHP
    END
GO
