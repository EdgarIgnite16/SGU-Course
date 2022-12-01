package Feature;

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


}
