FROM python:3.8.2-alpine
MAINTAINER Vincenzo Topazio

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# SECURITY COMMANDS
# -D : run application only for our project
RUN adduser -D user
# switches docker to the user
USER user
