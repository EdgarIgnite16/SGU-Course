import Feature.ClusteringIndex;
import Feature.PrimaryIndex;
import Feature.SecondaryIndex;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.zip.ZipEntry;

public class Main {
    public static void main(String[] args) {
        // Thực thi cả 3 feature: PrimaryKey, ClusteringKey, SecondaryKey
        readFileTask("Task_1.txt", 1); // PrimaryKey
        readFileTask("Task_2.txt", 2); // ClusteringKey
        readFileTask("Task_3.txt", 3); // SecondaryKey
    }

    private static void readFileTask(String fileName, int task) {
        float record = 0, blockSize = 0, recordSize = 0, Vssn = 0, blockPointer = 0, zipCode = 0;
        Scanner file = null;

        // Try-catch case: Tìm thấy/Không tìm thấy thư mục
        try {
            file = new Scanner(new File(fileName));
        } catch (FileNotFoundException e){
            System.err.println(fileName + " không tìm thấy!");
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

        // Thực thi chương trình
        switch (task) {
            case 1 -> new PrimaryIndex(record, blockSize, recordSize, Vssn, blockPointer).mainProgress();
            case 2 -> new ClusteringIndex(record, blockSize, recordSize, Vssn, blockPointer, zipCode).mainProgress();
            case 3 -> new SecondaryIndex(record, blockSize, recordSize, Vssn, blockPointer).mainProgress();
        }
    }
}