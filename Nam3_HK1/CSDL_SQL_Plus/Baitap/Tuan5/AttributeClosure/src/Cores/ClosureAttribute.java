package Cores;// F is a file that has the first line all the attributes and
// then an FD a line with a space between the left-hand side and the right-hand side
// X is a string of characters represent a set of attributes
import java.io.*;
import java.util.*;

public class ClosureAttribute {
    private HashSet<Character> R = new HashSet<Character>(); // là tập hợp các chữ trong tập hợp hàm
    private HashSet<FD> F = new HashSet<FD>();  // Class chứa các phụ thuộc hàm
    private HashSet<Character> X = null; // Là bao đóng cần tìm
    private String filePath;

    // Constructor
    // Xử lí các thông tin đầu vào
    public ClosureAttribute(String filename){
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
            HashSet<Character> l = new HashSet<Character>();
            String[] terms = in.nextLine().split(" ");

            // Tạo loop lấy chữ của phụ thuộc hàm bên trái
            for(int i = 0; i < terms[0].length(); i++) {
                l.add(terms[0].charAt(i)); // bên trái
            }

            // Tạo loop lưu lại thông tin phụ thuộc hàm
            for (int i = 0; i < terms[1].length(); i++) {
                F.add(new FD(l, terms[1].charAt(i))); // add cả trái lẫn phải vào FD (Functional Dependency)
            }
        }
        in.close(); // Đóng file
    }

    // Lớp chứa các phụ thuộc hàm
    public class FD{
        HashSet<Character> lhs;
        char rhs;

        public FD(HashSet<Character> l, char r){
            this.lhs = l;
            this.rhs = r;
        }

        public boolean equals(Object obj){
            FD fd2 = (FD)obj;
            return lhs.equals(fd2.lhs) && rhs == fd2.rhs;
        }
    };

    // Chuyển bao đóng về dạng tập hợp các chữ cái của hashSet
    public HashSet<Character> string2set(String X){
        HashSet<Character> Y = new HashSet<Character>();
        for(int i = 0; i < X.length(); i++) {
            Y.add(X.charAt(i));
        }
        return Y;
    }

    // Hàm in kết quả
    public void printSet(Set<Character> X){
        for(char c: X) {
            System.out.print(c);
        }
        System.out.println();
    }

    // Hàm xử lí bao đóng
    public HashSet<Character> closure(HashSet<Character> Xinit) {
        X = new HashSet<Character>(Xinit);
        int len = 0;
        do {
            len = X.size(); // lấy kích thước tập hợp hiện tại
            // xét các phụ thuộc hàm
            F.forEach(fd -> {
                // Phụ thuộc hàm hiện tại chỉ xét vế bên trái, không xét vế bên phải
                // Nếu tập hợp hiện tại thoả phụ thuộc hàm vế trái và không thoả phụ thuộc hàm vế phải
                // => Thì thêm phụ thuộc hàm đó vào trong tập hợp bao đóng
                if (X.containsAll(fd.lhs) && !X.contains(fd.rhs)) {
                    X.add(fd.rhs);
                }
            });
        } while (X.size() > len); // vòng lặp dừng lại khi bao đóng tìm được ít nhất 1 chữ
        return X;  // trả về bao đóng
    }
}
