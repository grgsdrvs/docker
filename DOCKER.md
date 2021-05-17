# Docker

## Install

[https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)

## Docker Compose
1. `sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`
2. `sudo chmod +x /usr/local/bin/docker-compose`
3. `docker-compose --version`


## Container

- Portable artifact.
- Container repository
- DockerHub
- Own isolated environment
- Has a port binded to it, e.g. 5000

## Application deployment

- No env config needed on server - only Docker Runtime

## What?

- Layers of images
- Linux Base Image
- Application image on top

- Docker Image (movable) = The actual package - config, start script, postgres
- Docker Container = When I pull the image and start it then it's a container, i.e. when the image is running somewhere.

## Docker vs VM

- Operationg system: Applications 2nd layer - OS Kernel 1st layer - Hardware

- Docker virtualizes the applications layer
- VM virtualizes both the applications layer and OS Kernel layer

Docker images are much smaller than VMs. Speed is also much faster.

Linux based Docker image cannot run on other OS Kernel than Linux. This is fixed the _Docker Desktop_ (Docker Toolbox is deprecated).

## Commands

- `sudo docker images` list available images
- `sudo docker run <image>:<version>` create and starts new container with a command. If no version latest is pulled
- `sudo docker run -d <image>` start container in detached mode
- `sudo docker run -d --name <desired name of container> <image>` start container in detached mode and give it a custom name
- `sudo docker stop <container id>` stop running container
- `sudo docker start <container id>` start stopped container
- `sudo docker ps` list running containers
- `sudo docker ps -a` list running and stopped containers
- `sudo docker logs <container id>` get logs for debugging by id
- `sudo docker logs <container name>` get logs for debugging by name
- `sudo docker logs <container id> -f` steam logs
- `sudo docker logs <container id> | tail` To get last entries in logs only
- `sudo docker exec -it <container id> /bin/bash` enter the terminal of a running container. If not `/bin/bash` works use `/bin/sh`
- `sudo docker rmi <container id>` delete image

- `sudo docker network` list networks 
- `sudo docker network create <name>` create new network

To print environmental variables use bash command `env` in Linux.

Host ports must be different, but can be binded to the same container port. The binding of the ports is made in the `docker run` command. Example for redis container with container port 6379 binded to host port 6000 ==> `docker run -p6000:6379 redis`. This must be done for the application to be reachable.



# Demo

### Docker network

`docker network create mongo-network` 

### Start mongodb
`sudo docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password --name mongodb --net mongo-network mongo`

### Start mongo-express
`sudo docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin -e ME_CONFIG_MONGODB_ADMINPASSWORD=password --net mongo-network --name mongo-express -e ME_CONFIG_MONGODB_SERVER=mongodb mongo-express` 

### Docker Compose

Take all commands and map them into a file, e.g. `mongo-docker-compose.yaml`. Docker compose will create a common network as well.

Run this command to run or stop containers. Use flag `-d` for detached mode.
- `sudo docker-compose -f docker-compose.yaml up`
- `sudo docker-compose -f docker-compose.yaml down`


## Docker Volumes
For data persistance

## Dockerfile
Build docker image. What does _Jenkings_(CI) do after commit to Git? Jenkins package the application in a _Docker Image_ and the pushes into a _Docker Repository_.

The Dockerfile is a blueprint for building the Docker image. This is was the Jenkins server uses.

- `sudo docker build -t docker-tutorial:1.0 .`