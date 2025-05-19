class Table:
    __mass = 0

    def __init__(self, mass0):
        self.__mass = mass0

    # чтение инкапсулированной массы
    def get_mass(self):
        return self.__mass
