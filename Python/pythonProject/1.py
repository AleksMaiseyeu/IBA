import numpy
print('Hi Jack')
print(2+2)
print("cd")
a=5
b=6
print('a=', a+b)
if a <= 2:
    print('<2')
else:
    print('>2')

for x in numpy.arange(0.1, 0.6, 0.1):
    y=2**x
    print(y)

try:
    var = 5 / 0
except:
    print(1)


c = [c * 3 for c in 'alex' if c!='e']
print(c)

print('------------------------------------')



print('Задание: вывести тот элемент, который больше соседей')
# постановка задачи
# значение слева и справа должны должны быть меньше текущего значения
# дополнительные условия:
# - если это крайнее значение то его сравниваем только с ближайшим
# - значение элемента сравниваем со значениями слева и справа

ls = [32, 11, 98, 4 ,6 ,2, -6]
print(f"Исходный список: {ls}")
newls =[]
MaxIndex = len(ls)-1 # нужен для проверки крайнего значения,
# minIndex однозначено = 0 его не объявляем

for x in range(len(ls)):
    Value = ls[x]
    # сравниваем только со след значением
    if x==0:
        if Value>ls[x+1]:
            newls.append(Value)
    elif x==MaxIndex:
        if Value > ls[x - 1]:
            newls.append(Value)
    else:
        if Value>ls[x+1] and Value>ls[x-1]:
            newls.append(Value)
print('*****************************')
print(f"Большими элементами являются: {newls}")







