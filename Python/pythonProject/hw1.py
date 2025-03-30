# Удалить в списке все числа, которые повторяются более двух раз.

ls = [1,2,3,1,1,2,9,9,7,5,5]

# for x in range(len(ls)):
#     for j in range(ls.count(ls[x])-1):
#         if ls.count(ls[x])>1:
#             ls.remove(ls[x])
# print(ls)

newls = []
for x in range(len(ls)):
    newls.count(ls[x])
    if newls.count(ls[x])==0:
        newls.append(ls[x])
print(newls)

# Task 1.2 lab 2
# Введите одномерный целочисленный список. Найдите наибольший нечетный элемент.
maxX = newls[0]
for y in range(len(newls)):
    if y % 2==1:
        if newls[y]>maxX:
            maxX=newls[y]
print(maxX)

# Task 2.1 lab2
# ---------------------------------------------------------------
print('В матрице найти номер строки, сумма чисел в которой максимальна')
Matr = [[11, 4, 5], [-5, 8, 9], [3, 1, 4, -3],[2, 3, -4, 9]]
# идем циклом по списку

lineCounter =0
SumLine=0
print('----------------------------------')
print(Matr)
for x in range(len(Matr)):
    S = 0
    for y in range(len(Matr[x])):
        S+=Matr[x][y]
        if S>SumLine:
            SumLine=S
            lineCounter = x
    print(f"в строке {x+1} сумма элементов равна:{S}")
# делаем +1 к х т.к. строки считаем с 1 а не с 0
print("***********************************")
print(f"Максимальное значение элементо: {SumLine} в строке {lineCounter+1}")




