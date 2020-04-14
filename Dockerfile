# alpine is a very light docker image
FROM python:3.8.2-alpine
MAINTAINER Vincenzo Topazio

# unbuffer the output so it's faster
ENV PYTHONUNBUFFERED 1

# copy and install requirements
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# create app folder and copy it from the repo 
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# SECURITY COMMANDS
# -D : run application only for our project
RUN adduser -D user
# switches docker to the user
USER user
