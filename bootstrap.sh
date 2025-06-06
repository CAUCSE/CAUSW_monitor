#!/bin/bash

set -e
source .env

PROM_FILE=prometheus.yml
[ -f $PROM_FILE ] && rm -f $PROM_FILE

# 6칸 들여쓰기 + 2칸 더해서 8칸으로
SPRING_TARGET_YAML=$(echo "$SPRING_TARGETS" | tr ',' '\n' | sed 's/^/        - /')

cat > $PROM_FILE <<EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'spring'
    metrics_path: '/actuator/prometheus'
    scheme: https
    tls_config:
      insecure_skip_verify: true
    static_configs:
      - targets:
$SPRING_TARGET_YAML
EOF

echo "[+] Generated prometheus.yml:"
cat prometheus.yml

docker-compose up -d