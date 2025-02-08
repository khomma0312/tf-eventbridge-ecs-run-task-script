#!/bin/bash
set -a
source .env
set +a

docker build -t ecs-scheduler-example-repository --no-cache --platform linux/amd64 .

docker tag ecs-scheduler-example-repository:latest $ECR_IMAGE_URI

docker push $ECR_IMAGE_URI