import Cores.ClosureAttribute;
import Cores.FindAllKey;
import Cores.FindKey;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EntryMain {
    public static String filePath = "Dependency_file.txt";

    public static void main(String[] args) {
        Matcher check;
        int select;
        String temp;

        do {
            System.out.println("");
            System.out.println("+---------------------------------------------+");
            System.out.println("|                    Menu                     |");
            System.out.println("| -------------------=====--------------------|");
            System.out.println("| 1. Tim bao dong                             |");
            System.out.println("| 2. Tim khoa                                 |");
            System.out.println("| 3. Tim tat ca khoa                          |");
            System.out.println("| 0. Thoat chuong trinh                       |");
            System.out.println("+---------------------------------------------+");

            // Regex
            do {
                System.out.print("Nhap vao lua chon: ");
                temp = new Scanner(System.in).nextLine();
                String c = "^[0-9]{1}";
                Pattern b= Pattern.compile(c);
                check = b.matcher(temp);
            }
            while(!check.find());
            select = Integer.parseInt(temp);

            // Xử lí
            switch (select) {
                case 1:
                    System.out.println("Ban da chon Tim bao dong");
                    System.out.print("Nhap bao dong: ");
                    String key = new Scanner(System.in).nextLine();

                    ClosureAttribute db5 = new ClosureAttribute(filePath);
                    System.out.printf("Bao dong cua %s la: ", key);
                    db5.printSet(db5.closure(db5.string2set(key)));
                    break;

                case 2:
                    System.out.println("Ban da chon Tim khoa");
                    System.out.print("Khoa cua tap hop la: ");
                    FindKey obj = new FindKey(filePath);
                    obj.printSet(obj.SplitAndFindKey());
                    break;

                case 3:
                    System.out.println("Ban da chon Tim tat ca khoa");
                    FindAllKey findAllKey = new FindAllKey(filePath);
                    findAllKey.Determine_TN_TG();
                    break;

                case 0:
                    System.out.println("Thoat chuong trinh");
                    break;

                default:
                    System.out.println("Khong co lua chon nao nhu nay !\nVui long nhap lai lua chon.");
                    break;
            }
        } while(select != 0);
    }
}
