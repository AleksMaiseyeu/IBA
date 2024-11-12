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
