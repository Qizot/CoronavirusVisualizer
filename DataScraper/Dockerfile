FROM python:3.7-slim

LABEL Author="Jakub Perżyło"
LABEL version="1.0.0"

ENV FLASK_APP "scraper"

RUN mkdir /app
WORKDIR /app

COPY . .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

ADD . /app


EXPOSE 5000

CMD flask run --host=0.0.0.0

