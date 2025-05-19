from TruckTable.Table import Table

class DinnerTable(Table):
    __places = 0

    def __init__(self, mass0):
        Table.__init__(self, mass0)
        self.__places = mass0//5

    # чтение инкапсулированного числа мест
    def get_places(self):
        return self.__places