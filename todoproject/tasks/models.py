from django.db import models
from authapp.models import CustomUser

class Task(models.Model):
    title = models.CharField(max_length = 255)
    description = models.TextField()
    is_completed = models.BooleanField(default = False)
    user = models.ForeignKey(CustomUser, on_delete = models.CASCADE)