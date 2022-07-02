package Cau2;

import javax.swing.*;
import java.util.ArrayList;

public class SachBUS {
    private ArrayList<SachDTO> listSach;

    public SachBUS() {
        try {
            this.listSach = new SachDAO().getData();
        } catch (Exception ex) {
            System.out.println("Lấy dữ liệu không thành công!");
        }
    }

    public void insert(SachDTO sachDTO)  {
        try {
            if(!checkExsit(sachDTO)) {
                SachDAO sachDAO = new SachDAO();
                sachDAO.insertNoNotify(sachDTO);
            } else {
                JOptionPane.showMessageDialog(null, "Sách đã tồn tại!" ,
                        "Lỗi", JOptionPane.ERROR_MESSAGE);
            }
        } catch (Exception ex) {
            System.out.println("Đã có lỗi sảy ra!");
        }
    }

    public boolean checkExsit(SachDTO sachDTO) {
        for(SachDTO item : listSach) {
            if(item.getMaSach().equals(sachDTO.getMaSach())) {
                return false;
            }
        }
        return true;
    }
}
