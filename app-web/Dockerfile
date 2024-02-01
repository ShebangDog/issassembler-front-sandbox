FROM alpine:3.19.1 AS build-app-web

WORKDIR /app
COPY ./app-web /app

# install elm
RUN apk add curl
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
RUN gunzip elm.gz
RUN chmod +x elm
RUN mv elm /usr/local/bin

# build app with elm make
RUN elm make src/Main.elm --output=/dist/main.js
