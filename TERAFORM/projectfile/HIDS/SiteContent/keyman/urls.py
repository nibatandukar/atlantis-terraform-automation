from django.urls import path, re_path

from . import views

urlpatterns = [
    path('', views.connectTest, name='test'),
    re_path(r'^(?P<hash>.{40})', views.index, name='index'),
]
