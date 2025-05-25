class AnonymousSurvey:
    """Сбор анонимных ответов на опросы. """

    def __init__(self, question):
        """Сохраняет вопрос и готовится к сохранению вариантов ответов."""
        self.question = question
        self.responses = []

    def show_question(self):
        """Выводит вопрос"""
        print(self.question)

    def store_response(self, new_response):
        """Сохранение одного ответа"""
        self.responses.append(new_response)

    def show_results(self):
        """Вывод сохраненных ответов"""
        print("Ответы:")
        for response in self.responses:
            print("- " + response)
