import io
# Скопируйте в папку с проектом файл «food.csv», содержащий таблицу
# со строками стихотворения для игры в «съедобное-несъедобное» с названиями предметов в
# первой колонке и признак съедобности этих предметов во второй


# главная программа:
# создание итерируемого объекта - строк файла
main_iter = io.open('food.csv')

# вывод инструкций
print("Игра \"Съедобное-несъедобное\".")
print("Вам будут по очереди выводится названия предметов.")
print("Вводите 0 если предмет несъедобный и 1 - если съедобный.")
print("Для начала нажмите Enter.")
input()
score = 0

# проход по итерируемому объекту с помощью цикла
for line in main_iter:
    # разбиение строки на ячейки по точкам с запятой
    cells = line.split(';')
    # вывод текущего элемента
    print(cells[0])
    # ввод ответа
    inbuf = input()
    # проверка правильности ответа
    if inbuf[0] == cells[1][0]:
        print("Правильно!")
        score += 1
    else:
        print("Неправильно!")
    # вывод набранных очков
print("Вы набрали " + str(score) + " очков.")
print("КОНЕЦ.")
