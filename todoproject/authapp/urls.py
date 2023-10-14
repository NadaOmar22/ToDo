from django.urls import re_path as url
from authapp import views
from django.conf.urls.static import static
from django.conf import settings


urlpatterns=[
    url('register/',views.userRegisterApi),
    url('login/',views.userLoginApi),
] 