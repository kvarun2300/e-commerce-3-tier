#!/bin/bash
set -e

AWS_REGION=${AWS_REGION:-us-east-1}
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

aws ecr describe-repositories --repository-names ecommerce-backend --region "$AWS_REGION" >/dev/null 2>&1 || \
  aws ecr create-repository --repository-name ecommerce-backend --region "$AWS_REGION"

aws ecr describe-repositories --repository-names ecommerce-frontend --region "$AWS_REGION" >/dev/null 2>&1 || \
  aws ecr create-repository --repository-name ecommerce-frontend --region "$AWS_REGION"

REGISTRY="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$REGISTRY"

docker build -t "$REGISTRY/ecommerce-backend:latest" ./backend
docker build -t "$REGISTRY/ecommerce-frontend:latest" ./frontend

docker push "$REGISTRY/ecommerce-backend:latest"
docker push "$REGISTRY/ecommerce-frontend:latest"

echo "Images pushed to $REGISTRY"
