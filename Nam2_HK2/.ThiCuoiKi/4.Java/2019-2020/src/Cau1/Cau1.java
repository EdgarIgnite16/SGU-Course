package Cau1;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Cau1 extends JFrame {
    // tạo các thành phần
    JTextField txtX = new JTextField();
    JTextField txtN = new JTextField();
    JTextField Result = new JTextField();
    JButton btn = new JButton();
    JPanel pnInput = new JPanel();
    JPanel pnButton = new JPanel();

    public Cau1() {
        this.generateForm();
    }

    public void generateForm() {
        // set config mặc định cho frame
        this.setTitle("Cau 1"); // set title cho Frame
        this.setLocationRelativeTo(null); // ra giữa
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setSize(300, 200);

        // Panel Input
        pnInput.setLayout(new GridLayout(3, 1, 10, 15));
        pnInput.add(txtN);
        pnInput.add(txtX);
        pnInput.add(Result);

        // Panel Button
        pnButton.setLayout(new GridLayout(1, 1, 10, 15));
        btn.setText("Tính giá trị biểu thức");
        btn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                btnActionEvent(e);
            }
        });
        pnButton.add(btn);

        // add Component and Layout
        this.setLayout(new BorderLayout());
        this.add(pnInput, BorderLayout.CENTER);
        this.add(pnButton, BorderLayout.SOUTH);
        this.add(new Panel(), BorderLayout.NORTH);
        this.add(new Panel(), BorderLayout.WEST);
        this.add(new Panel(), BorderLayout.EAST);
    }

    public void btnActionEvent(ActionEvent e) {
        int n = Integer.parseInt(txtN.getText());
        int x = Integer.parseInt(txtX.getText());

        if(n<0) {
            JOptionPane.showMessageDialog(this, "Gía trị n nhập vào phải lớn hơn 0",
                "Lỗi", JOptionPane.ERROR_MESSAGE);
        } else {
            if(x<=0) {
                JOptionPane.showMessageDialog(this, "Gía trị x nhập vào phải lớn hơn 0",
                        "Lỗi", JOptionPane.ERROR_MESSAGE);
            } else {
                int res = 0;
                for(int i=0;i<=n;i++) {
                    res += (i+1)*Math.pow(x, i);
                }
                Result.setText(String.valueOf(res));
            }
        }
    }
}

