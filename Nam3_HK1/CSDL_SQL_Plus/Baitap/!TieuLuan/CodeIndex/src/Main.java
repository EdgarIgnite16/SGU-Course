import Feature.ClusteringIndex;
import Feature.PrimaryIndex;
import Feature.SecondaryIndex;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        int record = 0, blockSize = 0, recordSize = 0, Vssn = 0, blockPointer = 0, zipCode = 0;
        Scanner file = null;
        String filename = "importData.txt";

        // Try-catch case: Tìm thấy/Không tìm thấy thư mục
        try {
            file = new Scanner(new File(filename));
        } catch (FileNotFoundException e){
            System.err.println(filename + " không tìm thấy!");
            System.exit(1);
        }

        // Đọc dữ liệu từ file
        while(file.hasNextLine()) {
            // Đọc ghi dữ liệu vào biến
            String[] terms = file.nextLine().split(":");
            switch (terms[0]) {
                case "Record_Size_(R)" -> recordSize = Integer.parseInt(terms[1]);
                case "Block_Size_(B)" -> blockSize = Integer.parseInt(terms[1]);
                case "Block_Pointer_(P)" -> blockPointer = Integer.parseInt(terms[1]);
                case "SSN_Field_(Vssn)" -> Vssn = Integer.parseInt(terms[1]);
                case "Number_of_Record (r)" -> record = Integer.parseInt(terms[1]);
                case "Zipcode" -> zipCode = Integer.parseInt(terms[1]);
            }

        }
        file.close(); // Đóng file

        // Thực thi cả 3 feature: PrimaryKey, ClusteringKey, SecondaryKey
        new PrimaryIndex(record, blockSize, recordSize, Vssn, blockPointer).mainProgress();
        new ClusteringIndex(record, blockSize, recordSize, Vssn, blockPointer, zipCode).mainProgress();
        new SecondaryIndex(record, blockSize, recordSize, Vssn, blockPointer).mainProgress();
    }
}