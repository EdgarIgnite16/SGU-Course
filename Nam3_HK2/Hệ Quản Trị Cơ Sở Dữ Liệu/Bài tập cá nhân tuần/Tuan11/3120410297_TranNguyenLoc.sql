-- Câu 1. Cài đặt ràng buộc: “Ngày giao hàng phải bằng hoặc sau ngày đặt hàng nhưng không được quá 30 ngày
CREATE TRIGGER tg_NgayGiaoHangVsNgayDatHang ON dbo.PhieuGiaoHang
INSTEAD OF INSERT, UPDATE
AS
    BEGIN
        -- Lấy thông tin từ inserted
        DECLARE @maGiaoHang varchar(20), @maDatHang varchar(20), @NgayGiaoHang DATETIME
        
        SELECT @maGiaoHang = MaGiao FROM inserted
        SELECT @maDatHang = MaDat FROM inserted
        SELECT @NgayGiaoHang = NgayGiao FROM inserted

        -- Lấy thông tin ngày đặt hàng trước đó
        DECLARE @ngayDatHang DATETIME

        SELECT @ngayDatHang = NgayDat FROM DonDatHang

        -- Kiểm tra ngày đặt hàng có lớn hơn ngày giao hàng?
        IF @NgayGiaoHang < @ngayDatHang
            BEGIN
                PRINT N'Ngày giao hàng phải bằng hoặc sau ngày đặt hàng!'
                RAISERROR(N'Ngày giao hàng phải bằng hoặc sau ngày đặt hàng!', 16, 1)
                ROLLBACK TRANSACTION
                RETURN
            END

        -- Kiểm tra số ngày chênh lệnh giữa ngày đặt hàng và ngày giao hàng không quá 30
        IF DATEDIFF(DAY, @ngayDatHang, @NgayGiaoHang) >= 30
            BEGIN
                PRINT N'Ngày giao hàng không được quá 30 ngày!'
                RAISERROR(N'Ngày giao hàng phải bằng hoặc sau ngày đặt hàng!', 16, 1)
                ROLLBACK TRANSACTION
                RETURN
            END

        -- Kiểm tra luồng code đang thực hiện lệnh insert hay update
        IF EXISTS(SELECT * FROM DELETED)
            BEGIN
                UPDATE dbo.PhieuGiaoHang
                SET NgayGiao = @NgayGiaoHang
                WHERE MaGiao = @maGiaoHang AND MaDat = @maDatHang
            END
        ELSE
            BEGIN
                INSERT INTO dbo.PhieuGiaoHang
                VALUES(@maGiaoHang, @NgayGiaoHang, @maDatHang)
            END
    END
GO

-- Câu 2. Tạo thủ tục truyền vào mã phiếu giao hàng, xuất ra tổng tiền của phiếu giao hàng đó.
CREATE PROC proc_TongTienPhieuGiaoHang
@maPhieuGiaoHang varchar(20)
AS
    BEGIN
        IF EXISTS(SELECT * FROM PhieuGiaoHang WHERE MaGiao = @maPhieuGiaoHang)
            BEGIN
                DECLARE @tongTien float
                SELECT @tongTien = SUM(DonGiaGiao) FROM ChiTietGiaoHang
                    WHERE MaGiao = @maPhieuGiaoHang
                RETURN @tongTien
            END
        ELSE
            BEGIN
                PRINT N'Mã phiếu giao hàng không tồn tại!'
                RAISERROR(N'Mã phiếu giao hàng không tồn tại!', 16, 1)
                RETURN
            END
    END
GO

-- Câu 3. Viết lại câu 2 bằng cách dùng Function
CREATE FUNCTION ft_TongTienPhieuGiaoHang(@maPhieuGiaoHang varchar(30))
RETURNS FLOAT
AS    
    BEGIN
        IF EXISTS(SELECT * FROM PhieuGiaoHang WHERE MaGiao = @maPhieuGiaoHang)
            BEGIN
                DECLARE @tongTien float
                SELECT @tongTien = SUM(DonGiaGiao) FROM ChiTietGiaoHang
                    WHERE MaGiao = @maPhieuGiaoHang
                RETURN @tongTien
            END
        ELSE
            BEGIN
                PRINT N'Mã phiếu giao hàng không tồn tại!'
                RAISERROR(N'Mã phiếu giao hàng không tồn tại!', 16, 1)
            END
        RETURN 0
     END
GO