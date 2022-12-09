package Feature;

import java.util.Scanner;

// nondense
public class PrimaryIndex {
    private float record, blockSize, recordSize, Vssn, blockPointer; // input value
    private float bfr, b, Ri, bfri, ri, bi, binaraySearchDataFile, binarySearchIndexFile, binraySearchWithSupportIndex, linearSearchDataFile; // output value

    public PrimaryIndex(float record, float blockSize, float recordSize, float vssn, float blockPointer) {
        this.record = record;
        this.blockSize = blockSize;
        this.recordSize = recordSize;
        this.Vssn = vssn;
        this.blockPointer = blockPointer;
    }

    // main progress
    public void mainProgress() {
        bfr = (float) Math.floor(blockSize/recordSize); //Blocking factor
        b = (float) Math.ceil(record/bfr); // Number of Block needed for the file
        Ri =  Vssn + blockPointer; // The size of each index Entry
        bfri =  (float) Math.floor(blockSize/Ri); // The blocking factor for the index
        ri = b; // The total number of index entries
        bi = (float) Math.ceil(ri/bfri); // The number of index blocks is hence
        binaraySearchDataFile = (float) Math.ceil(Math.log10(b)/Math.log10(2)); // A binary search on the data file
        linearSearchDataFile = (float) Math.ceil(b/2); // A Linear search on the data file
        binarySearchIndexFile = (float) Math.ceil(Math.log10(bi)/Math.log10(2)); // A binary search on the index file
        binraySearchWithSupportIndex = binarySearchIndexFile + 1;

        System.out.println("Đáp án task 1!");
        System.out.printf("1. What is the blocking factor value of the data file? Kết quả = %.0f\n", bfr);
        System.out.printf("2. How many data blocks are there for the data file? Kết quả = %.0f\n", b);
        System.out.printf("3. How many block accesses for a linear search on the data file? Kết quả = %.0f\n", linearSearchDataFile);
        System.out.printf("4. How many block accesses for a binary search on the data file? Kết quả = %.0f\n", binaraySearchDataFile);
        System.out.printf("5. How many block accesses for a binary search on the index file? Kết quả = %.0f\n", binarySearchIndexFile);
        System.out.printf("6. How many block accesses for a binary search with the support of Primary Index? Kết quả = %.0f\n\n", binraySearchWithSupportIndex);
    }

    @Override
    public String toString() {
        return "PrimaryIndex{" +
                "record=" + record +
                ", blockSize=" + blockSize +
                ", recordSize=" + recordSize +
                ", Vssn=" + Vssn +
                ", blockPointer=" + blockPointer +
                '}';
    }
}
