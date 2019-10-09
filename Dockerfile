FROM ufoym/deepo:pytorch-py36-cu100

WORKDIR /alpaca

RUN apt-get update && apt-get install -y ssh-client
RUN apt-get -y install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs
RUN pip install -U --no-cache-dir spacy flair pandas
RUN python -m spacy download en

#RUN git clone https://github.com/dertilo/AlpacaTag.git
COPY . /alpaca/AlpacaTag/
RUN cd AlpacaTag && pip install -r requirements.txt

RUN cd AlpacaTag/alpaca_server && pip install .
RUN cd AlpacaTag/alpaca_client && pip install .

RUN cd AlpacaTag/annotation/AlpacaTag/server && npm install && npm run build
RUN cd AlpacaTag/annotation/AlpacaTag && python manage.py migrate
RUN cd AlpacaTag/annotation/AlpacaTag && echo "from django.contrib.auth.models import User;User.objects.get(username='admin', is_superuser=True).delete()" | python manage.py shell