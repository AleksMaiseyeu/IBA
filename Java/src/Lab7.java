import java.util.ArrayList;

public class Lab7 {
    public static ArrayList<String> list;
    public static void MyPrint(){
        list = new ArrayList<>();
        // добавление элементов
        list.add("Java");
        list.add("Python");
        list.add("C++");

//      вывод элементов
        System.out.println("Original list:" + list);
        list.add(1, "JavaScript");
        System.out.println("After insert list:" + list);

//      get Element
        String FirstElem = list.get(0);
        System.out.println("FirstElem: "+ FirstElem);

        // Удаление элемента
        list.remove("C++");
        System.out.println("After Remove: " + list);

        // Замена элемента
        list.set(2, "C#");
        System.out.println("After Replacement: " + list);

        // Проверка размера и пустоты
        System.out.println("Size: " + list.size());
        System.out.println("Is Empty: " + list.isEmpty());

        // Очистка списка
        list.clear();
        System.out.println("After Clearing: " + list);
    }
}
