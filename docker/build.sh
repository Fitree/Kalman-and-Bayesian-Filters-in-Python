#!/bin/bash

CONTAINER_NAME=kbf-$(id -un)
CONTAINER_UNAME=docker-kbf-$(id -un)
docker build . --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=$CONTAINER_UNAME --rm -t $CONTAINER_NAME -f docker/Dockerfile
