FROM ufoym/deepo:pytorch-py36-cu100

RUN apt-get update && apt-get install -y ssh-client
WORKDIR /alpaca

RUN git clone https://github.com/dertilo/AlpacaTag.git
RUN cd AlpacaTag && pip install -r requirements.txt
RUN python -m spacy download en

RUN cd AlpacaTag/alpaca_server && python -m pip install .
RUN cd AlpacaTag/alpaca_client && python -m pip install .

RUN apt-get -y install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs

RUN cd AlpacaTag/annotation/AlpacaTag/server && npm install && npm run build
RUN cd AlpacaTag/annotation/AlpacaTag && python manage.py migrate