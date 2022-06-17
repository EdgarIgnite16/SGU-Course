package Cau2;

public class SachGUI {
    private void btnThemSachActionListener() {
        SachDTO sachDTO = new SachDTO();
        sachDTO.setMaSach(txtMaSach.getText());
        sachDTO.setTenSach(txtTenSach.getText());
        sachDTO.setSoLuong(Integer.parseInt(txtSoLuong.getText()));
        sachDTO.setDonGia(Float.parseFloat(txtDonGia.getText()));

        SachBUS sachBUS = new SachBUS();
        sachBUS.insert(sachDTO);
    }
}
