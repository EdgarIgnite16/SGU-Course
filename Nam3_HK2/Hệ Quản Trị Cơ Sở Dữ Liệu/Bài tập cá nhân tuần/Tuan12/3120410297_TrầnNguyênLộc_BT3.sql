-- 36/ Nhập vào 2 số nguyên. In ra tổng của chúng
CREATE PROC proc_tinhTong
@s1 INT, @s2 INT
AS
    BEGIN
        DECLARE @tong INT
        SET @tong = @s1 + @s2
        PRINT CONCAT(N'Tổng là ', @tg)
    END
GO

-- 41/ Nhập vào số nguyên @n. In ra tổng và số lượng các số chẵn từ 1 đến @n
CREATE PROC proc_tinhTongN
@n INT
AS
    BEGIN
        DECLARE @Tong INT, @i INT
        SET @Tong = 0
        SET @i = 0
        WHILE @i <= @n
            BEGIN
                IF @i % 2 = 0
                    BEGIN
                        SET @Tong = @Tong + @i
                    END

                SET @i = @i + 1
            END
        PRINT @Tong
        RETURN @Tong
    END
GO

/**
56. Khi thêm mới một câu lạc bộ thì kiểm tra xem đã có câu lạc bộ trùng tên với câu lạc bộ vừa được thêm hay không?
    a. chỉ thông báo vẫn cho insert.
    b. thông báo và không cho insert.
**/

-- a. Chỉ thông báo và vẫn cho insert => Dùng FOR/ALTER nhưng không rollback khi sai
CREATE TRIGGER trg_checkNameConflict1 ON dbo.CAULACBO
FOR INSERT
AS
    BEGIN
        DECLARE @tenCLB NVARCHAR(30)
        SELECT @tenCLB = TENCLB FROM inserted

        IF EXISTS(SELECT * FROM CAULACBO WHERE TENCLB = @tenCLB)
            BEGIN
                PRINT N'Thông báo: Tên CLB đã tồn tại!'
                RAISERROR(N'Thông báo: Tên CLB đã tồn tại!', 16, 1)
                -- ROLLBACK TRANSACTION
            END
        ELSE
            BEGIN
                PRINT N'Thông báo: Nhập thành công'
                RAISERROR(N'Thông báo: Nhập thành công', 16, 1)
            END
    END
GO

-- b. Chỉ thông báo và không cho insert => Dùng INSTEAD OF và không thực hiện truy vấn khi đúng
CREATE TRIGGER trg_checkNameConflict2 ON dbo.CAULACBO
INSTEAD OF INSERT
AS
    BEGIN
        DECLARE @tenCLB NVARCHAR(30), @maCLB VARCHAR(10), @diaChi NVARCHAR(20)
        SELECT @maCLB = MACLB FROM inserted
        SELECT @tenCLB = TENCLB FROM inserted
        SELECT @diaChi = DIACHI FROM inserted

        IF EXISTS(SELECT * FROM CAULACBO WHERE TENCLB = @tenCLB)
            BEGIN
                PRINT N'Thông báo: Tên CLB đã tồn tại!'
                RAISERROR(N'Thông báo: Tên CLB đã tồn tại!', 16, 1)
                RETURN
            END
        ELSE
            BEGIN
                PRINT N'Thông báo: Nhập thành công'
                RAISERROR(N'Thông báo: Nhập thành công', 16, 1)\

                -- INSERT INTO dbo.CAULACBO
                -- VALUES(@maCLB, @tenCLB, @diaChi)
            END
    END
GO

/**
57. Khi sửa tên cầu thủ cho một (hoặc nhiều) cầu thủ thì in ra:
    a. danh sách mã cầu thủ của các cầu thủ vừa được sửa.
    b. danh sách mã cầu thủ vừa được sửa và tên cầu thủ mới.
    c. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ.
    d. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ và cầu thủ mới.
    e. câu thông báo bằng Tiếng Việt: ‘Vừa sửa thông tin của cầu thủ có mã số xxx’ với xxx là mã cầu thủ vừa được sửa.
**/

CREATE TRIGGER trg_updateCauthu on dbo.CAUTHU
FOR UPDATE
AS
    BEGIN
        DECLARE @maCT VARCHAR(30), @tenCT NVARCHAR(40), @Count INT, @tenCTMOI NVARCHAR(40)
        

        -- a. danh sách mã cầu thủ của các cầu thủ vừa được sửa.
        SET @Count = 0 
        PRINT N'a. Danh sách mã cầu thủ vừa được sửa: '
        WHILE @Count < (SELECT COUNT(*) FROM deleted)
            BEGIN
                SELECT @maCT = MACAUTHU FROM deleted
                PRINT @maCT
                SET @Count = @Count + 1
            END


        -- b. danh sách mã cầu thủ vừa được sửa và tên cầu thủ mới.
        SET @Count = 0 
        PRINT N'b. Danh sách mã cầu thủ vừa được sửa và tên cầu thủ mới: '
        WHILE @Count < (SELECT COUNT(*) FROM inserted)
            BEGIN
                SELECT @maCT = MACAUTHU FROM inserted
                SELECT @tenCT = TENCAUTHU FROM inserted
                PRINT  CONCAT(@maCT, ": ", @tenCT)
                SET @Count = @Count + 1
            END

    
        -- c. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ.
        SET @Count = 0 
        PRINT N'c. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ: '
        WHILE @Count < (SELECT COUNT(*) FROM deleted)
            BEGIN
                SELECT @maCT = MACAUTHU FROM deleted
                SELECT @tenCT = TENCAUTHU FROM deleted
                PRINT  CONCAT(@maCT, ": ", @tenCT)
                SET @Count = @Count + 1
            END

        -- d. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ và cầu thủ mới.
        SET @Count = 0 
        PRINT N' d. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ và cầu thủ mới: '
        WHILE @Count < (SELECT COUNT(*) FROM deleted)
            BEGIN
                SELECT @maCT = MACAUTHU FROM inserted
                SELECT @tenCT = TENCAUTHU FROM deleted
                SELECT @tenCTMOI = TENCAUTHU FROM inserted
                PRINT  CONCAT(@maCT, ": ", N'Tên cũ:', @tenCT, N' Tên mới:', @tenCTMOI)
                SET @Count = @Count + 1
            END

        -- e. câu thông báo bằng Tiếng Việt: ‘Vừa sửa thông tin của cầu thủ có mã số xxx’ với xxx là mã cầu thủ vừa được sửa.
        SELECT @tenCTMOI = TENCAUTHU FROM inserted
        PRINT CONCAT(N'Vừa sửa thông tin của cầu thủ có mã số', @tenCTMOI)
    END
GO
