#!/bin/bash

set -e

echo "[+] Stopping and removing containers"
docker-compose down

echo "[+] Removing prometheus.yml"
rm -f prometheus.yml