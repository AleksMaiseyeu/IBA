package labs3;

public class Book {
    // класс книга
    // количество страниц, название , автор
    protected String Name;
    protected String Author;
    protected int PageCount;

    Book(String name, String auther, int pageCount ){
        this.Name = name;
        this.Author = auther;
        this.PageCount = pageCount;
    }
    Book(String name, String auther){
        this.Name = name;
        this.Author = auther;
    }

    public String GetName(){
        return this.Name;
    }
    public String GetAuther(){
        return this.Author;
    }
    public int GetPageCount(){
        return this.PageCount;
    }
}
