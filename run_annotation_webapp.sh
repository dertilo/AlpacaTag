#!/usr/bin/env bash

# set -e
# set -o errexit

app=AlpacaTag/annotation/AlpacaTag

echo "from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.all())" | python ${app}/manage.py shell
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(\"${ADMIN_USERNAME}\", \"${ADMIN_EMAIL}\", \"${ADMIN_PASSWORD}\")" | python ${app}/manage.py shell
echo "from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.all())" | python ${app}/manage.py shell

/usr/local/bin/python "${app}/manage.py" runserver "${HOST}:${PORT}"
