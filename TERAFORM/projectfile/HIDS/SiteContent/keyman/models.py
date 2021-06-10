from django.db import models

class KeyMap(models.Model):
    Region = models.CharField(max_length=10)
    hostname = models.CharField(max_length=200,default=None, blank=True, null=True)
    key = models.CharField(max_length=500)

