from django.db import models
from django.contrib.auth.hashers import make_password, check_password

class CustomUser(models.Model):
    userId = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)  
    email = models.EmailField(max_length=50, default='test@example.com', unique=True)
    password = models.CharField(max_length=128)
    def save(self, *args, **kwargs):
        if not self.pk: # check if the object is being created for the first time
            self.password = make_password(self.password) # encrypt the password
        super(CustomUser, self).save(*args, **kwargs)