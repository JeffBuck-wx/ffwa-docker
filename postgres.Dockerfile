FROM postgres:14-alpine

ENV POSTGRES_PASSWORD=Whitewater_Brown_Town_1105 \
    POSTGRES_USER=trout

WORKDIR /app

COPY ./postgres/init /docker-entrypoint-initdb.d/
