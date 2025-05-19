class Tribonachi:
    mas = []
    def __init__(self):
        self.mas = [0,1,2]


    def ShowQ(self, num):
        i = 3
        while i < num:
            self.mas.append(self.mas[i - 1] + self.mas[i - 2] +self.mas[i-3])
            i += 1

        print("Ряд трибоначчи до ", num, ":", self.mas)


Tribonachi().ShowQ(32)
#T.ShowQ(32)
