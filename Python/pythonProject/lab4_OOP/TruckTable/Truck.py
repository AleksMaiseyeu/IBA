from math import trunc

from TruckTable.Table import Table
from TruckTable.DinnerTable import DinnerTable
from TruckTable.JournalTable import JournalTable

class Truck:
    __maxMass=0
    __table=[]
    __current_mass = 0

    def __init__(self, max_mass):
        self.__maxMass = max_mass

    def add_table(self, table):
        if self.__maxMass - self.__current_mass >= table.get_mass():
            self.__current_mass += table.get_mass()
            self.__table.append(table)
            print(table, "was added")
            print("The truck's mass", self.__current_mass, "of", self.__maxMass, "\n")
        else:
            print(table, "cann't be add\n")


truck = Truck(42)
tbl1 = Table(8)
tbl2 = Table(8)
tbl3 = DinnerTable(9)
tbl4 = DinnerTable(10)
tbl5 = JournalTable(5)
tbl6 = JournalTable(4)

truck.add_table(tbl1)
truck.add_table(tbl2)
truck.add_table(tbl3)
truck.add_table(tbl4)
truck.add_table(tbl5)
truck.add_table(tbl6)