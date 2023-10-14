from django.urls import re_path as url
from tasks import views

urlpatterns=[
    url('create_task/',views.createTaskApi),
    url('delete_task/',views.deleteTaskApi),
    url('edit_task/',views.editTasksApi),
    url('complete_task/',views.completeTasksApi),
    url('all_tasks/',views.getAllTasksApi),
] 
