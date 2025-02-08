#!/bin/bash
set -a
source .env
set +a

jq --arg ecsRole "${ECS_ROLE_ARN}" \
  --arg ecsExecutionRole "${ECS_EXECUTION_ROLE_ARN}" \
  --arg imageUri "${ECR_IMAGE_URI}" \
  --arg s3Bucket "${S3_BUCKET}" \
'.taskRoleArn = $ecsRole |
.executionRoleArn = $ecsExecutionRole |
.containerDefinitions[0].image = $imageUri |
.containerDefinitions[0].environment[0].value = $s3Bucket' \
./task-definition.json > ./updated-task-definition.json

aws ecs register-task-definition --cli-input-json file://updated-task-definition.json
rm updated-task-definition.json