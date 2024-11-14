import java.util.ArrayList;
public class Lab7pr3 {
    public static ArrayList<Integer> numbers;

    public static void Exampl3(){
        numbers = new ArrayList<>();
        numbers.add(1);
        numbers.add(12);
        numbers.add(-3);
        // Суммирование элементов
        int sum = 0;
        for (int number : numbers) {
            sum += number;
        }
        System.out.println("Sum: " + sum);
    }
}
