FROM node:16-alpine

RUN mkdir /server

WORKDIR /server

COPY ./server/package.json /server

RUN npm install

COPY ./server /server

EXPOSE 3001

CMD [ "npm", "start" ]
