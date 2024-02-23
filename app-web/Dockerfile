FROM node:21-alpine3.18

WORKDIR /app-web

# install elm
RUN apk add curl
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
RUN gunzip elm.gz
RUN chmod +x elm
RUN mv elm /usr/local/bin

COPY . .

RUN npm install
RUN npx elm-tooling install

CMD ["npm", "run", "dev"]

EXPOSE 49518
