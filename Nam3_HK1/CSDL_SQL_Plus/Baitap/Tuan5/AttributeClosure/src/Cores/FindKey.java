package Cores;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class FindKey {
    private HashSet<Character> R = new HashSet<Character>(); // là tập hợp các chữ trong tập hợp hàm
    private String filePath;

    // Constructor
    // Xử lí các thông tin đầu vào
    public FindKey(String filename){
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

        in.close(); // Đóng file
    }


    public HashSet<Character> SplitAndFindKey() {
        HashSet<Character> tempR = new HashSet<>(R); // tạo bản sao R gốc
        // Tạo vòng lặp lặp qua tương ứng với số lượng chữ cái có trong tập hợp
        for(int i = 0; i < R.size(); i++) {
            ClosureAttribute db5 = new ClosureAttribute(filePath);

            // Tách các chữ cái ra
            ArrayList<Character> list = new ArrayList<Character>(R);
            HashSet<Character> temp = new HashSet<>(tempR);

            System.out.print("Bo " + list.get(i));
            temp.remove(list.get(i));
            System.out.println(" Tim bao dong " + temp + "+: " + db5.closure(temp));

            // Set điều kiện bỏ từng chữ cái và bao đóng nó lên
            if(db5.closure(temp).equals(R)) {
                tempR.remove(list.get(i)); // nếu bao đóng bằng R thì bỏ chữ đang xét
                System.out.println("Ma " + temp + "+ = R |||| "+ "Vay R: " +tempR);
            } else {
                System.out.println("Vi " + list.get(i) + " != R |||| " + "Giu " + list.get(i));
            }

            System.out.println();
        }

        System.out.print("Khoa cua tap hop la: ");
        return tempR;
    }

    // Hàm in kết quả
    public void printSet(Set<Character> X){
        for(char c: X) {
            System.out.print(c);
        }
        System.out.println();
    }

}
