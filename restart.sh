#!/bin/bash

# 컨테이너와 네트워크 정리 (이미지, 볼륨은 유지)
echo "Stopping and removing containers and networks..."
docker compose down --remove-orphans

# 컨테이너 재시작
echo "Starting containers in detached mode..."
docker compose up -d