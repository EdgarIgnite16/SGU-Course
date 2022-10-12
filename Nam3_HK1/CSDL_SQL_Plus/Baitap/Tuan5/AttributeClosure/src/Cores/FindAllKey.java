package Cores;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashSet;
import java.util.Scanner;

public class FindAllKey {
    // Xác định TN(Tập nguồn) và TG(Trung Gian)
    // TN là bao gồm các chữ chỉ xuất hiện ở vế trái
    // TG là bao gồm các chữ xuất hiện bên cả 2 vế
    // TN = {H} || TG = {A, B, C, E, G, I}

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

    // Lớp chứa các phụ thuộc hàm
    public class FD{
        HashSet<Character> lhs;
        HashSet<Character> rhs;

        public FD(HashSet<Character> l, HashSet<Character> r){
            this.lhs = l;
            this.rhs = r;
        }
    };

    //Hàm xác định tập nguồn và tập giao
    public void Determine_TN_TG() {
        F.forEach(fd -> {
            fd.lhs.forEach(fdLHS -> {

            });
        });
    }
}
