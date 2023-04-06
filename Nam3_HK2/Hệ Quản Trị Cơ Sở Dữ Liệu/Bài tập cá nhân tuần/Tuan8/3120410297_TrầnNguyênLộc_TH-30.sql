-- Cau 1
CREATE PROC proc_TongSoTHiSinhDuTHi
@maTruong NVARCHAR(30)
AS
    BEGIN
        IF EXISTS(SELECT * FROM TRUONG WHERE MATRUONG = @maTruong)
            BEGIN
                DECLARE @soLuongThiSinhDuTHiCuaTruong INT
                SELECT @soLuongThiSinhDuTHiCuaTruong = COUNT(kq.SOBD) FROM THISINH ts, KETQUA kq
                WHERE  ts.MATRUONG = @maTruong AND ts.SOBD = kq.SOBD
                GROUP BY kq.SOBD

                RETURN @soLuongThiSinhDuTHiCuaTruong
            END
        ELSE
            BEGIN
                PRINT(N'Ma truong truyen vao khong ton tai!')
            END    
    END
GO

-- Cau 2
CREATE FUNCTION func_DemSoThiSinhDiemLiet(@maTruong NVARCHAR(30))
RETURNS TABLE
AS
    RETURN SELECT COUNT(kq.SOBD) FROM THISINH ts, KETQUA kq
    WHERE  ts.MATRUONG = @maTruong AND ts.SOBD = kq.SOBD AND kq.DIEM <= 1
    GROUP BY kq.SOBD
GO

-- Cau 3
CREATE TRIGGER tgr_18TuoiTroLen ON dbo.THISINH
FOR INSERT, UPDATE
AS
    BEGIN
        DECLARE @Tuoi INT, @NamDuThi INT
        SELECT @Tuoi = YEAR(NGSINH) FROM inserted
        SELECT @Tuoi = NAMDUTHI FROM inserted
        
        IF @Tuoi >= 18 AND @NamDuThi = YEAR(GETDATE())
            BEGIN
                PRINT N'Du lieu cap nhat thanh cong!'
            END
        ELSE
            BEGIN
                ROLLBACK TRANSACTION
                PRINT N'Tuoi phai hon 18 va nam du thi khong duoc khac nam hien tai'
            END
    END
GO

-- Cau 4
CREATE TRIGGER tgr_KetQuaTrigger ON dbo.KETQUA
FOR INSERT, UPDATE
AS
    BEGIN
        DECLARE @DiemThi FLOAT, @SoBD NVARCHAR(20), @MoMT NVARCHAR(20)
        SELECT @DiemThi = DIEM from inserted
        SELECT @SoBD = DIEM from inserted
        SELECT @MaMT = DIEM from inserted

        IF @DiemThi >= 0 AND @DiemTHi <= 10
            BEGIN
                IF @DiemThi = 0 
                    BEGIN   
                        UPDATE dbo.KETQUA
                        SET GHICHU = "VANG THI"
                        WHERE SOBD = @SoBD AND MAMT = @MaMT
                    END
            END
        ELSE
            BEGIN
                ROLLBACK TRANSACTION
                PRINT N'Diem thi phai nam trong khoang tu 0 den 10'
            END
    END
GO