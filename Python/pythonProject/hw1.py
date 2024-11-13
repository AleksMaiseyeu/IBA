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

# Введите одномерный целочисленный список. Найдите наибольший нечетный элемент.
maxX = newls[0]
for y in range(len(newls)):
    if y % 2==1:
        if newls[y]>maxX:
            maxX=newls[y]
print(maxX)

# В матрице найти номер строки, сумма чисел в которой максимальна.

Matr = [[1, 4, 5], [-5, 8, 9], [3, 4, -3]]
