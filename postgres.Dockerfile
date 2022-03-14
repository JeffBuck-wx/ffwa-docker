FROM postgres:14-alpine
ENV POSTGRES_PASSWORD=Diana1
COPY ./postgres/*.* /docker-entrypoint-initdb.d 
