#!/bin/bash
set -e

# 환경변수 로드
source .env

# 1. Nginx conf 파일 템플릿 생성
envsubst '${DOMAIN}' < nginx/conf.d/grafana.conf.template > nginx/conf.d/grafana.conf

# 2. 인증서 발급
docker run --rm \
  -v "$(pwd)/nginx/data:/etc/letsencrypt" \
  -v "$(pwd)/certbot/www:/var/www/certbot" \
  certbot/certbot certonly \
  --webroot \
  --webroot-path=/var/www/certbot \
  --email "$EMAIL" \
  --agree-tos \
  --no-eff-email \
  -d "$DOMAIN"

# 3. Grafana 설정 파일 동기화
echo "Grafana root_url 설정을 다음과 같이 적용하세요:"
echo "[server]"
echo "domain = $DOMAIN"
echo "root_url = https://$DOMAIN"

# 4. docker compose 실행
docker compose up -d