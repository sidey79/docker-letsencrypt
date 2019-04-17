#!/usr/bin/env bash
set -e
# Login into docker
docker login --username $DOCKER_USER --password $DOCKER_PASSWORD

PLATFORM=arm # equivalent to armhf
DOCKERFILE_LOCATION="./Dockerfile.armhf"
DOCKER_USER="Sidey79"
DOCKER_IMAGE="rpi-nginx-letsencrypt"
DOCKER_TAG="latest"

buildctl build --frontend dockerfile.v0 \
        --frontend-opt platform=linux/${PLATFORM} \
        --frontend-opt filename=./${DOCKERFILE_LOCATION} \
        --exporter image \
        --exporter-opt name=docker.io/${DOCKER_USER}/${IMAGE}:${TAG}-${PLATFORM} \
        --exporter-opt push=true \
        --local dockerfile=. \
        --local context=.


wait

export DOCKER_CLI_EXPERIMENTAL=enabled

docker manifest create ${DOCKER_USER}/${IMAGE}:${TAG}
docker manifest push ${DOCKER_USER}/${IMAGE}:${TAG}