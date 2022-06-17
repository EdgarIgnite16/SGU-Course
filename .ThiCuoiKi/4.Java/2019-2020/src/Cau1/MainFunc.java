package Cau1;

import javax.swing.*;

public class MainFunc {
    public static void main(String[] args) {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
            new Cau1().setVisible(true);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
