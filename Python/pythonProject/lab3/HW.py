# Задача на рекурсию
# Реализуйте рекурсивную функцию нарезания прямоугольника с заданными пользователем
# сторонами a и b на квадраты с наибольшей возможной на каждом этапе стороной.
# Выведите длины ребер получаемых квадратов и кол-во полученных квадратов.

a = int(input("Сторона прямоугольнника: а"))
b = int(input("Сторона прямоугольнника: b"))

counter =0

def CutRectangle(a, b):
    l = 0
    if (a>0 and b>0):
      if a<b:
        b=b-a
        l=a
      else:
        a=a-b
        l=b
      global counter
      print(f"Длина ребра = {l}")
      counter=counter+1
      CutRectangle(a, b)
    else:
      print(f"Stop: counter={counter}")

CutRectangle(a, b)