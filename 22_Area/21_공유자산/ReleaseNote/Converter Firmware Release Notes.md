### 펌웨어 출시 이력(Release history)

##### V2.0.5 (2024-09-16)
- 기능 개선 및 추가 사항:
    1. DB300WB 정보 읽기 오류 수정
        - **오류 조건:** IPTime 공유기 사용 시, `Unicast` 방식으로 DB300 정보를 읽어오려 할 때 간헐적으로 통신 실패 발생
        - **해결 방법:** `DB300 Info` 탭의 `Read` 패킷 방식이 고정된 `Unicast`에서 벗어나, `COMM > UDP` 설정의 Response Type에 따라 자동으로 적용되도록 변경
##### V2.0.4 2023-12-22
- 버그수정
	1. 부트로더를 최초에 구웠을때 맥어드레스가 잘못 표시되면서 랜통신이 먹통되는 문제 해결
##### V2.0.3 2023-10-14
- 버그수정
	1. Erase 전송후에 "Dev Connect Port"가 변경되지 않는 버그 수정
		- Default Ethernet모드: TTL
		- Default Wifi 모드: RS232
##### V2.0.2 2023-10-12
- 기능 개선 및 추가 사항
	1. Ethernet 모드일 때 디폴트 "Dev Connect Port"를 기존과 같이 TTL로 고정
	2. Wifi 모드일 때 디폴트 "Dev Connect Port"를 TTL에서 RS232로 변경
##### V2.0.1 2023-10-06
- 기능 개선 및 추가 사항
	1. BLE Stop 패킷 추가: Wifi로 File Upload(Ota) 할 때 BLE를 Stop하여 충돌로 인한 파일 업로드 실패를 방지
		- Transmit packet : 
			- "++SET++![0042!]""
		- Response packet :	
			- ![00420!] - Success
			- ![0042F!] - Fail
##### V2.0.0 2023-10-04
- 기능 개선 및 추가 사항
	1. 맥어드레스 적용방법 변경
		- ethernet, wifi 동시모드 일때 
			- ethernet mac: Dabit mac 적용
			- wifi mac: esp32 mac 적용
		- ethernet, wifi 단독모드 일때 
			- ethernet mac: Dabit mac 적용
			- wifi mac: Dabit mac 적용
##### V4.60 2023-05-26
- 기능 개선 및 추가 사항
	1. 컨트롤러가 TCP Server 일때의 통신문제
		- TCP 접속된 Client가 리셋(PC 다운)되면 연결이 끊어진 상태를 인지하지 못함
		- 해결 방안: 동일한 IP와 Port로 다른 Client가 TCP 접속을 시도하면 컨트롤러가 자동으로 리셋되도록 수정
	1. 컨트롤러가 TCP Client 일때의 통신문제
		- Server의 PC가 다운되거나 네트워크 장비가 리셋될 때 TCP 연결 실패를 인식 못함
		- 해결 방안: UDP Broadcast로 모든 컨트롤러를 리셋하는 명령 추가: `RESET DIBD-ALL`
##### V4.60 2023-05-22
- 기능 개선 및 추가 사항
	1. DB300의 CPU Reset명령 추가
	    - Transmit packet:
	        - `++SET++![00410!]`
	    - Response packet:
	        - `![00410!]`
---
  - 베어로보틱스 초기 제품 출시
---
##### V4.58 2023-03-07
- 기능 개선 및 추가 사항
	1. 무선랜의 UDP 포트를 5109에서 5107로 변경
		- `#define UDP_ETH_LOCAL_PORT 5108`
		- `#define UDP_WIFI_LOCAL_PORT 5107`
	2. AP모드에서도 STA모드와 동일하게 모든 Dabit Protocol 통신 가능하도록 수정
		- DB300 초기 펌웨어 모드 : AP모드
	1. 초기 펌웨어의 SSID와 비밀번호 변경
		- SSID:"dabitnet"
		- PW: "dabitnet"
- 주의사항
    DB300_ETH_WIFI 모드에서 유선랜 선이 연결되어 있지않으면 Wifi OTA가 접속되지 않음
##### V4.55 2023-03-24
- 기능 개선 및 추가 사항
	- DabitNet의 검색 버튼의 응답 초기값을 Unicast에서 BroadCast로 변경
##### V4.53 2023-02-23
- 기능 개선 및 추가 사항
	1. 하드웨어 리셋하면 Ethernet IP를 초기값으로 복구하는 기능 추가
	2. 파일(.csv) 구조 변경
- 버그수정
	- OTA 전송 에러 수정
		- WDT Timeout을 5s에서 15s로 변경