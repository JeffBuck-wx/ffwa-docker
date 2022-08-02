# fly-fishing-web-app docker

# How to start the application resources
#  all commands assumed to be run from application repo root dir
ffwa-network - Docker network
1. create network - if it doesn't exist
   docker network ls
   docker network create -d bridge ffwa-network


postgres - postgresql database
1. build image
   docker image build -t ffwa-db -f postgres.Dockerfile .
2. run container
   docker container run --name ffwa-db -d -p 5432:5432 --network ffwa-network ffwa-db 


server - nodejs backend
1. build image
2. run container
