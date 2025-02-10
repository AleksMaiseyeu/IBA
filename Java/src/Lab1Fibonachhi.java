public class Lab1Fibonachhi {
    public static void PrintFibonachhiNumb( int countNumb){
        int[] array = new int[countNumb];
        int Value =1;
        array[0]=0;

        for (int i=1; i<countNumb; i++) {
            array[i] = Value;
            Value = array[i-1] + Value;
            // Тут же выводим
            System.out.println(array[i]);
        }


    }
}
