package labs3;

public class lab3_ExtendsClass {

   public static void Show () {

       FictionBook book1 = new FictionBook("The Adventures of Huckleberry Finn", "Mark Twain", 253, "Adventures");
       Book book2 = new FictionBook("Pride and Prejudice", "Jane Austen", 411, "novel");
       Book book3 = new NonFictionBook("A Brief History of Time", "Stephen Hawking", 578, "phisycs", 8);

       book1.getGenre();
       book2.GetName();
   }

}
