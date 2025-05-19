import matplotlib.pyplot as plt
import numpy

#x = [1,2,3,4,5]
#y = [20,20,20, 20, 20]
#plt.plot(x, y)
#plt.title("Title")
#plt.show()

x = ['Январь', 'Февраль', 'Март', 'Апрель', 'Май']
y = [2, 4, 3, 1, 7]
plt.bar(x, y)
plt.show()

plt.pie(y, labels=x)
plt.show()


def under1(el):
    for item in el:
        return item + 1


x = [1, 2, 3, 4, 5]
y = [1, 2, 3, 4, 5]
x1 = [2, 3, 4, 5, 6]
y1 = [2, 3, 4, 5, 6]
plt.plot(x, y)
plt.plot(x1, y)
plt.plot(x, y1)
plt.show()

import numpy as np

n = np.pow(x, 3)
plt.plot(x, n)
plt.show()

