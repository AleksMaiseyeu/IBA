from django.db import models


class Riddle(models.Model):
    riddle_text = models.CharField(max_length=255)
    pub_date = models.DateTimeField('date published')


class Option(models.Model):
    riddle = models.ForeignKey(Riddle, on_delete=models.CASCADE)
    text = models.CharField(max_length=255)
    correct = models.BooleanField(default=False)

from  django.contrib.auth.models import User
# тип "временнАя зона" для получения текущего времени
from django.utils import timezone

class Message(models.Model):
    chat = models.ForeignKey(
    Riddle,
    verbose_name='Чат под загадкой',
    on_delete=models.CASCADE)
    author = models.ForeignKey(
        User,
    verbose_name='Пользователь', on_delete=models.CASCADE)
    message = models.TextField('Сообщение')
    pub_date = models.DateTimeField(
'Дата сообщения',
    default=timezone.now)


# Create your models here.
class Mark(models.Model):
    riddle = models.ForeignKey(
        Riddle,
        verbose_name='Загадка',
        on_delete=models.CASCADE)
    author = models.ForeignKey(
        User,
        verbose_name='Пользователь',on_delete=models.CASCADE)
    mark = models.IntegerField(
        verbose_name='Оценка')
    pub_date = models.DateTimeField(
'Датаоценки',
             default=timezone.now)
