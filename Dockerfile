# alpine is a very light docker image
FROM python:3.8.2-alpine
MAINTAINER Vincenzo Topazio

# unbuffer the output so it's faster
ENV PYTHONUNBUFFERED 1

# copy source code into the image and install requirements
COPY ./requirements.txt /requirements.txt

# apk: alpine package manager
# --update: update the registry before package is added
# --no-cache: don't store the registry index on our docker file to minimize
#             files in the container
# --virtual: set up alias dependencies to remove dependencies later
RUN apk update
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      # all dependecies needed to install postgres into docker image
      gcc libc-dev linux-headers postgresql-dev

# install python modules in requirements.txt file
RUN pip install -r /requirements.txt
# remove temporary dependencies added before
RUN apk del .tmp-build-deps

# create app folder and copy it from the repo
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# SECURITY COMMANDS
# -D : run application only for our project
RUN adduser -D user
# switches docker to the user
USER user
