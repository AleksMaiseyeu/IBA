import java.util.ArrayList;
import java.util.Iterator;
public class Lab7pr2 {
    public static ArrayList<String> list2;

    public static void PrintIterator(){
        list2 = new ArrayList<>();
        // добавление элементов
        list2.add("Apple");
        list2.add("Banana");
        list2.add("Cherry");

        // Итерация с помощью for-each
        for (String fruit : list2) {
            System.out.println(fruit);
        }
        System.out.println("-----------------");
        // Итерация с помощью итератора
        Iterator<String> iterator = list2.iterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }

    }
}
