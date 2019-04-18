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
       --local dockerfile=. \
       --local context=. \
       --opt build-arg:BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
       --output type=local,dest=./ \
       --opt filename=./${DOCKERFILE_LOCATION} \
       --output type=image,name=${DOCKER_USER}/${IMAGE}:${TAG}-${PLATFORM},push=true \
	  

docker pull ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}-${PLATFORM}
docker tag ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}-${PLATFORM} ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}-${PLATFORM}
docker push ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}-${PLATFORM}
