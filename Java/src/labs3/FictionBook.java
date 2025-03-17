package labs3;

// класс Художественная книга наслденик от КНИГИ имеет поле Жанр
public class FictionBook extends Book {
   String Genre;
   public FictionBook(String name,String author, int pageCount, String genre){
       // вызываем конструктор родителя
       super(name,author,pageCount);
       this.Genre = genre;
   }
   // получим жанр
   public String getGenre(){
       return this.Genre;
   }
}
