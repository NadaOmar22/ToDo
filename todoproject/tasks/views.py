from django.http import JsonResponse
from .models import Task
from django.views.decorators.csrf import csrf_exempt
from authapp.models import CustomUser

from rest_framework.parsers import JSONParser
import json

from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse

@csrf_exempt
def createTaskApi(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        email = data['email']
        user = CustomUser.objects.get(email=email)
        if user:
            newTask = Task(
                title = data['title'],
                description = data['description'],
                user = user
                  )
            newTask.save()            
            return JsonResponse("task created sucessfully!!", safe=False)
    else:
        return JsonResponse("wrong method type", safe=False)

@csrf_exempt
def deleteTaskApi(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        email = data['email']
        user = CustomUser.objects.get(email=email)
        if user:
            task_id = data['id']
            try:
                task = Task.objects.get(id=task_id, user=user)
                task.delete()
                return JsonResponse("Task deleted successfully!", safe=False)
            except Task.DoesNotExist:
                return JsonResponse("Task not found for the user", safe=False)
    else:
        return JsonResponse("Wrong method type", safe=False)

@csrf_exempt
def editTasksApi(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        email = data['email']
        user = CustomUser.objects.get(email=email)
        if user:
            task_id = data['id']
            try:
                task = Task.objects.get(id=task_id, user=user)
                task.title = data['title']
                task.description = data['description']
                task.save()
                return JsonResponse("Task edited successfully!", safe=False)
            except Task.DoesNotExist:
                return JsonResponse("Task not found for the user", safe=False)
    else:
        return JsonResponse("Wrong method type", safe=False)

@csrf_exempt
def completeTasksApi(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        email = data['email']
        user = CustomUser.objects.get(email=email)
        if user:
            task_id = data['id']
            try:
                task = Task.objects.get(id=task_id, user=user)
                task.is_completed = True
                task.save()
                return JsonResponse("Task completed successfully!", safe=False)
            except Task.DoesNotExist:
                return JsonResponse("Task not found for the user", safe=False)
    else:
        return JsonResponse("Wrong method type", safe=False)

@csrf_exempt
def getAllTasksApi(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        print(data);
        email = data['email']
        print("email in all tasks function")
        print(email)
        user = CustomUser.objects.get(email=email)
        if user:
            tasks = Task.objects.filter(user=user)
            user_tasks = []
            for task in tasks:
                serialized_task = {
                    "title": task.title,
                    "description": task.description,
                    "id": task.id,
                    "iscomplete": int(task.is_completed)
                }
                user_tasks.append(serialized_task)
            return JsonResponse(user_tasks, safe=False)
    else:
        return JsonResponse("Wrong method type", safe=False)


