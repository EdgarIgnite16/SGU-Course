package Feature;

import java.util.Scanner;

// nondense
public class PrimaryIndex {
    private int record, blockSize, recordSize, Vssn, blockPointer; // input value
    private float bfr, b, Ri, bfri, ri, bi, binaraySearchDataFile, binarySearchIndexFile, linearSearchDataFile; // output value

    public PrimaryIndex(int record, int blockSize, int recordSize, int vssn, int blockPointer) {
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
        return "PrimaryIndex{" +
                "record=" + record +
                ", blockSize=" + blockSize +
                ", recordSize=" + recordSize +
                ", Vssn=" + Vssn +
                ", blockPointer=" + blockPointer +
                '}';
    }
}
