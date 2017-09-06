# ref. http://jdlm.info/articles/2016/03/06/lessons-building-node-app-docker.html

FROM node:6.11.2-alpine

RUN apk update \
    && apk upgrade \
    && apk add bash

USER node

WORKDIR /home/node