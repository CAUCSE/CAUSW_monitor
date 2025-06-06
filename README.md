# 📊 Prometheus + Grafana Monitoring Stack

Spring Boot 애플리케이션을 모니터링하기 위한 경량 도커 기반 모니터링 시스템입니다.

이 저장소는 Prometheus와 Grafana를 Docker Compose로 간단히 구성할 수 있도록 설계되었으며, .env와 템플릿을 활용한 환경 유연성을 제공합니다.

로키 alertmanager 등의 스펙이 추가 될 예정입니다.

---

##  📦 구성 요소

| 서비스     | 설명                                                   |
|------------|--------------------------------------------------------|
| Prometheus | Spring Boot에서 `/actuator/prometheus` 메트릭 수집       |
| Grafana    | 메트릭 시각화 및 대시보드 구성 도구                       |


---


## 🛠️ 사용 방법

### 1. 프로젝트 클론

```
$ git clone https://github.com/CAUCSE/CAUSW_monitor.git
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
| `MY_UID`         | 호스트 시스템의 UID. Grafana 컨테이너 파일 권한 문제를 방지하기 위해 사용 |
| `MY_GID`         | 호스트 시스템의 GID. 위와 동일한 목적이며 함께 설정해야 함              |



✅ UID/GID 확인 방법 (터미널에서):

```
id -u   # 사용자 UID 출력
id -g   # 사용자 GID 출력
```

---

### 3. prometheus.yml 작성

```
cp prometheus.template.yml prometheus.yml
```

이후, prometheus.yml 을 직접 수정하여 초기 설정을 진행합니다.

---

### 4. 실행

```
$ docker compose up -d
```

---

### 4. 종료 및 정리

```
$ docker compose down
```

### 재시작

재시작의 경우 `restart.sh` 실행파일을 실행시켜주어도 됩니다.

```
$ chmod +x restart.sh # restart.sh 파일 실행권한 부여 (권한 있을 시에는 실행하지 않아도 괜찮음)
$ ./restart.sh
```

### ✅ Grafana 접속 정보

```
	•	URL: 13.209.181.162:3000
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