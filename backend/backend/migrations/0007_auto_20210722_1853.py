# Generated by Django 3.1.6 on 2021-07-22 15:53

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('backend', '0006_track_creationdate'),
    ]

    operations = [
        migrations.AddField(
            model_name='track',
            name='uploader',
            field=models.ForeignKey(default=2, on_delete=django.db.models.deletion.PROTECT, related_name='uploader', to='auth.user'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='category',
            name='id',
            field=models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
        migrations.AlterField(
            model_name='image',
            name='id',
            field=models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
        migrations.AlterField(
            model_name='track',
            name='author',
            field=models.CharField(max_length=100),
        ),
        migrations.AlterField(
            model_name='track',
            name='id',
            field=models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
        migrations.AlterField(
            model_name='track',
            name='name',
            field=models.CharField(max_length=300),
        ),
    ]