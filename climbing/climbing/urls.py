"""climbing URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from climbing import settings
from django.urls.conf import include
from backend import views
from django.contrib import admin
from django.urls import path
from django.conf.urls.static import static
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r"categories", views.CategoryViewSet)
router.register(r"groups", views.GroupViewSet)
router.register(r"images", views.ImageViewSet)
router.register(r"tracks", views.TrackViewSet)
router.register(r"users", views.UserViewSet)

urlpatterns = [
    path("api/", include(router.urls)),
    path(r"auth/", include("djoser.urls")),
    path(r"auth/", include("djoser.urls.authtoken")),
    path("admin/", admin.site.urls),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
