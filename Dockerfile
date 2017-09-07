# ref. http://jdlm.info/articles/2016/03/06/lessons-building-node-app-docker.html

FROM node:6.11.2-alpine

RUN apk update \
    && apk upgrade \
    && apk add bash

RUN addgroup -S app && adduser -S -g app app

ENV HOME=/home/app

COPY package.json npm-shrinkwrap.json $HOME/app/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/app
RUN npm install \
    && npm cache clean

CMD ["node", "index.js"]