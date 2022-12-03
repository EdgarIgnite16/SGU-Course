package Feature;

import java.util.Scanner;

// nondense
public class PrimaryIndex {
    private int record, blockSize, recordSize, Vssn, blockPointer;

    public PrimaryIndex() {
    }

    public PrimaryIndex(int record, int blockSize, int recordSize, int vssn, int blockPointer) {
        this.record = record;
        this.blockSize = blockSize;
        this.recordSize = recordSize;
        this.Vssn = vssn;
        this.blockPointer = blockPointer;
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
    }
}
