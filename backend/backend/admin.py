from django.contrib import admin
from .models import Category, Image, Track

# Register your models here.

admin.site.register(Category)
admin.site.register(Track)
admin.site.register(Image)
