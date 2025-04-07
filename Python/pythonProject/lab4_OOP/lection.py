class Phone:
    def __init__(self, color, model,os):
        self.color = color
        self.model = model
        self.os =os

    @classmethod
    def toy_phone(cls, color):
        toy_phone = cls(color, 'ToyPhone', None)
        return toy_phone


    #статический метод
    @staticmethod
    def model_hash(model):
        if model=='i785':
            return 34565
        elif model=='K498':
            return 45567
        else:
            return None

    # обычный метод, здесь есть self
    def check_sim(self, mobile_operator):
        pass

print(Phone.model_hash('i785'))
my_toy_phone = Phone.toy_phone('Red')
print(my_toy_phone)

