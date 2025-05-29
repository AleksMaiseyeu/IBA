from django.contrib import admin

from.models import Option, Riddle

admin.site.register(Riddle)
admin.site.register(Option)

# Register your models here.
from .models import Message
admin.site.register(Message)

from .models import Mark
admin.site.register(Mark)
