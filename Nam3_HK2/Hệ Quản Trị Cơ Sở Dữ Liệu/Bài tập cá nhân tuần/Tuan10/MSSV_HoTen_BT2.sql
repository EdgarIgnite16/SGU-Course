--Phần 1: Truy vấn cơ bản
--1. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng “SHB Đà Nẵng” có quốc tịch “Bra-xin”.
SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI
FROM CAUTHU
WHERE MACLB = 'SDN' AND MAQG = 'BRA' 

--2. Cho biết tên cầu thủ đã ghi từ 2 bàn thắng trở lên trong một trận đấu.
SELECT HOTEN
FROM CAUTHU CT, THAMGIA TG
WHERE CT.MACT = TG.MACT AND SOTRAI >= 2
GROUP BY HOTEN

--3. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu thuộc vòng 3 của mùa bóng năm 2009.
SELECT TD.MATRAN, TD.NGAYTD, SAN.TENSAN, CLB1.TENCLB AS 'TENCLB1', CLB2.TENCLB AS 'TENCLB2', KETQUA
FROM TRANDAU TD, SANVD SAN, CAULACBO CLB1, CAULACBO CLB2
WHERE TD.VONG = 3 AND TD.NAM = 2009 AND TD.MASAN = SAN.MASAN AND TD.MACLB1 = CLB1.MACLB AND TD.MACLB2 = CLB2.MACLB

--4. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc của các huấn luyện viên có quốc tịch “Việt Nam”.
SELECT HLV.MAHLV, TENHLV, NGAYSINH, DIACHI, VAITRO, TENCLB 
FROM HUANLUYENVIEN HLV, HLV_CLB, CAULACBO CLB
WHERE HLV.MAHLV = HLV_CLB.MAHLV AND CLB.MACLB = HLV_CLB.MACLB AND MAQG = 'VN'

--Phần 2: Các phép toán trên nhóm
--5. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác “Viet Nam”)
--tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài.
SELECT CLB.MACLB, CLB.TENCLB, TENSAN, SANVD.DIACHI, COUNT(MACT) AS 'Số lượng cầu thủ nước ngoài'
FROM CAULACBO CLB, SANVD, CAUTHU CT
WHERE CLB.MASAN = SANVD.MASAN AND CLB.MACLB = CT.MACLB AND CT.MAQG <> 'VN'
GROUP BY CLB.TENCLB, CLB.MACLB, TENSAN, SANVD.DIACHI
HAVING COUNT(MACT) >= 2

--6. Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản lý.
SELECT TENTINH, COUNT(MACT) AS 'Số lượng cầu thủ đang thi đấu ở vị trí tiền đạo'
FROM TINH, CAUTHU CT, CAULACBO CLB
WHERE TINH.MATINH = CLB.MATINH AND CLB.MACLB = CT.MACLB AND CT.VITRI = N'Tiền Đạo'
GROUP BY TENTINH

--7. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng xếp hạng của vòng 3, năm 2009.
SELECT TENCLB, TENTINH
FROM CAULACBO CLB, TINH, BANGXH BXH
WHERE CLB.MACLB = BXH.MACLB AND CLB.MATINH = TINH.MATINH AND BXH.HANG = 1 AND BXH.VONG = 3 AND BXH.NAM = 2009

--Phần 3: Các toán tử nâng cao
--8. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong một câu lạc bộ mà chưa có số điện thoại.
SELECT HLV.TENHLV
FROM HUANLUYENVIEN HLV, HLV_CLB
WHERE HLV.MAHLV = HLV_CLB.MAHLV AND HLV.DIENTHOAI = ''
GROUP BY TENHLV
HAVING COUNT(VAITRO) = 1

--9. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện tại bất kỳ một câu lạc bộ nào.
SELECT HLV.TENHLV
FROM HUANLUYENVIEN HLV, HLV_CLB
WHERE HLV.MAQG = 'VN' AND HLV_CLB.VAITRO = ''

--10. Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2009 lớn hơn 6 hoặc nhỏ hơn 3.
SELECT CT.HOTEN
FROM CAUTHU CT, BANGXH BXH
WHERE CT.MACLB = BXH.MACLB AND BXH.VONG = 3 AND (BXH.HANG > 6 OR BXH.HANG < 3)

--11. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ CLB đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009.
SELECT TD.NGAYTD, SAN.TENSAN, CLB1.TENCLB AS 'TENCLB1', CLB2.TENCLB AS 'TENCLB2', KETQUA
FROM TRANDAU TD, SANVD SAN, CAULACBO CLB1, CAULACBO CLB2
WHERE TD.MASAN = SAN.MASAN AND TD.MACLB1 = CLB1.MACLB AND TD.MACLB2 = CLB2.MACLB
    AND (CLB1.MACLB IN(
        SELECT BXH.MACLB
        FROM BANGXH BXH
        WHERE BXH.HANG = 1 AND BXH.VONG = 3 AND BXH.NAM = 2009
        ) OR (CLB2.MACLB IN(
            SELECT BXH.MACLB
            FROM BANGXH BXH
            WHERE BXH.HANG = 1 AND BXH.VONG = 3 AND BXH.NAM = 2009
            )))
--Phần 4: Xử lý chuỗi, ngày giờ
--12. Cho biết NGAYTD, TENCLB1, TENCLB2, KETQUA các trận đấu diễn ra vào tháng 3 trên sân nhà mà không bị thủng lưới.
SELECT TD.NGAYTD, CLB1.TENCLB AS 'TENCLB1', CLB2.TENCLB AS 'TENCLB2', KETQUA
FROM TRANDAU TD, CAULACBO CLB1, CAULACBO CLB2
WHERE TD.MACLB1 = CLB1.MACLB AND TD.MACLB2 = CLB2.MACLB AND MONTH(TD.NGAYTD) = 3 AND TD.KETQUA LIKE '0-%'

--13. Cho biết mã số, họ tên, ngày sinh (dd/MM/yyyy) của những cầu thủ có họ lót là “Công”.
SELECT MACT, HOTEN, CONVERT(date, NGAYSINH, 103)
FROM CAUTHU
WHERE CHARINDEX(N'Công', HOTEN, 2) <> 0

--14. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ không phải là họ “Nguyễn”.
SELECT MACT, HOTEN, CONVERT(date, NGAYSINH, 103)
FROM CAUTHU
WHERE LEFT(HOTEN, 6) != N'Nguyễn'

--15. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ của những huấn luyện viên Việt Nam có tuổi nằm trong khoảng 35 – 40.
SELECT MAHLV, TENHLV, NGAYSINH, DIACHI
FROM HUANLUYENVIEN
WHERE MAQG = 'VN' AND (YEAR(GETDATE() - YEAR(NGAYSINH)) <= 40 OR YEAR(GETDATE() - YEAR(NGAYSINH)) >= 35)

--16. Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 5.
SELECT TENCLB
FROM CAULACBO CLB, HUANLUYENVIEN HLV, HLV_CLB
WHERE CLB.MACLB = HLV_CLB.MACLB AND HLV.MAHLV = HLV_CLB.MAHLV AND DAY(HLV.NGAYSINH) = 20 AND MONTH(HLV.NGAYSINH) = 5

--17. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thắng nhiều nhất tính đến hết vòng 3 năm 2009.
SELECT TOP 1 TENCLB, TENTINH
FROM CAULACBO CLB, TINH, BANGXH BXH
WHERE CLB.MACLB = BXH.MACLB AND CLB.MATINH = TINH.MATINH AND BXH.VONG = 3 AND BXH.NAM = 2009
ORDER BY SUBSTRING(BXH.HIEUSO, 1, 1) DESC

--Phần 5: Truy vấn con
--18. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác “Việt Nam”)
-- tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài.
SELECT clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI, TEMP.SL AS N'Số lượng cầu thủ nước ngoài'
FROM CAULACBO clb, SANVD svd, (
    -- Bảng này trả về Mã CLB có SL cầu thủ nước ngoài lơn hơn 2
    SELECT clb.MACLB, COUNT(*) AS N'SL'
    FROM CAULACBO clb, CAUTHU ct, QUOCGIA qg
    WHERE qg.TENQG != 'Việt Nam'
    AND qg.MAQG = ct.MAQG
    AND ct.MACLB = clb.MACLB
    GROUP BY clb.MACLB
    HAVING COUNT(*) >= 2
) temp
WHERE clb.MASAN = svd.MASAN
AND clb.MACLB = temp.MACLB

--19. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất năm 2009.
SELECT clb.TENCLB, t.TENTINH 
FROM CAULACBO clb, TINH t, BANGXH bxh
WHERE clb.MATINH = t.MATINH
AND bxh.MACLB = clb.MACLB
AND bxh.HIEUSO = (
    -- Lấy ra hiệu số bàn thắng cao nhất trong năm 2019
    SELECT MAX(bxh.HIEUSO)
    WHERE bxh.NAM = 2019
)

--20. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009.
-- Để làm đơn giản hơn ta tách câu truy vấn thành 2 lần truy vấn và Giao kết quả lại với nhau để ra một kết quả chung
SELECT td.NGAYTD, svd.TENSAN, clb1.TENCLB, td.KETQUA
FROM SANVD svd, TRANDAU td, (
    -- Lấy ra CLB có thứ hạng thấp nhất trong vòng 3 năm 2009
    SELECT TOP(1) clb.MACLB 
    FROM CAULACBO clb, BANGXH bxh
    WHERE clb.MACLB = bxh.MACLB
    AND bxh.NAM = 2009
    AND bxh.VONG = 3
    ORDER BY bxh.HANG DESC
) clb1
WHERE clb1.MACLB = td.MACLB1
AND td.MASAN = svd.MASAN
UNION
SELECT td.NGAYTD, svd.TENSAN, clb1.TENCLB, td.KETQUA
FROM SANVD svd, TRANDAU td, (
    -- Lấy ra CLB có thứ hạng thấp nhất trong vòng 3 năm 2009
    SELECT TOP(1) clb.MACLB 
    FROM CAULACBO clb, BANGXH bxh
    WHERE clb.MACLB = bxh.MACLB
    AND bxh.NAM = 2009
    AND bxh.VONG = 3
    ORDER BY bxh.HANG DESC
) clb2
WHERE clb1.MACLB = td.MACLB2
AND td.MASAN = svd.MASAN

--21. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại (kể cả sân nhà và sân khách) trong mùa giải năm 2009.


--22. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại (chỉ tính sân nhà) trong mùa giải năm 2009.
