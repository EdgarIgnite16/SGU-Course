package Cores;

public class TableKeys {
    private String Xi;
    private String TnUXi;
    private String TnUXiPlus;
    private String SuperKey;
    private String Key;

    public TableKeys(String xi, String tnUXi, String tnUXiPlus, String superKey, String key) {
        Xi = xi;
        TnUXi = tnUXi;
        TnUXiPlus = tnUXiPlus;
        SuperKey = superKey;
        Key = key;
    }

    public String getXi() {
        return Xi;
    }

    public void setXi(String xi) {
        Xi = xi;
    }

    public String getTnUXi() {
        return TnUXi;
    }

    public void setTnUXi(String tnUXi) {
        TnUXi = tnUXi;
    }

    public String getTnUXiPlus() {
        return TnUXiPlus;
    }

    public void setTnUXiPlus(String tnUXiPlus) {
        TnUXiPlus = tnUXiPlus;
    }

    public String getSuperKey() {
        return SuperKey;
    }

    public void setSuperKey(String superKey) {
        SuperKey = superKey;
    }

    public String getKey() {
        return Key;
    }

    public void setKey(String key) {
        Key = key;
    }

    @Override
    public String toString() {
        return "TableKeys{" +
                "Xi='" + Xi + '\'' +
                ", TnUXi='" + TnUXi + '\'' +
                ", TnUXiPlus='" + TnUXiPlus + '\'' +
                ", SuperKey='" + SuperKey + '\'' +
                ", Key='" + Key + '\'' +
                '}';
    }
}
