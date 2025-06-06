# 📊 Prometheus + Grafana Monitoring Stack

Spring Boot 애플리케이션을 모니터링하기 위한 경량 도커 기반 모니터링 시스템입니다.

이 저장소는 Prometheus와 Grafana를 Docker Compose로 간단히 구성할 수 있도록 설계되었으며, .env와 템플릿을 활용한 환경 유연성을 제공합니다.

⸻

##  📦 구성 요소

| 서비스     | 설명                                                   |
|------------|--------------------------------------------------------|
| Prometheus | Spring Boot에서 `/actuator/prometheus` 메트릭 수집       |
| Grafana    | 메트릭 시각화 및 대시보드 구성 도구                       |


---


## 🛠️ 사용 방법

### 1. 프로젝트 클론

```
$ git clone 
$ cd {모니터링 프로젝트 디렉토리}
````

--- 

### 2. .env 파일 설정

```
cp .env.example .env
```

.env 파일을 열고 아래 항목을 수정하세요:

| 항목             | 설명                                                                 |
|------------------|----------------------------------------------------------------------|
| `SPRING_TARGETS` | Prometheus가 모니터링할 Spring 서버들의 도메인 또는 IP 목록 (쉼표 구분) |
| `MY_UID`         | 호스트 시스템의 UID. Grafana 컨테이너 파일 권한 문제를 방지하기 위해 사용 |
| `MY_GID`         | 호스트 시스템의 GID. 위와 동일한 목적이며 함께 설정해야 함              |



✅ UID/GID 확인 방법 (터미널에서):

```
id -u   # 사용자 UID 출력
id -g   # 사용자 GID 출력
```

---

### 3. 실행

chmod +x bootstrap.sh shutdown.sh
./bootstrap.sh

bootstrap.sh는 다음을 수행합니다:
- 	.env를 읽어들임
- prometheus.yml을 템플릿 기반으로 생성
- docker-compose up -d 실행

---

### 4. 종료 및 정리

```
./shutdown.sh
```

shutdown.sh는 다음을 수행합니다:
- Docker 컨테이너 중지 및 삭제
- 자동 생성된 prometheus.yml 삭제

---

### ⚠️ 중요: docker-compose up/down 단독 사용 자제

| 명령어               | 문제점                                      |
|----------------------|---------------------------------------------|
| `docker-compose up -d` | `prometheus.yml`을 갱신하지 않음              |
| `docker-compose down`  | `prometheus.yml`은 그대로 남아있음 (삭제되지 않음) |

🚫 따라서 반드시 bootstrap.sh와 shutdown.sh를 사용해야 최신 구성이 반영되고, 파일 상태가 깨지지 않습니다.

---

### ✅ Grafana 접속 정보

```
	•	URL: http://localhost:3000
	•	초기 로그인: admin / changeme123 (또는 .env에서 설정한 비밀번호)
```

최초 로그인 시 비밀번호 변경이 권장됩니다.

---

📂 디렉토리 구조

```
├── .env.example             # 환경 변수 템플릿
├── bootstrap.sh             # 실행 스크립트 (prometheus.yml 생성 + up)
├── shutdown.sh              # 종료 및 정리 스크립트 (down + yml 삭제)
├── docker-compose.yml       # Grafana / Prometheus 구성
├── prometheus.template.yml  # 템플릿 형태의 Prometheus 설정
├── prometheus.yml           # 자동 생성됨 (gitignore됨)
├── prometheus-data/         # Prometheus 데이터 (볼륨)
└── grafana-data/            # Grafana 설정/DB 데이터
```