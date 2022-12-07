package Feature;

import java.util.Scanner;

// nondense
public class ClusteringIndex {
    private int record, blockSize, recordSize, Vssn, blockPointer, zipCode;
    private float bfr, b, Ri, bfri, ri, bi, binaraySearchDataFile, binarySearchIndexFile, linearSearchDataFile; // output value

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
    }


    @Override
    public String toString() {
        return "ClusteringIndex{" +
                "record=" + record +
                ", blockSize=" + blockSize +
                ", recordSize=" + recordSize +
                ", Vssn=" + Vssn +
                ", blockPointer=" + blockPointer +
                ", zipCode=" + zipCode +
                '}';
    }
}
