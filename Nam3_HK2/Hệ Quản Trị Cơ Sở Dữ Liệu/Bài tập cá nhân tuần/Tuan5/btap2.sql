CREATE FUNCTION fn_DSXepHang(@k INT)
RETURNS TABLE
AS
        RETURN SELECT TOP(@k) SV.Ten_sinh_vien FROM SINH_VIEN SV, KET_QUA KQ
        WHERE SV.Ma_Sinh_Vien = KQ.Ma_sinh_vien
        GROUP BY KQ.Ma_sinh_vien, SV.Ten_sinh_vien
        ORDER BY SUM(KQ.Diem) / COUNT(KQ.Ma_mon_hoc) DESC 
GO 