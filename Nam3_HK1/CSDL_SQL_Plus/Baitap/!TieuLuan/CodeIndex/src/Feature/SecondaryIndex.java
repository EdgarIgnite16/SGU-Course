package Feature;

import java.util.Scanner;

public class SecondaryIndex {
    private int record, blockSize, recordSize, Vssn, blockPointer;
    private float bfr, b, Ri, bfri, ri, bi, binaraySearchDataFile, binarySearchIndexFile, linearSearchDataFile; // output value

    public SecondaryIndex(int record, int blockSize, int recordSize, int vssn, int blockPointer) {
        this.record = record;
        this.blockSize = blockSize;
        this.recordSize = recordSize;
        this.Vssn = vssn;
        this.blockPointer = blockPointer;
    }

    // main progress
    public void mainProgress() {
    }

    @Override
    public String toString() {
        return "SecondaryIndex{" +
                "record=" + record +
                ", blockSize=" + blockSize +
                ", recordSize=" + recordSize +
                ", Vssn=" + Vssn +
                ", blockPointer=" + blockPointer +
                '}';
    }
}
