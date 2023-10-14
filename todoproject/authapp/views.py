from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from django.http.response import JsonResponse
from .models import CustomUser
from authapp.serializer import UserSerializer
from django.contrib.auth.hashers import check_password

@csrf_exempt
def userRegisterApi(request):
    if request.method == 'POST':
        user_data = JSONParser().parse(request)
        user_serializer = UserSerializer(data=user_data)
        if user_serializer.is_valid():
            user_serializer.save()
            return JsonResponse({"message": "Added Successfully!!"}, safe=False)
        return JsonResponse("Failed to Add.", safe=False)
    else:
        return JsonResponse("Error: Wrong Method Type", safe=False)

@csrf_exempt
def userLoginApi(request):
    if request.method == 'POST':
        user_data = JSONParser().parse(request)
        if CustomUser.objects.filter(email=user_data['email']):
            user = CustomUser.objects.get(email=user_data['email'])
            password = user_data['password']
            if check_password(password, user.password):
                return JsonResponse({"message": "LoggedIn Successfully!!"}, safe=False)
        return JsonResponse("Invalid email or password.", safe=False)
    else:
        return JsonResponse("Error: Wrong Method Type", safe=False)
