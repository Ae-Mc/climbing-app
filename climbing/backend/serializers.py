from django.contrib.auth.models import User, Group
from .models import Category, Image, Track
from rest_framework import serializers


class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ["name"]


class UserSerializer(serializers.HyperlinkedModelSerializer):
    groups = GroupSerializer(many=True)

    class Meta:
        model = User
        fields = ("url", "username", "email", "groups")


class CategorySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Category
        fields = ["id", "name"]


class ImageSerializer(serializers.HyperlinkedModelSerializer):
    track = serializers.PrimaryKeyRelatedField(queryset=Track.objects.all())
    image = serializers.ImageField(use_url=True)

    class Meta:
        model = Image
        fields = ["track", "image"]


class ImageReadSerializer(serializers.ModelSerializer):
    class Meta:
        model = Image
        fields = ["url", "image"]


class TrackSerializer(serializers.HyperlinkedModelSerializer):
    author = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())
    category = serializers.SlugRelatedField(
        slug_field="name",
        queryset=Category.objects.all(),
    )

    class Meta:
        model = Track
        fields = [
            "id",
            "name",
            "category",
            "author",
            "description",
        ]


class TrackReadSelializer(serializers.ModelSerializer):
    author = UserSerializer(read_only=True)
    category = serializers.SlugRelatedField(slug_field="name", read_only=True)
    images = ImageReadSerializer(many=True, default=[], source='image_set')

    class Meta:
        model = Track
        fields = [
            "url",
            "name",
            "category",
            "author",
            "description",
            "images",
        ]
