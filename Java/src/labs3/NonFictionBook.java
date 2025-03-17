package labs3;

// научная книга наследник от КНИГА. поля: тематика, сложность
public class NonFictionBook extends Book {
    String subjects;
    int complexity;
    
  public NonFictionBook(String name,String author, int pageCount, String subjects, int complexity){
      super(name,author,pageCount);
      this.subjects = subjects; 
      this.complexity = complexity;
  }  
    public String getSubjects(){
      return this.subjects;
    }

    public int getComplexity()
    {
       return complexity;
    }
}
