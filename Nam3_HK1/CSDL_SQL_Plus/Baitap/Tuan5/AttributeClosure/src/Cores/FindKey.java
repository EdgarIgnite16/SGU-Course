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
            // Tách các chữ cái ra
            ArrayList<Character> list = new ArrayList<Character>(R);
            HashSet<Character> temp = new HashSet<>(tempR);
            temp.remove(list.get(i));

            // Set điều kiện bỏ từng chữ cái và bao đóng nó lên
            ClosureAttribute db5 = new ClosureAttribute(filePath);
            if(db5.closure(temp).equals(R)) {
                tempR.remove(list.get(i)); // nếu bao đóng bằng R thì bỏ chữ đang xét
            }
        }
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
