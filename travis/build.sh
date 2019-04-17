#!/usr/bin/env bash
# Login into docker
docker login --username $DOCKER_USER --password $DOCKER_PASSWORD

PLATFORM=arm # equivalent to armhf
DOCKERFILE_LOCATION="./Dockerfile.armhf"
DOCKER_USER="sidey79"
DOCKER_IMAGE="rpi-nginx-letsencrypt"
DOCKER_TAG="latest"

buildctl build --frontend dockerfile.v0 \
       --opt platform=linux/${PLATFORM} \
       --opt filename=./${DOCKERFILE_LOCATION} \
       --output type=image \
       --exporter-opt name=docker.io/${DOCKER_USER}/${IMAGE}:${TAG}-${PLATFORM} \
       --exporter-opt push=true \
       --local dockerfile=. \
       --local context=. \
       --opt build-arg:BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"`
