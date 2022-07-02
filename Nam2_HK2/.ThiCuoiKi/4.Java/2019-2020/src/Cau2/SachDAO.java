package Cau2;

import java.sql.*;
import java.util.ArrayList;

public class SachDAO {
    // hàm select lấy dữ liệu
    public ArrayList<SachDTO> getData() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String URL = "jdbc:sqlserver://localhost:1433;databaseName=XXXXXX;";
        Connection conn = DriverManager.getConnection(URL, "sa", "12345");

        // Bước insert
        String sql = "select * from dbo.SACH";
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery(sql);

        ArrayList<SachDTO> listSach = new ArrayList<>();
        while (rs.next()) {
            SachDTO sachDTO = new SachDTO();
            sachDTO.setMaSach(rs.getString("MASACH"));
            sachDTO.setTenSach(rs.getString("TENSACH"));
            sachDTO.setSoLuong(rs.getInt("SOLUONG"));
            sachDTO.setDonGia(rs.getFloat("DONGIA"));
            listSach.add(sachDTO);
        }

        conn.close();
        stm.close();

        return listSach;
    }


    // trong trường hợp không check trạng thái update dữ liệu
    public void insertNoNotify(SachDTO sachDTO) throws Exception {
        // BƯớc tạo connection
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String URL = "jdbc:sqlserver://localhost:1433;databaseName=XXXXXX;";
        Connection conn = DriverManager.getConnection(URL, "sa", "12345");

        // Bước insert
        String sql = "insert into dbo.SACH (MASACH, TENSACH, SOLUONG, DONGIA) VALUES(?, ?, ?, ?)";
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, sachDTO.getMaSach());
        pstm.setString(2, sachDTO.getTenSach());
        pstm.setInt(3, sachDTO.getSoLuong());
        pstm.setFloat(4, sachDTO.getDonGia());

        pstm.executeUpdate();

        conn.close();
        pstm.close();
    }

    // trong trường hợp  check trạng thái update dữ liệu
    public boolean insertNotify(SachDTO sachDTO) throws Exception {
        // BƯớc tạo connection
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String URL = "jdbc:sqlserver://localhost:1433;databaseName=XXXXXX;";
        Connection conn = DriverManager.getConnection(URL, "sa", "12345");

        // Bước insert
        String sql = "insert into dbo.SACH (MASACH, TENSACH, SOLUONG, DONGIA) VALUES(?, ?, ?, ?)";
        PreparedStatement pstm = conn.prepareStatement(sql);
        pstm.setString(1, sachDTO.getMaSach());
        pstm.setString(2, sachDTO.getTenSach());
        pstm.setInt(3, sachDTO.getSoLuong());
        pstm.setFloat(4, sachDTO.getDonGia());

        boolean check = pstm.executeUpdate() > 0;
        conn.close();
        pstm.close();
        return check;
    }
}
