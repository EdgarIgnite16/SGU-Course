-- Cau 1.1
CREATE PROC sp_KiemTra
@macd VARCHAR(20), @maxe VARCHAR(20)
AS
    BEGIN
        -- Nếu đã tồn tại xe và chuyến đi hợp lệ
        IF(EXISTS(SELECT * FROM CHUYENDI cd, XE x WHERE cd.MCD = @macd OR x.MAXE = @maxe))
            BEGIN
                -- Nếu trong ngày tương ứng không tồn tại chuyến đi nào cho xe đang xét
                -- Bước 1 lấy ra danh sách chuyến đi trong ngày tương ứng (ví dụ là ngày môn nay)
                -- Sau bước 1 thì ta sẽ có danh sách mã xe trong ngày tương ứng
                -- Lấy danh sách đó so sánh với mã xe hiện tại đang xét 
                IF(EXISTS(
                    SELECT * FROM XE x
                    WHERE x.MAXE = @maxe AND x.MAXE NOT IN (
                        SELECT cdx.MAXE FROM CHUYENDI cd, CD_XE cdx
                        WHERE cd.MACD = cdx.MACD
                            AND DAY(cd.NGAYDI) = DAY(GETDATE())
                            AND MONTH(cd.NGAYDI) = MONTH(GETDATE())
                            AND YEAR(cd.NGAYDI) = YEAR(GETDATE())
                    )
                ))
                    BEGIN
                        INSERT INTO CD_XE
                        VALUES(@macd, @maxe)
                    END
            END
        -- Nếu không tồn tại xe và chuyến đi hợp lệ
        ELSE
            BEGIN
                PRINT N'Xe và chuyến đi phải hợp lệ!'
            END
    END
GO

-- Cau 1.2
CREATE TRIGGER tg_Xe ON dbo.XE
FOR UPDATE
AS 
    BEGIN
        DECLARE @bangSoXeCu VARCHAR(20), @bangSoXeMoi VARCHAR(20), @maXe VARCHAR(20)
        SELECT @bangSoXeCu = BANGSO FROM deleted
        SELECT @bangSoXeMoi = BANGSO FROM inserted

        -- Kiểm tra bảng cũ với bảng mới
        IF(@bangSoXeMoi != @bangSoXeCu)
            BEGIN
                IF(EXISTS(SELECT * FROM XE x WHERE x.BANGSO = @bangSoXeMoi AND x.MAXE != @maXe)) 
                    BEGIN
                        ROLLBACK TRANSACTION
                        PRINT N'Biển số xe mới không được trùng với bất kì bảng số xe hiện có nào khác!'         
                    END
            END
        ELSE
            BEGIN
                ROLLBACK TRANSACTION
                PRINT N'Bảng xe cũ khác bảng xe mới!'
            END
    END
GO