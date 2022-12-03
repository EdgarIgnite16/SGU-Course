package Feature;

import java.util.Scanner;

// nondense
public class ClusteringIndex {
    private int record, blockSize, recordSize, Vssn, blockPointer, zipCode;

    public ClusteringIndex() {
    }

    public ClusteringIndex(int record, int blockSize, int recordSize, int vssn, int blockPointer, int zipCode) {
        this.record = record;
        this.blockSize = blockSize;
        this.recordSize = recordSize;
        this.Vssn = vssn;
        this.blockPointer = blockPointer;
        this.zipCode = zipCode;
    }

    // main progress
    public void mainProgress() {
        this.inputData(); // 1

    }

    // input
    private void inputData() {
        System.out.print("Record Size (R): "); recordSize = new Scanner(System.in).nextInt();
        System.out.print("Block Size (B): "); blockSize = new Scanner(System.in).nextInt();
        System.out.print("Block Pointer (P): "); blockPointer = new Scanner(System.in).nextInt();
        System.out.print("SSN Field (Vssn): "); Vssn = new Scanner(System.in).nextInt();
        System.out.print("Number of Record (r): "); record = new Scanner(System.in).nextInt();
        System.out.print("Zipcode: "); zipCode = new Scanner(System.in).nextInt();
    }
}
