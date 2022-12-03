import Feature.ClusteringIndex;
import Feature.PrimaryIndex;
import Feature.SecondaryIndex;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {
    public static void main(String[] args) {
        Matcher check;
        int select;
        String temp;

        do {
            System.out.println("");
            System.out.println("+---------------------------------------------+");
            System.out.println("|                    Menu                     |");
            System.out.println("| --------------------------------------------|");
            System.out.println("| 1. Primary Index                            |");
            System.out.println("| 2. Clustering Index                         |");
            System.out.println("| 3. Secondary Index                          |");
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
                    System.out.println("Ban da chon Primary Index!");
                    new PrimaryIndex().mainProgress();
                    break;

                case 2:
                    System.out.println("Ban da chon CLustering Index!");
                    new ClusteringIndex().mainProgress();
                    break;

                case 3:
                    System.out.println("Ban da chon Secondary Index!");
                    new SecondaryIndex().mainProgress();
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