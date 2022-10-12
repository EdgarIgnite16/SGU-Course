package Cores;

import Objs.FD;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashSet;
import java.util.Scanner;

public class FindAllKey {
    // Xác định TN(Tập nguồn) và TG(Trung Gian)
    // TN là bao gồm các chữ chỉ xuất hiện ở vế trái
    // TG là bao gồm các chữ xuất hiện bên cả 2 vế
    /*
        ABCDEGHI
        AC B
        BI ACD
        ABC D
        H I
        ACE BCG
        CG AE

        TN = {H} || TG = {A, B, C, E, G, I}
    */

    private String filePath;
    private HashSet<Character> R = new HashSet<>(); // là tập hợp các chữ trong tập hợp hàm
    private HashSet<FD> F = new HashSet<FD>();  // Class chứa các phụ thuộc hàm
    private HashSet<Character> TN = new HashSet<>();
    private HashSet<Character> TG = new HashSet<>();

    public FindAllKey(String filename) {
        Scanner in = null;
        this.filePath = filename;

        try {
            in = new Scanner(new File(filename));
        } catch (FileNotFoundException e){
            System.err.println(filename + " not found");
            System.exit(1);
        }

        String line = in.nextLine(); // lấy chữ đầu tiên trong tập hợp
        for (int i = 0; i < line.length(); i++) {
            R.add(line.charAt(i)); // tách từng chữ trong tập hợp vào hashSet
        }

        while (in.hasNextLine()){
            // Tách chữ đầu tiên ra làm 2
            String[] terms = in.nextLine().split(" ");
            HashSet<Character> l = new HashSet<Character>();
            HashSet<Character> r = new HashSet<Character>();

            // Tạo loop lấy chữ của phụ thuộc hàm bên trái
            for(int i = 0; i < terms[0].length(); i++) {
                l.add(terms[0].charAt(i)); // bên trái
            }

            // Tạo loop lấy chữ của phụ thuộc hàm bên phải
            for (int i = 0; i < terms[1].length(); i++) {
                r.add(terms[1].charAt(i)); // bên trái
            }

            F.add(new FD(l, r)); // add cả trái lẫn phải vào FD (Functional Dependency)
        }

        in.close(); // Đóng file
    }

    //Hàm xác định tập nguồn và tập giao
    public void Determine_TN_TG() {
        // Tìm tập giao TG
        R.forEach(CharR -> {
            F.forEach(fd1 -> {
                boolean checkLeft = fd1.lhs.contains(CharR);
                if(checkLeft) {
                    F.forEach(fd2 -> {
                        boolean checkRight = fd2.rhs.contains(CharR);
                        /*
                        System.out.print(CharR + " ");
                        System.out.print(fd1.lhs + "->" + fd2.rhs);
                        System.out.print(" " + checkLeft + " " + checkRight);
                        System.out.println();
                        */
                        if(checkRight) {
                                TG.add(CharR);
                        }
                    });
                }
            });
        });

        // Tìm tập nguồn TN
        R.forEach(CharR -> {
            F.forEach(fd1 -> {
                boolean checkLeft = fd1.lhs.contains(CharR);
                if(checkLeft) {
                    F.forEach(fd2 -> {
                        boolean checkRight = fd2.rhs.contains(CharR);
                        /*
                        System.out.print(CharR + " ");
                        System.out.print(fd1.lhs + "->" + fd2.rhs);
                        System.out.print(" " + checkLeft + " " + checkRight);
                        System.out.println();
                        */
                        if(!checkRight) {
                            // Kiểm tra Char đang xét có nằm trong TG
                            if(!TG.contains(CharR)) {
                                TN.add(CharR);
                            }
                        }
                    });
                }
            });
        });

        System.out.println("Tap Nguon (TN): " + TN);
        System.out.println("Tap Giao (TG): " + TG);
    }

    // Lập ma trận bảng
    public void MatrixTable() {
        HashSet<Character> Xi = new HashSet<>();
        HashSet<Character> TnUXi = new HashSet<>();
        HashSet<Character> tnUXiPlus = new HashSet<>();
        HashSet<Character> superKey = new HashSet<>();
        HashSet<Character> key = new HashSet<>();


    }
}
