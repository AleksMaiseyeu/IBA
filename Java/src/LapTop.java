public class LapTop {
    private String Brand;
    private double Size;
    private int RAM;
    private int ProdYear;

    LapTop(String Brand, double Size, int RAM, int ProdYear){
        this.Brand = Brand;
        this.Size = Size;
        this.RAM = RAM;
        this.ProdYear = ProdYear;
    }

    LapTop(String Brand, double Size, int RAM){
        this.Brand = Brand;
        this.Size = Size;
        this.RAM = RAM;
    }
    public String getBrand(){
        return Brand;
    }
    public  double getSize(){
        return Size;
    }
    public int getRAM(){
        return RAM;
    }
    public int getProdYear(){
        return ProdYear;
    }

    public String GetFullInfo(){
        String res = "";
        if (this.Brand.isEmpty())
          res += this.Brand;
        if (this.RAM!=0)
            res += ' ' + this.RAM;

        return res;
    }
}