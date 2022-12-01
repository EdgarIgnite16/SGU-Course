package Feature;

// nondense
public class ClusteringIndex {
    private int record, blockSize, recordSize, Vssn, blockPointer, zipCode;

    public ClusteringIndex() {
    }

    public ClusteringIndex(int record, int blockSize, int recordSize, int vssn, int blockPointer, int zipCode) {
        this.record = record;
        this.blockSize = blockSize;
        this.recordSize = recordSize;
        Vssn = vssn;
        this.blockPointer = blockPointer;
        this.zipCode = zipCode;
    }


}
