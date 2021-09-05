import time
from django.db import models
from django.contrib.auth.models import User
from django.db.models import deletion
from django.utils import timezone


def generate_imageset_upload_to(instance, filename=None):
    return f"images/{instance.id}_{str(int(time.time()))}.png"


class Category(models.Model):
    name = models.CharField(max_length=10, unique=True)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ["name"]


class Track(models.Model):
    name = models.CharField(max_length=300)
    description = models.TextField()
    category = models.ForeignKey(
        Category, on_delete=deletion.PROTECT, related_name="category"
    )
    author = models.CharField(max_length=100)
    uploader = models.ForeignKey(
        User, on_delete=deletion.PROTECT, related_name="uploader"
    )
    creationDate = models.DateField(default=timezone.now)

    def __str__(self):
        return f"Track object ({self.id}) {self.name} by {self.author}"


class Image(models.Model):
    track = models.ForeignKey(Track, on_delete=deletion.CASCADE)
    image = models.ImageField(upload_to=generate_imageset_upload_to)
