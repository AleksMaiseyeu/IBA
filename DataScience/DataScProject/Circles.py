import matplotlib.pyplot as plt
import numpy


circle1 = plt.Circle((0, 0), 0.2, color='red', fill=False)
ax=plt.gca()
ax.add_patch(circle1)
plt.axis('scaled')

cr1 = plt.Circle((0.2,0), 0.2, color='blue',fill=False)
ax=plt.gca()
ax.add_patch(cr1)
plt.axis('scaled')


cr1 = plt.Circle((0,0.4), 0.2, color='black',fill=False)
ax=plt.gca()
ax.add_patch(cr1)
plt.axis('scaled')

cr1 = plt.Circle((0,0.5), 0.1, color='green',fill=False)
ax=plt.gca()
ax.add_patch(cr1)
plt.axis('scaled')

cr1 = plt.Circle((0,0.5), 0.1, color='yellow',fill=True)
ax=plt.gca()
ax.add_patch(cr1)
plt.axis('scaled')


plt.show()
