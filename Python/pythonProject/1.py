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

# вывести тот элемент, который больше соседей
ls = [32, 11, 98, 4 ,6 ,2, -6]
newls =[]
for x in range(len(ls)):
    max =ls[0]
    if ls[x]>max and ls[x-1]<max:
        max=ls[x]
        newls.append(max)
print(newls)







