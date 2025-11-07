#### 원인 분석
- **베어로보틱스 기본 통신 설정**
	- Name=DB300E
	- Local IP=10.10.127.10
	- Port=5000
	- SubnetMask=255.255.255.0
	- Gateway=10.10.127.1
	- ServerIP=10.10.127.1
	- ServerPort=5000
- **Local IP 값 오류:** 192.168.0.202로 입력되어 DB300E 인식 불가 또는 DB502 연결 불가

#### 해결 방안
- PC와 DB300E를 이더넷 케이블을 이용해 1대1로 연결
- 수동으로 IP 입력
	1.  DABIT Protocol Simulator 실행
	2. 설정 및 제어 > 통신 설정 > DABITNet 
		1. 기본 통신 설정 값 수동 입력
		2. `Set`
		3. `Exit`
		- ![[as_베어로보틱스_ip_1.png|300]]