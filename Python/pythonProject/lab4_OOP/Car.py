# Создайте класс и поля соответствующему вашему варианту (поля статические и динамические).
# Создайте три метода (класса, объекта и статический).
# Выберете поле или метод для реализации инкапсуляции.
# Пропишите запись и считывание (get, set) инкапсулированных полей.
# -------------
# Kласс Car: id, Марка, Модель, Год выпуска, Цвет, Цена, Регистрационный номер
# Функции-члены реализуют запись и считывание полей (проверка корректности), вывода возраста машины.
# Создать список объектов.
# Вывести:
# a) список автомобилей заданной марки;
# б) список автомобилей заданной модели, которые эксплуатируются больше n-лет;

from datetime import datetime
now = datetime.now()
class Car:
    __id = 0
    __count = 0
    __mark = 'mercedes'
    __color =''
    __cost = 10000
    __car = []

    def __init__(self,  model, year, reg_number):
        self.model= model
        self.year = year
        self.reg_number = reg_number

        Car.__id +=1
        Car.__count +=1

    def __del__(self):
        Car.__count -= 1

    def age(self):
        return (now.year - self.year)

    def set_mark(self, mark):
        self.__mark = mark

    def get_mark(self):
        return self.__mark

    def get_color(self):
        return self.__color

    def set_color(self, color):
        self.__color = color

    def get_cost(self):
        return self.__cost

    def set_cost(self, cost):
        self.__cost = cost

    def get_id(self):
        return self.__id

    # магический метод вывода информации об авто
    def __str__(self):
        return " ---Авто с гос.номером: " + self.reg_number + ", марка: " + self.get_mark() + ", model: " + self.model

    # магический метод сравнения моделей авто
    def __eq__(self, other):
        if not isinstance(other, (str, Car)):
            raise TypeError("Операнд справа должен иметь тип str или Car")

        qModel = other if isinstance(other, str) else other.model

        if self.model == qModel:
                res =  "модели авто совпадают"
        else:
               res = "модели авто отличаются"
        return res

    #добавим авто в список
    @classmethod
    def add_car(cls, car):
        cls.__car.append(car)

    #выведем список авто определенной марки
    @classmethod
    def showCarByMark(cls, mark):
        for i in cls.__car:
            if i.get_mark()==mark:
                print("рег. номер: ", i.reg_number, " марка: ", i.get_mark(), " cost: ", i.get_cost())

    #список автомобилей заданной модели, которые эксплуатируются больше n-лет;
    @classmethod
    def showCarByModelOlderYear(cls, model, Y):
        for cr in cls.__car:
            if cr.model == model:
                if cr.age()>Y:
                    print("рег.номер: ", cr.reg_number,
                         " марка: ", cr.get_mark(),
                         " МОДЕЛЬ: ", cr.model,
                        " cost: ", cr.get_cost(),
                        " кол-во лет эксплуатации:", cr.age())


    # Статические - особый тип методов, которые принадлежат классу, а не экземпляру класса.
    # Они не могут изменять состояние объекта, так как не имеют доступа к его состоянию.
    # Вместо этого они работают с аргументами, которые передаются в них непосредственно.
    @staticmethod
    def get_class(cost):
        if cost>=30000 :
            return 'VIP'
        else:
            return 'buget'

    # привязан к самому классу, а не к его экземплярам.
    # Первым аргументом такого метода всегда является сам класс (обычно обозначается как cls)
    # могут быть унаследованы и переопределены в подклассах
    @classmethod
    def countCar(cls):
        return print(Car.__count)


c1 = Car( "A5", 2022,"7654-IT7" )
print(c1.age())
print(c1.get_color())
c1.set_color('black')
print(c1.get_color())
c1.set_cost(23000)

print(c1)

print(c1.get_cost())
print(Car.get_class(c1.get_cost()))

c1.age()
Car.countCar()

c2 = Car("A5", 2000, "5269-yy6")
print(c1==c2)

c3 = Car("A5", 2002, "5244-TR2")
c3.set_mark('bmv')
c4 = Car("B200", 2005, "9266-IT3")
c5 = Car("C3", 2008, "9200-II4")
c5.set_mark('citroen')

Car.add_car(c1)
Car.add_car(c2)
Car.add_car(c3)
Car.add_car(c4)
Car.add_car(c5)
Car.countCar()
Car.showCarByMark('mercedes')
print('---------------------')
Car.showCarByModelOlderYear("A5", 23)

