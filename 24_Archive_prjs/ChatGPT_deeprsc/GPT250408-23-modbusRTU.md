좋습니다. Modbus RTU 기반 DABIT 프로토콜 문서를 기반으로, 내부 직원 교육용 사용자 매뉴얼 스타일의 문서로 구성하여 컨트롤러 연결, 환경설정, 메시지 전송, 색상 및 효과 설정 등 실무에 필요한 내용을 중심으로 정리해드리겠습니다. 잠시만 기다려 주세요. 분석을 시작하겠습니다.

# DABIT 전광판 컨트롤러 사용자 매뉴얼 (Modbus RTU 기반)

## 1. 시스템 개요 및 연결 구성

DABIT 전광판 컨트롤러는 전광판(LED 디스플레이)을 제어하기 위한 장치로, **Modbu ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=match%20at%20l1100%20,d9%20bb%20e7%20be%20c6-lo26cl7393e/))*을 통해 외부 장치(PLC, PC 등)와 통신합니다. 컨트롤러는 Modbus **슬레이브(slave)** 장치로 동작하며, 상위 장치(Master)가 명령을 보내면 전광판에 해당 내용을 표시합니다.

- **통신 포트 및 방식:** 컨트롤러는 **RS-232** 및 **RS-485** 직렬 통신을 지원합니다. RS-232는 1:1로 컨트롤러를 PC 등에 직접 연결할 때 사용하며, 짧은 거리에서 안정적입니다. RS-485는 최대 1200m 거리에서 다중 접속을 허용하는 **2선식 차동 통신** 방식으로, 여러 대의 전광판 컨트롤러를 한 버스에 연결할 수 있습니다.
    
- **슬레이브 주소:** 전광판 컨트롤러의 Modbus 기본 슬레이브 주소는 **0**번이며, RS-485 방식으로 다중 연결 시 **1~15번** 사이로 설정하여 사용합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=1%20%20%20%20,\)rs485-9z14sgo5kkbtbtcgiktpvrbq2a2t3g0q3bpddd66ar3f2l5k2pixt6e6kf/)). (RS-232로 1대 연결 시에는 주소 0을 주로 사용). **참고:** 주소 설정은 컨트롤러의 DIP 스위치나 환경설정으로 변경할 수 있으며, 각 장치는 고유한 슬레이브 ID를 가져야 합니다.
    
- **통신 속도 및 설정:** (공장 초기 설정 기준) Modbus RTU 프레임 형식은 **8데이터 비트, 패리티 없음, 1스톱 비트(8N1)**를 사용하며, 통신 속도는 **9600 bps** 등으로 설정됩니다. 이 설정은 환경에 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=1%20%20%20%20,\)rs485-9z14sgo5kkbtbtcgiktpvrbq2a2t3g0q3bpddd66ar3f2l5k2pixt6e6kf/))므로, 상위 장치와 동일하게 맞추어야 합니다.
    
- **배선:** RS-232 연결 시 컨트롤러의 TX, RX, GND 핀을 PC의 시리얼 포트와 연결합니다. RS-485 연결 시 컨트롤러의 A(+), B(-) 단자를 상위 장치의 A, B 라인에 병렬로 연결하고, 버스의 양 끝에 **종단 저항**을 넣어 신호 품질을 유지합니다.
    

전광판 컨트롤러와 상위 장치 간 연결이 완료되면 Modbus 명령을 통해 전광판 제어를 시작할 수 있습니다. 아래에서는 Modbus RTU ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%20%20%20%20-4g94qd3chzbu10h5b3byc5aiqkyh6df7lrllxt5fdwzihcoarrs/))맵 구조에 대해 설명합니다.

## 2. Modbus RTU 프로토 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/))odbus RTU는 산업 현장에서 널리 사용되는 **마스터-슬레이브** 통신 프로토콜입니다. Master 장치는 쿼리(질의) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2001%2000,05%2000%2006%2000%2007-lo28zpz94bzxpm/))는 응답하는 방식으로 통신이 이루어집니다. **프레임 구조**는 [장치 주소][기능 코드][데이터][CRC]로 구성되며, DABIT 컨트롤러와의 통신에 적용됩니다.

- **16비트 레지스터:** DABIT 컨트롤러는 제어 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,,%20%20%20%20-pt31qga7956g2jbl00ala6840e7ba157h454e31zboa041gea1289fujekq2m/))지스터** 단위로 관리합니다. **1개의 레지스터 = 2 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%2F%20%20%20%2020,%20%20%2080%20-zb38bma9e37187mna488boa911v09cdr9d4k7anrdowc509a5o4g7e7bz7pwf4toas873mta19wvas449xrx7z5nbe41eva/))광판의 설정 및 표시 메시지가 이 레지스터들로 매핑되어 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=%EF%82%9E%20%EC%B6%9C%EB%A0%A5%20%EB%8D%B0%EC%9D%B4%ED%84%B0%20%EA%B0%92%EC%9D%84%20%EC%9D%BD%EB%8A%94,rtu%20frame%EC%9D%84%20%EC%82%AC%EC%9A%A9%ED%95%A9%EB%8B%88%EB%8B%A4/)). 상위 장치는 필요한 레지스터 주소에 접근하여 값을 읽거나 씁니다.
    
- **기능 코드 0x10 (16)** – **다중 레지스터 쓰기**: 상위 장치가 여러 개의 16비트 값을 한꺼번에 컨트롤러로 전송할 때 사용합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=%EF%82%9E%20%EB%8B%A4%EC%88%98%EC%9D%98%2016%EB%B9%84%ED%8A%B8%20%ED%81%AC%EA%B8%B0%EC%9D%98%20%EC%B6%9C%EB%A0%A5,rtu%20frame%20%EC%9D%84/)). 예를 들어 전광판에 표시할 한 화면의 모든 속성 및 문자열 데이터를 한 번의 명령으로 보낼 때 사용합니다. DABIT 컨트롤러는 주로 표시 데이터 수신에 이 기능 코드를 사용합니다.
    
- **기능 코드 0x03 (03)** – **홀 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%20-2s46b6y406bkrfa470iia9268gja722nka622kka6788g8pa51vi7ggrbma807u8z3fna77sfwpoa2821qpa7748dqkrqa/))위 장치가 컨트롤러의 저장된 값을 읽어올 때 사용합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=%EF%82%9E%20%EC%B6%9C%EB%A0%A5%20%EB%8D%B0%EC%9D%B4%ED%84%B0%20%EA%B0%92%EC%9D%84%20%EC%9D%BD%EB%8A%94,rtu%20frame%EC%9D%84%20%EC%82%AC%EC%9A%A9%ED%95%A9%EB%8B%88%EB%8B%A4/)). 현재 설정이나 상태를 확인하기 위해 레지스터 값을 조회하는 경우 활용합니다. (예: 현재 저장된 환경설정 값이나 시간 정보 읽기 등)
    
- **레지스터 주소 체계:** Modbus 프로토콜에서는 내부 **데이터 주소**와 **레지스터 번호**가 혼용될 수 있습니다. 일반적으로 레지스터 번호는 1부터 시작하지만 실제 프레임의 데이터 주소는 0부터 시작합니다. 예를 들어 컨트롤러의 “레지스터 1”은 Modbus 명령에서는 주소 **0x0000**으로 지정됩니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=match%20at%20l740%20register%20,xxxx\),%20-bi190a3w7hvz4bu5b6294bxg1a87bfa0450sezsb/)). 본 매뉴얼에서는 편의상 컨트롤러 메모리 맵의 **데이터 주소(HEX)**를 기준으로 설명합니다.
    

이제 DABIT 컨 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,0033%200020%200041%200042%200043-rz98b07629d/))맵 구조**와 각 기능의 설정 방법에 대해 살 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,0033%200020%200041%200042%200043-rz98b07629d/)) 3. 환경설정 메모리 맵 구조 *_환경설정_ ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,0033%200020%200041%200042%200043-rz98b07629d/))동작 기본값과 메모리 맵의 구성을 정의하며, ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,0033%200020%200041%200042%200043-rz98b07629d/))**로 이루어져 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20:%20%20,%20%20%20-iv59bn9378bnfa7184bi2cv7byzcua1242kjhnwa9811ik0bp8cq6y0a283mcal64d903qnt0axddwza7a3189bzm4d9az377lizsa/)). ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,0033%200020%200041%200042%200043-rz98b07629d/))롤러의 **플래시 ROM**에 저장되어 전원 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,0033%200020%200041%200042%200043-rz98b07629d/))다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=a/)). 각 항목과 역할은 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,0033%200020%200041%200042%200043-rz98b07629d/))

위 환경설정 값들은 전광판 제어를 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=b/)) 한 번 설정**되며, 이후에는 특별히 바꿀 일이 없는 한 그대로 사용합니다. 예를 들어, 새로운 전광판을 설치한 후 해당 전광판의 모듈 배열(높이/ ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%20-2s46b6y406bkrfa470iia9268gja722nka622kka6788g8pa51vi7ggrbma807u8z3fna77sfwpoa2821qpa7748dqkrqa/))를 설정하고 저장하면, 컨트롤러가 재가동되더라도 설정이 유지되어 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,rom%20,%20%20%20-nh24ch3759b20ja891ivwbc63anwfha01kh47obrmviz051b85qz3df78iqycdwz3qpgm2d68bjw1bo5ie8br0d71gnykdlai7cx4shk63au20a/)).

**※ 참고:** 맵 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=%EF%82%9E%20%ED%95%98%EB%82%98%EC%9D%98%20%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%9D%84%203%EA%B0%9C%EC%9D%98%20%EC%84%B9%EC%85%98%EC%9C%BC%EB%A1%9C,%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%A5%BC%20%EB%8F%99%EC%8B%9C%EC%97%90%20%ED%91%9C%EC%8B%9C%ED%95%A0%20%EC%88%98%20%EC%9E%88%EC%8A%B5%EB%8B%88%EB%8B%A4/))0으로 설정하여 사용하는 것을 권장하며, 하나의 상위 장치에 여러 전광판 컨트롤러를 연결하는 특별한 경우에만 조정합니다. 또한 최대 문자수를 조정한 경우 그에 맞춰 아래에서 설명할 **문자 색상/문자열 레지스터의 주소 범위**가 바뀌므로, 변경 후에는 새로운 메모리 맵에 따라 통신해야 합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,16,%2032byte\)-rp46qik5nbw4fqjb/)).

환경설정이 완료되면, 다음으로 현재 시간 설정 및 메시지 표시 데이터 전송을 다룹니다. ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20,3-m582pzm9dlu7eg41a0fgg90dvobc99ik7xaiq6a8m9l6nam20c.xn--ivg8125do1bn8c73w/))정 (RTC 동기화) – BCD 코드 사용 DABIT 컨트롤러에는 **실시간 시계 (RTC)** 기 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%2F%20%20%20-sp43cs0788bgu2cl0tdurgz85ayk3c2hal87selbh3sdncf04c0j8c3sj7rdk2qbta4a12o2yjup0awe9bwp5o1uaha487t/))지합니다. 이 현재 시간은 전광판에서 날짜/시간을 표시하는 용도로 사용되며, 배터리 백업이 있는 모델의 경우 전원 오프 후에도 **최대 5일간** 시간을 유지합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=b/)). 현재 시간을 설정하거나 읽어오기 위해 **7개 레지스터**가 할당되어 있습니다:

- **년 (Year)** – 2자리 연도 (예: 2025년이면 "25"). ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%20%20%20%20-4g94qd3chzbu10h5b3byc5aiqkyh6df7lrllxt5fdwzihcoarrs/))h)** – 월(01~12).
    
- **일 (Day)** – 일(01~31).
    
- **요일 (Weekday)** – 요일 (1=월요일 ~ 7=일요일).
    
- **시 (Hour)** – 시(00~23).
    
- **분 (Minute)** – 분(00~59).
    
- **초 (Second)** – 초(00~59).
    

각 항목은 **BCD 코드**로 표현됩니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20bcd,read%2Fwrite%20-d075c68590cim8bf66ahybr34evu9ccs3cb49fcr4c1bh101crz1g3r3efvk/)) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=00%2000h%20%20%20,%20,%20%20%20-u322wkj1a6g2goxbi36bol4fr6kgzpulqvv7hxz8aqae7636gu0fm7tp4yw44sya650vrnm1tq/))inary Coded Decimal)는 1바이트를 상위 4비트와 하위 4비트로 나누어 각각 0~9의 값을 나타내는 방식입니다. 예를 들어 **현재 시간이 2025년 04월 10일 (목) 08:15:00**이라면, 각 레지스터에 다음과 같이 BCD 값으로 입력합니다:

- 년도: 0x25 (BCD로 '25' → 2 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=f/))월: 0x04 (BCD '04' → 4월)
    
- 일: 0x10 (BCD '10' → 10일)
    
- 요일: 0x04 (목요일이 4번째 요일이라고 가정)
    
- 시: 0x08 (8시)
    
- 분: 0x15 (15분)
    
- 초: 0x00 (00초)
    

컨트롤러에 데이터를 전송할 때도 위와 같이 BCD 코드로 값을 보내면 됩니다. **예시:** 샘플 값이 `Year=0x14, Month=0x12, Day=0x31, Weekday=0x03, Hour=0x01, Minute=0x10, Second=0x00`인 경우 이는 **“2014-12-31 (수) 01:10:00”**을 나타냅니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%20,%20%200000h%20-9f79a3b80745k5rialnxhf0ehqbk94woxrfev6bfig4scnwbuz6h1a6142dxu5h/)). (여기서 0x14는 BCD 코드 "14"로 연도 2014년의 끝자리, 요일 0x03은 수요일을 의미합니다.)

상위 장치(PLC/PC)는 기능코드 0x10 명령으로 이 7개 레지스터를 한꺼번에 써서 컨트롤러의 시간을 원하는 현재 시각으로 동기화할 수 있습니다. 시간을 설정한 후에는 컨트롤러 내부 시계가 계속 흐르며, 필요시 주기적으로 동기화를 해주면 됩니다. 시간 레지스터는 기능코드 0x03으로 읽어서 확인할 수도 있습니다.

**참고:** 설정된 현재 시간은 전광판에 표시하는 기능과 연계하여 활용됩니다. (예: 전광판 화면에 현재 시간/날짜를 자동 갱신 표시하는 기능 – 해당 기능은 별도 가이드 참고 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20bcd,read%2Fwrite%20-d075c68590cim8bf66ahybr34evu9ccs3cb49fcr4c1bh101crz1g3r3efvk/))). 기본 매뉴얼 범위에서는 시간 값을 설정하고 유지하는 부분까지만 다룹니다.

## 5. 메시지 표시 섹션별 메모리 구조 및 데이터 전송

DABIT 전광판 컨트롤러는 화면 표시 영역을 **최대 3개의 섹션(section)**으로 나누어 각기 다른 내용을 동시에 표시할 수 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%20%20%20-l270ux0bi5yqa35l511f3v8cga968aoqclx4aeltsshuj1gsa4172ds6dqv0nszsdxa13ufvufq9a772pocoa3uuva52eg1aq69c/)). 섹션을 사용하면 하나의 화면을 분할하여 별개의 메시지를 독립적인 효과로 보여줄 수 있으며, **섹션0**은 기본 전체 화면, **섹션1**과 **섹션2**는 선택적으로 사용하는 추가 영역입니다.

- **섹션 분할 개념:** 섹션을 나누지 않을 경우(기본화면 하나만 사용할 경우) 모든 표시 데이터는 섹션0에 해당합니다. 이때 나머지 섹션1, 섹션2는 사용하지 않으므로 **표시제어 값을 “0 (표시 안 함)”**으로 유지하여 비활성화합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,16]%20-w747shvbx9a1293b89yboa38qpa317wyp1ezdbiy8b8n6dl34hhtary/)). 반대로 화면을 둘 이상으로 분할하려면 각 섹션의 크기와 위치를 정의하는 좌표를 설정하고, 해당 섹션마다 별도의 메시지 데이터를 보내야 합니다.
    
- **메모리 맵 구조:** 각 섹션에는 **표시 속성**과 **문자 데이터** 영역이 순서대로 메모리 맵에 배정되어 있습니다. **표시 속성**(섹션별 16개 레지스터) 다음에 해당 섹션의 **문자 색상** 리스트(0~~최대문자수 개 레지스터)와 **문자열** 리스트(0~~최대문자수 개 레지스터)가 위치합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%20%20%2016-x994b6b72133mzp7enu7apy6aha2918fzqa58ej9fj02a81dia0592ge4bd78fsan968b0s7ekg4eii0bfiomp3b/)). 이를 섹션별로 나열하면 아래와 같습니다:
    
    - **섹션0:** 표시속성(16) → 문자색상(최대 N) → 문자열(최대 N)
        
    - **섹션1:** 표시속성(16) → 문자색상(최대 N) → 문자열(최대 N)
        
    - **섹션2:** 표시속성(16) → 문자색상(최대 N) → 문자열(최대 N)  
        _(N은 환경설정의 "최대 문자수"에 따라 정해지는 최대 글자 개수입니다.)_
        
- **메시지 데이터 전송 방식:** 전광판에 새로운 메시지를 표시하려면 보통 아래의 **2단계 전송**을 수행합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%20-2s46b6y406bkrfa470iia9268gja722nka622kka6788g8pa51vi7ggrbma807u8z3fna77sfwpoa2821qpa7748dqkrqa/)):
    
    1. **표시속성 및 문자색상 전송:** 우선 해당 섹션의 표시속성 16개 레지스터와 (필요시) 문자색상 레지스터들을 상위 장치에서 컨트롤러로 전송합니다. 표시속성에는 글자색을 제외한 표시 방법, 효과 등이 모두 포함되므로, 이 정보가 컨트롤러 **RAM에 저장**됩니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%20-2s46b6y406bkrfa470iia9268gja722nka622kka6788g8pa51vi7ggrbma807u8z3fna77sfwpoa2821qpa7748dqkrqa/)). 문자색상도 RAM에 기록됩니다. (표시속성과 색상은 화면에 즉시 변화를 주진 않고 설정으로 저장됨)
        
    2. **문자열 전송:** 이어서 문자열 데이터를 해당 섹션의 문자열 시작 레지스터부터 순서대로 전송합니다. 컨트롤러는 이 **문자 데이터가 도착하는 순간** 앞서 받은 표시속성 및 색상 설정에 따라 전광판 화면에 문구를 표시합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%20-2s46b6y406bkrfa470iia9268gja722nka622kka6788g8pa51vi7ggrbma807u8z3fna77sfwpoa2821qpa7748dqkrqa/)). 문자열 전송이 완료되면 새로운 메시지가 전광판에 나타납니다.
        

이처럼 속성과 문자열을 **구분하여 전송**하는 이유는, 자주 변하지 않는 표시 설정(예: 폰트나 효과 등)은 한 번만 보내 두고, 자주 바뀌는 **문자열만 갱신**하여 통신 부하를 줄일 수 있기 때문입니다. 만약 표시 속성이 이전 메시지와 완전히 동일하다면, 문자열만 새로 보내서 화면을 업데이트할 수도 있습니다.

- **섹션별 시작 주소:** 각 섹션의 메모리 맵은 연속적으로 배치되어 있으며, **환경설정 A**~~**현재시간 B**~~**저장문구 호출 C** 영역 다음에 **섹션0,1,2의 영역**(D,E,F)이 순서대로 위치합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20-wb34p3xtcv6kknxeikg4pi7md011eeiunot0vk3i0j/)) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%20%20%2016-x994b6b72133mzp7enu7apy6aha2918fzqa58ej9fj02a81dia0592ge4bd78fsan968b0s7ekg4eii0bfiomp3b/)). 환경설정에서 **맵 시작주소**를 변경하면 전체가 해당 절대주소로 이동하지만, **상대적인 순서는 변하지 않습니다**. 예를 들어 맵 시작주소가 기본값 0x0000인 경우, 섹션0 표시속성의 시작 주소는 **0x0020**이며 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)), 섹션1 표시속성은 그 이후 0x0080, 섹션2 표시속성은 0x00E0가 됩니다 (각 섹션당 할당 크기에 따라 0x60 (96) 간격으로 떨어짐). 맵 시작주소를 0x0001 (1000번지)로 변경하면 이들 주소도 1000씩 증가하게 됩니다.
    
- **저장 문구/그래픽 호출:** 한편, 실시간 메시지를 보내는 것 외에도 컨트롤러에는 **미리 저장된 문구나 이미지를 호출**하여 표시하는 기능이 있습니다. 환경설정 다음에 있는 **“저장 문구/그래픽 파일 번호”** 레지스터(1개)를 통해 **파일 번호 (#0~#255)**를 지정하면, 컨트롤러에 사전 저장된 해당 번호의 콘텐츠를 불러와서 전광판에 표시할 수 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20-yp91m8p2gh9a3498bwfubgmas76guo0l/)). 예를 들어 이 레지스터에 0x0005 값을 쓰면, 미리 저장된 5번 파일의 내용이 즉시 화면에 표시됩니다. **0x0000**으로 쓰면 호출 안 함을 의미합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%20,%20%20%20-uz31qxwgbpekw8xetta02c224mfaf30c503umqb5yti32aia4b5327mbooa/)). 이 기능은 이벤트 발생 시 저장된 애니메이션 또는 고정 문구를 빠르게 보여주고자 할 때 유용하며, 다양한 형식의 텍스트/그래픽/애니메이션 파일을 PC용 **다빛채 소프트웨어**로 작성/업로드하여 저장해 둘 수 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20-ng27p4w3dohbu91pk55fkghkjcf46jwfxj0zma0na/)). (자세한 사용법은 별도의 옵션 매뉴얼 [6]에 설명)
    

정리하면, **실시간 제어 방식**에서는 섹션별 표시속성과 문자 데이터를 Modbus 통신으로 직접 보내어 즉시 화면에 반영하고, **저장 호출 방식**도 가능하다는 것입니다. 다음 장에서는 각 **표시속성 항목별 의미와 설정 방법**을 상세히 설명합니다.

## 6. 표시 속성, 문자 색상, 표시 효과 등의 설정 방법

각 **섹션의 표시속성 (16개 레지스터)**은 전광판에 메시지를 어떻게 표시할지를 결정합니다. 이 속성 값들을 적절히 설정하여 표시 형태를 제어할 수 있습니다. 또한 속성 이후의 **문자 색상 코드**와 **문자 코드 (문자열)** 설정을 통해 글자별 색상과 내용을 지정합니다. 아래는 주요 속성 항목과 설정 방법입니다:

1. **페이지 번호 (Page Number)** – **페이지 메모리** 기능을 위한 번호로, 기본값 0을 사용합니다. 컨트롤러는 최대 10개의 페이지를 내부 메모리에 저장해 순차 표시할 수 있으나, 이 기능은 특별한 경우에만 사용하며 일반적인 실시간 표시에서는 **항상 0으로 유지**합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%2010\)%20-cl17o3t4hrexcl74f3hwbs2ot4j1u4dhlopi3i/)). (페이지 기능 필요 시 별도 가이드 제공 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%2010\)%20-cl17o3t4hrexcl74f3hwbs2ot4j1u4dhlopi3i/)))
    
2. **섹션 번호 (Section ID)** – 해당 속성 세트가 어느 섹션인지를 나타냅니다. 섹션0은 0x0000, 섹션1은 0x0001, 섹션2는 0x0002로 설정합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%20%20%20-l270ux0bi5yqa35l511f3v8cga968aoqclx4aeltsshuj1gsa4172ds6dqv0nszsdxa13ufvufq9a772pocoa3uuva52eg1aq69c/)). 보통 섹션별 메모리 구역 자체가 고정되어 있으므로 이 값은 컨트롤러에서 자동 참조되며, 사용자 측에서는 **각 섹션에 맞는 값(0,1,2)**을 넣어 일치시키면 됩니다.
    
3. **표시제어 (Display Control)** – **해당 섹션의 표시 여부 및 반복 횟수**를 결정합니다. 이 값에 따라 문구를 몇 회 보여줄지 또는 계속 표시할지 설정합니다.
    
    - `0x0000` – 표시 안 함 (OFF) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20,3-m582pzm9dlu7eg41a0fgg90dvobc99ik7xaiq6a8m9l6nam20c.xn--ivg8125do1bn8c73w/))
        
    - `0x0001` – 1회 표시
        
    - `0x0002` – 2회 표시
        
    - ...
        
    - `0x0062` – 98회 표시
        
    - `0x0063` – **항상 표시** (무한 반복) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%20%20%20%20-4g94qd3chzbu10h5b3byc5aiqkyh6df7lrllxt5fdwzihcoarrs/))
        
    
    예를 들어 **계속 표시**하려면 99(decimal)인 `0x0063`으로 설정합니다. 기본화면(섹션0)은 주로 항상 표시로 두고, 섹션1/2는 사용 시에만 값을 바꿔 활성화합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20,3-m582pzm9dlu7eg41a0fgg90dvobc99ik7xaiq6a8m9l6nam20c.xn--ivg8125do1bn8c73w/)). (`0x0063`은 "항상 또는 다음 메시지 패킷 수신 시까지 표시"를 뜻합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2000%2000,00%2062%2000%2063-0e30y9122burwl/)).)
    
4. **표시방법 (Display Mode)** – 새로운 메시지를 현재 화면에 적용하는 방식을 지정합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)).
    
    - `0x0000` – 현재 표시 중인 문구가 **모두 끝난 후**에 새 메시지를 표시 (기존 메시지 완료 후 교체) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)).
        
    - `0x0001` – 현재 표시 중인 문구를 **즉시 중단하고** 새 메시지를 표시 (즉시 갱신) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)).
        
    
    일반적으로 실시간 제어에서는 **0x0001 (즉시 표시)**로 설정하여 새로운 명령이 오면 이전 표시를 바로 갱신하는 방식을 사용합니다. (초기값은 0x0001)
    
5. **문자코드 (Character Code Type)** – 문자열 데이터를 어떤 문자 인코딩으로 해석할지 결정합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)).
    
    - `0x0000` – **일반 모드**: ASCII 문자(영문, 숫자, 기호), KSC5601 완성형 한글 및 사용자 정의 폰트 등을 사용. 기본값입니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)).
        
    - `0x0001` – **유니코드 모드**: 2바이트 유니코드로 문자를 표현 (중국어, 일본어, 아랍어 등 국제 문자 지원) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)).
        
    
    일반적인 한글/영문 표시의 경우 0x0000으로 설정합니다. 유니코드 모드는 특수한 경우 사용하며, 필요 시 공급사로부터 추가 안내를 받을 수 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=00%2000h%20%EF%82%9E%20%EC%9D%BC%EB%B0%98%20ascii,%EC%98%81%EB%AC%B8,%20%EC%88%AB%EC%9E%90%2F%EA%B8%B0%ED%98%B8\),%20%ED%95%9C%EA%B8%80%EC%99%84%EC%84%B1%ED%98%95,%20%EC%82%AC%EC%9A%A9%EC%9E%90%ED%8F%B0%ED%8A%B8/)).
    
6. **폰트크기 (Font Size)** – 표시할 글자의 크기를 지정합니다. 폰트 크기는 전광판 모듈의 픽셀 기준 높이를 뜻하며 **12~32픽셀** 범위로 설정할 수 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)). 이 값을 레지스터로 입력할 때 특정 코드로 매핑됩니다:
    
    - `0x0001` – 12 픽셀 (ASCII 6×12, 한글 12×12 크기) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2001%2000,05%2000%2006%2000%2007-lo28zpz94bzxpm/))
        
    - `0x0003` – 16 픽셀 (ASCII 8×16, 한글 16×16) **기본값** ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2001%2000,05%2000%2006%2000%2007-lo28zpz94bzxpm/))
        
    - `0x0004` – 20 픽셀 (ASCII 10×20, 한글 20×20) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2001%2000,05%2000%2006%2000%2007-lo28zpz94bzxpm/))
        
    - `0x0005` – 24 픽셀 (ASCII 12×24, 한글 24×24) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2001%2000,05%2000%2006%2000%2007-lo28zpz94bzxpm/))
        
    - `0x0006` – 28 픽셀 (ASCII 14×28, 한글 28×28) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2001%2000,05%2000%2006%2000%2007-lo28zpz94bzxpm/))
        
    - `0x0007` – 32 픽셀 (ASCII 18×32, 한글 32×32) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2001%2000,05%2000%2006%2000%2007-lo28zpz94bzxpm/))
        
    
    전광판 높이에 맞춰 폰트 크기를 선택하면 됩니다. 예를 들어 1단(16px 높이) 전광판에는 16px 폰트(0x0003)가 적절하며, 2단(32px) 전광판에는 16px 또는 32px 폰트를 사용할 수 있습니다. **팁:** 한글/중문 등 2바이트 문자는 영문/숫자보다 픽셀 폭이 크며 (영문은 동일 폰트 높이에서도 폭이 절반) 왜곡이 적은 명료한 표시를 위해 **16픽셀 또는 32픽셀 폰트** 사용이 권장됩니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)).
    
7. **입장효과 (Entry Effect)** / **퇴장효과 (Exit Effect)** – 문구가 화면에 나타날 때(입장)와 사라질 때(퇴장)의 **애니메이션 효과**를 지정합니다. 예를 들어 우측에서 슬라이드되어 들어오게 한다든지, 페이드아웃으로 사라지게 하는 등의 효과 코드가 있습니다. 초기값 `0x0001`은 **“정지”** 효과로, 별다른 움직임 없이 화면에 즉시 나타나거나 사라짐을 의미합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%20%20%20-yj08odu8f2fb708e5hyg5xfl4gnrf696hq7i4hz4p3n04pa/)) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%201,%20%20-4e46aybx5878k2jbaw15ddk5dyr8b40zbm8fd9al34wegeork4jg917eghgyw5cqh2ff1ath/)). 다양한 효과 코드 (예: 슬라이드, 점멸, 커튼 등)는 매뉴얼 첨부1의 코드표에 정의되어 있으며 필요 시 참조하여 설정합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%20%20%20-yj08odu8f2fb708e5hyg5xfl4gnrf696hq7i4hz4p3n04pa/)).
    
8. **예비용** – 현재 사용되지 않는 예약 레지스터로 **0으로 유지**합니다. (내부 기능 확장 대비 공간)
    
9. **효과속도 (Effect Speed)** – 입장/퇴장 효과의 **재생 속도**를 조절합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,,%20%20%20%20-pt31qga7956g2jbl00ala6840e7ba157h454e31zboa041gea1289fujekq2m/)). 숫자가 작을수록 효과 진행이 빠르고, 클수록 느립니다. 값 범위는 0~~255 (0x00~~0xFF)이며, 기본값은 `0x001E` (30)로 중간 정도 속도입니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,,%20%20%20%20-pt31qga7956g2jbl00ala6840e7ba157h454e31zboa041gea1289fujekq2m/)).
    
    - **예시:** 좌/우로 이동하는 스크롤 효과의 경우 20~30 정도, 글자 깜박임(점멸) 효과의 경우 80 정도가 무난한 속도로 권장됩니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2000%2000,00%20ff-vu44ufj28akfrk/)).
        
    - 0으로 설정하면 일부 효과에서는 매우 빠른 진행 또는 즉시 표시를 의미합니다.
        
10. **유지시간 (Duration)** – 문구가 입장 효과로 등장한 이후 **화면에 정지되어 유지되는 시간**을 설정합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%2F%20%20%20%2020,%20%20%2080%20-zb38bma9e37187mna488boa911v09cdr9d4k7anrdowc509a5o4g7e7bz7pwf4toas873mta19wvas449xrx7z5nbe41eva/)). 단위는 0.5초이며, 값 범위는 0~~239 (0x00~~0xEF)입니다. 예를 들어 `0x0004`라면 4×0.5초 = **2초간** 문구를 화면에 머무르게 됩니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%2F%20%20%20%2020,%20%20%2080%20-zb38bma9e37187mna488boa911v09cdr9d4k7anrdowc509a5o4g7e7bz7pwf4toas873mta19wvas449xrx7z5nbe41eva/)). 기본값은 `0x0004 (2초)`이며, 필요한 경우 이 값을 늘려 문구를 더 길게 보여줄 수 있습니다. (`0x000A`=5초, `0x0014`=10초 등)
    
11. **X축 시작점 / 종료점** – 화면 가로방향으로 이 섹션이 표시될 **영역의 좌측 시작 좌표(X 시작)**와 **우측 끝 좌표(X 종료)**를 지정합니다. 좌표 단위는 **모듈 픽셀 기준 4픽셀**씩 증가하는 값입니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%2F%20%20%20-sp43cs0788bgu2cl0tdurgz85ayk3c2hal87selbh3sdncf04c0j8c3sj7rdk2qbta4a12o2yjup0awe9bwp5o1uaha487t/)). 0x0000이면 화면 맨 좌측, 0x0001이면 4픽셀 우측으로 이동한 지점이 됩니다. 이 값은 **섹션 분할 시 해당 섹션의 가로 범위**를 지정하는데 사용됩니다.
    
    - 화면을 분할하지 않고 전체화면(섹션0 하나)만 쓰는 경우 기본값 0x0000 (좌측 시작)과 패널 너비에 해당하는 종료점 값을 컨트롤러가 내장 설정으로 사용하므로, 사용자가 별도로 설정할 필요는 없습니다.
        
    - **예:** 전체 64px 폭 전광판을 좌우 반으로 나눠 섹션0/섹션1을 쓰고 싶다면, 섹션0의 X축 종료점을 0x0007 (7×4=28픽셀, 절반 근처)로, 섹션1의 X축 시작점을 0x0008 (32픽셀 지점)로 설정하는 식입니다.
        
12. **Y축 시작점 / 종료점** – 화면 세로방향으로 섹션 또는 텍스트의 **상단 시작 좌표(Y 시작)**와 **하단 끝 좌표(Y 종료)**를 지정합니다. 역시 **4픽셀 단위**로 지정하며, 0x0000이면 맨 위, 0x0001이면 4픽셀 아래를 뜻합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,%20%2F%20%20%20-sp43cs0788bgu2cl0tdurgz85ayk3c2hal87selbh3sdncf04c0j8c3sj7rdk2qbta4a12o2yjup0awe9bwp5o1uaha487t/)). 주로 **화면을 상하로 분할할 때** 섹션의 높이를 정하거나, 한 화면 내에서 텍스트를 세로로 배치 조정할 때 사용합니다.
    
    - 화면을 분할하지 않는 경우 기본값 0x0000으로 유지합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=%ED%94%BD%EC%85%80%20%EA%B0%92%200%204%208,28%2032%20%E2%80%A6%2096%20%E2%80%A6/)) ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,,%20%20%200000h%20-0p67bgcy997cun86iga929j4w1aoi1fyldhvcp54cth4ilrdbs7douj7s0o2ezagpi0xcxjkb279virygb9483susta6vaw2ar07d/)).
        
    - **예:** 전광판이 2단(세로 32픽셀)이고 기본 폰트가 16픽셀인 상황에서, 문구를 화면 맨 위가 아닌 약간 아래 (위쪽에 여백 4픽셀) 중앙에 표시하고 싶다면 Y 시작을 `0x0001`(4픽셀), Y 종료를 `0x0006`(24픽셀)로 설정합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=\)%202,4%20%20%20%20-x029rdq8ioxg476d9sxix3b379bwh6bcsbswgztp3mf959mej0dhhn90b/)). 이렇게 하면 32픽셀 높이 중 4픽셀 공백을 두고 16픽셀 폰트 문구가 가운데 오도록 배치됩니다.
        
    
    좌표 설정은 섹션 분할 사용 시 필수이며, 정확한 섹션 영역을 지정해줘야 각 섹션의 표시 범위가 겹치지 않습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20%20%20,16]%20-w747shvbx9a1293b89yboa38qpa317wyp1ezdbiy8b8n6dl34hhtary/)). 자세한 섹션 분할 방법은 첨부3 가이드에 추가 설명이 있습니다.
    
13. **배경이미지 번호 (Background Image #)** – **배경 화면으로 겹쳐 표시할 이미지 파일 번호**를 지정합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)). 전광판에 미리 여러 개의 **배경용 이미지/애니메이션 파일**을 저장해 둘 수 있으며, 여기서 그 파일 번호를 호출하면 현재 섹션의 배경으로 표시됩니다. 단, 배경이미지 기능은 **섹션0에서만 사용**할 수 있으므로 섹션0에만 유효한 설정입니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2F%2F%20%20%20,,%20%20%20%20-lw96wz0xyj4f5xb04b2z4fgr7birmfc046kftphncy9flo6bkegnk0j7txai68citdft4cwtdfvanak6089uyp2ajxgoal5717cetcj7cd76aea320ar7r/)).
    
    - `0x0000` – 배경이미지 표시 안 함 (기본값)
        
    - `0x0001` – 파일 번호 1번 호출 (배경 표시)
        
    - `0x0002` – 파일 번호 2번 호출 …
        
    - `0x00FF` – 파일 번호 255번 호출 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%20-jv09n2mbj868bofg8m0eww6i/))
        
    
    예를 들어 배경이미지 번호를 0x0003으로 설정하고, 저장 파일 #3이 파란 배경 그림이라면, 해당 섹션0 문구 뒤에 파란 배경이 겹쳐집니다. (배경 이미지는 문구보다 뒤 layer로 표시됨) 배경용 파일들은 별도의 PC 소프트웨어로 업로드해야 활용할 수 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%20,%20%20%20-uz31qxwgbpekw8xetta02c224mfaf30c503umqb5yti32aia4b5327mbooa/)).
    
14. **문자 색상 (Text Color Codes)** – 각 문자마다 개별적으로 색상을 지정할 수 있는 **2바이트 코드 값 리스트**입니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)). 문자색상 레지스터의 개수는 “최대 문자수”와 동일한 수로 할당되며, 각 레지스터의 값이 대응되는 문자 하나의 색상을 나타냅니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,%20%20%20%20,%20%20%20%20-ho34bja7df91702w9h3bx9cvrc746a8trga974dvs5cx41dma027ozk3gza15ds1tqy6jfwvajua07cqa5200pka488wk02c540cxka/)). 색상 코드는 7가지 기본색을 지원하며, 코드값과 색상의 관계는 다음과 같습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=%20%2000%2000%2000,05%2000%2006%2000%2007-lo28zpz94bzxpm/)):
    
    |코드 (Hex)|색상 의미|
    |---|---|
    |0x0001|빨강 (Red)|
    |0x0002|녹색 (Green)|
    |0x0003|노랑 (Yellow)|
    |0x0004|파랑 (Blue)|
    |0x0005|분홍 (Magenta)|
    |0x0006|청록 (Cyan)|
    |0x0007|흰색 (White)|
    
    _(※ 0x0000 코드는 사용하지 않음. 기본 단색 전광판의 경우 빨강(0x0001)만 유효하고 다른 코드는 무시될 수 있습니다.)_
    
    모든 문자를 동일한 색으로 표시하려면 이 리스트의 모든 값을 같은 색상 코드로 채우면 되고, 문자마다 다른 색을 원하면 각각 다르게 설정하면 됩니다. 예를 들어 5글자 문자열을 빨강-녹색-파랑-흰색-노랑 순으로 색을 주려면, 문자색상 레지스터 5개에 차례로 `0x0001, 0x0002, 0x0004, 0x0007, 0x0003` 을 설정하는 식입니다.
    
15. **문자열 (Text String Codes)** – 실제로 화면에 표시할 **문자들의 코드값**을 순서대로 넣는 레지스터 영역입니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)). 각 문자는 2바이트 **완성형 코드**로 표현되며, 지원하는 문자는 ASCII 영문/숫자/기호, 한글 완성형(KSC5601), 유니코드(선택 시), 사용자 정의 문자 등이 있습니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://file-pqglxgnxy5r4chvzbvutff%23:~:text=/)).
    
    - **ASCII 문자:** 1바이트 ASCII 코드 앞에 `0x00`을 덧붙여 2바이트로 표현합니다. 예를 들어 `'A'` (0x41)는 `0x0041`로, `'1'` (0x31)는 `0x0031`로 입력합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=ascii%20,0000h\)%20%20-vs57tvw1dmbyb9r4mr45dfm2c/)).
        
    - **한글 문자:** KSC5601 완성형 코드 값을 사용합니다. 예를 들어 `"가"`는 0xB0A1, `"나"`는 0xB3AA, `"다"`는 0xB4D9 와 같이 2바이트 코드로 표현합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=match%20at%20l1100%20,d9%20bb%20e7%20be%20c6-lo26cl7393e/)). 한글 코드표는 KSC5601 표준에 따르며, 관련 표를 참고하여 코드를 입력해야 합니다.
        
    - **예시:** 문자열 **"123 ABC"**를 표시하고자 할 때, 문자코드 값은 `0x0031, 0x0032, 0x0033, 0x0020, 0x0041, 0x0042, 0x0043` 순으로 설정합니다 ([Modbus RTU - DABIT Protocol Memory Map.pdf](file://xn--file-pqglxgnxy5r4chvzbvutff%23:~:text=,0033%200020%200041%200042%200043-rz98b07629d/)). 여기서 0x0020은 빈칸(space)입니다.
        
    - **예시(한글):** `"가나다라마바사아"`를 표시하려면 각각 `0xB0...(이하 계속)...
        
    
    예) **"가나다라마바사아"**의 각 글자 코드는 `0xB0A1, 0xB3AA, 0xB4D9, 0xB6F3, 0xB8B6, 0xB9D9, 0xBBE7, 0xBEC6` 입니다. (KSC5601 완성형 코드표 참조)
    
    **유니코드 모드(문자코드=0x0001)**를 사용하는 경우 각 문자는 2바이트 Unicode로 설정합니다. 예를 들어 **'定'** 문자(U+5B9A)는 코드 `0x5B9A`로 입력합니다. 단, 한글은 기본적으로 완성형 코드로 운용되므로 특별한 이유가 없다면 일반 모드(0x0000)를 사용하면 됩니다.
    

以上와 같이 **표시 속성 (#1–16)과 문자색상/문자코드**를 조합하여 원하는 화면 표시를 자유롭게 구성할 수 있습니다. 다음은 실제 PLC/PC에서 전광판에 데이터를 쓰는 **전송 시퀀스 예시**를 단계별로 살펴봅니다.

## 7. 샘플 레지스터 전송 시퀀스 예시 (PLC/PC 기준)

마지막으로, 앞서 설명한 내용을 토대로 **실제 Modbus 레지스터를 쓰는 순서**를 예를 들어 설명합니다. **예시 시나리오:** 전광판(1단 × 6열, 빨간 단색 LED)에 "123 ABC"라는 문구를 **빨간색**으로 **지속 표시**하고자 합니다. (섹션0 전체 화면 사용)

**전송 단계:**

1. **초기 준비:** 상위 장치(PLC 또는 PC)에서 DABIT 컨트롤러와 통신을 시작합니다. RS-485로 배선 및 통신 속도를 설정하고, 슬레이브 ID를 확인합니다. (기본값 ID 0번, RS-485 다중 연결 시 1~15번 사용). 또한 전광판의 환경설정(모듈수, 최대문자수 등)이 올바르게 설정되어 있는지 확인합니다. (예시 전광판은 1단×6열, 최대문자수 기본 16자로 가정)
    
2. **표시속성 전송:** 상위 장치는 **섹션0의 표시속성 16개 레지스터**에 아래와 같은 값을 준비하여 한꺼번에 씁니다 (기능코드 0x10 사용):
    
    - 페이지번호 = `0x0000` (0번 페이지)
        
    - 섹션번호 = `0x0000` (섹션0)
        
    - 표시제어 = `0x0063` (항상 표시)
        
    - 표시방법 = `0x0001` (즉시 신규 문구 표시)
        
    - 문자코드 = `0x0000` (일반 모드)
        
    - 폰트크기 = `0x0003` (16픽셀 폰트, 기본값)
        
    - 입장효과 = `0x0001` (정지 효과, 기본값)
        
    - 퇴장효과 = `0x0001` (정지 효과)
        
    - 예비용 = `0x0000`
        
    - 효과속도 = `0x001E` (30, 기본 속도)
        
    - 유지시간 = `0x0004` (2초 유지)
        
    - X축 시작점 = `0x0000` (좌측 시작)
        
    - Y축 시작점 = `0x0000` (상단 시작)
        
    - X축 종료점 = `0x0000` (전체 너비)
        
    - Y축 종료점 = `0x0000` (전체 높이)
        
    - 배경이미지 번호 = `0x0000` (배경 없음)
        
    
    위 속성들은 대부분 기본값이지만, **표시제어를 0x0063으로 설정**하여 해당 섹션이 항상 켜짐 상태가 되도록 한 것이 중요합니다. 이 데이터가 컨트롤러 RAM에 기록되어 준비되면, 다음 단계에서 오는 문자열을 받을 준비가 된 것입니다.
    
3. **문자 색상 전송:** 이어서 **섹션0의 문자색상 레지스터들**을 씁니다. 예시 문구 "123 ABC"는 총 7글자이므로 최대문자수(16) 중 7개만 사용됩니다. 7개 모두 **빨강색(코드 0x0001)**으로 표시하려면, 순서대로 `0x0001, 0x0001, 0x0001, 0x0001, 0x0001, 0x0001, 0x0001` 값을 넣어 전송합니다. (나머지 사용하지 않는 색상 레지스터가 있다면 0으로 두어도 무방)
    
4. **문자열 전송:** 문자색상까지 전송한 직후, **문자열 데이터 레지스터들**에 문구의 코드값을 전송합니다. "123 ABC"를 각 문자별 2바이트 코드로 변환하면 다음과 같습니다:
    
    - `0x0031` (문자 '1')
        
    - `0x0032` (문자 '2')
        
    - `0x0033` (문자 '3')
        
    - `0x0020` (빈칸 ' ')
        
    - `0x0041` (문자 'A')
        
    - `0x0042` (문자 'B')
        
    - `0x0043` (문자 'C')
        
    
    상위 장치는 위 7개의 값을 **섹션0 문자열 시작 주소**부터 순서대로 연속 쓰기합니다. 이때 컨트롤러는 즉시 해당 코드들을 해석하여 전광판에 문구를 표시합니다. (컨트롤러는 문자 데이터 수신을 트리거로 화면 표시를 수행함)
    
5. **표시장 확인:** 문자열 전송이 끝나면, 전광판에는 곧바로 "123 ABC" 텍스트가 빨간색으로 나타납니다. 설정된 효과(입장/퇴장 없음, 정지)대로 즉시 표시되고, 표시제어가 항상(0x0063)이므로 지속적으로 화면에 남아 있습니다.
    
6. **추가 동작:** 표시 중에 새로운 데이터를 수신하면 어떻게 되는지도 확인합니다. 예를 들어 동일 섹션0에 다시 다른 문자열을 위와 같은 절차로 보내면 표시방법(0x0001 설정)에 따라 현재 표시를 즉시 중단하고 새 메시지가 나타납니다. 또한 섹션1이나 섹션2에 데이터를 보낼 경우, 먼저 해당 섹션의 표시제어를 0x0063 등 **표시 활성화**로 변경해야 하며, 필요하면 좌표값(시작/종료점)을 설정한 후 동일한 순서(속성→문자색상→문자열)로 전송하면 됩니다.
    

위 예시는 PLC 또는 PC에서 레지스터 값을 작성하는 순서를 보여주었으며, 실제 구현에서는 이를 자동화된 프로그램이나 PLC 래더로 구성하게 됩니다. 다음으로, 이러한 과정 전체를 종합한 **전광판 동작 흐름**을 요약합니다.

## 8. 실제 전광판 동작 흐름 (설정 → 메시지 전송 → 표시 반영)

마지막으로, DABIT 전광판 컨트롤러를 운용하는 **전체 흐름**을 단계별로 정리하면 다음과 같습니다:

1. **초기 설치 및 설정:** 전광판과 컨트롤러를 설치하고 **배선 연결**(RS-232/485)을 완료합니다. 상위 장치와 통신 설정(속도, 패리티 등)을 맞추고 슬레이브 ID를 설정합니다. 그 다음 상위 장치에서 **환경설정 레지스터 5개**(맵 시작주소, 최대문자수, 모듈수 세로/가로, 메시지 모드)를 적절히 설정/확인하고 컨트롤러에 써줍니다. 이 단계는 시스템 구축 시 1회 수행되며, 설정값은 컨트롤러에 영구 저장됩니다. _(예: 전광판 크기 변경이나 최대 문자수 조정 필요 시에만 다시 수행)_
    
2. **운용 단계 – 실시간 표시:** 컨트롤러가 정상 통신 상태가 되면, 이제 상위 장치는 **주기적으로 표시 데이터를 전송**하여 전광판 내용을 업데이트합니다. 일반적인 순서는 다음과 같습니다:
    
    - **현재 시간 동기화:** 필요에 따라 일정 주기마다 현재 시간 7개 레지스터(B 영역)를 상위 장치의 기준 시각에 맞게 써넣어 컨트롤러 RTC를 동기화합니다. 이렇게 하면 전광판이 자체 시계를 유지하며, 시간 정보를 화면에 표시하는 기능에 활용할 수 있습니다.
        
    - **메시지 표시 갱신:** 새로운 메시지를 표시하려면, 해당 섹션의 **표시속성 + 문자색상 데이터**를 먼저 0x10 명령으로 전송하고, 곧이어 **문자열 데이터**를 0x10 명령으로 전송합니다. 전송 완료 즉시 전광판 화면에는 새로운 메시지가 반영됩니다. 이때 이전 메시지가 남아있지 않도록 표시방법(중단/교체 방식)과 표시제어(켬/끔)가 적절히 설정되어 있어야 합니다.
        
    - **다중 섹션 사용:** 화면을 분할하여 섹션1, 섹션2를 사용할 경우, 각 섹션별로 **표시속성→문자색상→문자열** 전송을 개별적으로 수행합니다. 새로운 섹션을 활성화할 땐 해당 섹션의 표시제어를 0 (off)에서 1회 이상 값 또는 0x0063 (on)으로 먼저 변경해야 합니다. 또한 분할된 섹션의 좌표(X/Y 시작·종료)를 설정하여 영역을 지정한 후 데이터를 보내야 합니다. 한 섹션의 데이터 전송이 완료되면 그 섹션 내용만 갱신됩니다.
        
3. **전광판 표시 및 모니터링:** 상위 장치가 데이터 전송을 완료하면, 전광판은 설정된 효과에 따라 문구를 표시합니다. 메시지는 설정된 **반복 횟수나 지속 시간** 동안 표시되고, 자동 종료되거나 (표시제어 값이 1회/n회인 경우) 계속 유지됩니다 (표시제어=항상인 경우). 운영자는 전광판이 올바른 내용을 표시하는지 모니터링하고, 필요하면 기능코드 0x03으로 컨트롤러의 메모리를 읽어 현재 설정이나 표시중인 데이터를 검증할 수 있습니다.
    
4. **메시지 변경/종료:** 새로운 정보를 표시해야 하면 상위 장치는 다시 해당 섹션에 새로운 속성/문자열 데이터를 보냅니다. 이전과 동일한 절차로 전송하면 전광판은 **즉시 내용을 갱신**합니다. 만약 특정 화면을 지우고 싶다면, 해당 섹션의 표시제어 값을 0x0000(표시 안 함)으로 쓰거나, 빈 문자열을 보내 화면을 공백으로 만들 수 있습니다. 또한 컨트롤러를 재설정하거나 환경설정을 초기화해야 할 상황에서는 맵 시작주소에 0xFFF0를 쓰는 특수 명령으로 메모리 맵을 초기 상태로 복원할 수 있습니다.
    

以上이 DABIT 전광판 컨트롤러의 **Modbus RTU 기반 제어 방법**에 대한 전반적인 설명입니다. 실제 현장에서 본 매뉴얼을 참고하여 설정값을 검토하고, Modbus 통신 프로그램(PLC 또는 PC 소프트웨어)을 작성하면 전광판 제어를 구현할 수 있습니다. 각 단계별 내용을 숙지하여 **전광판 설정 → 데이터 전송 → 화면 표시** 흐름을 정확히 이해하면, 실무에서 전광판을 효율적으로 운용할 수 있을 것입니다.

---
---
---
---

### MODBUS RTU에 관한 전반적인 정보


좋습니다. Modbus RTU에 대해 전반적인 내용을 정리하여 설명드릴게요. 기본 개념부터 통신 구조, 프레임 형식, 마스터-슬레이브 구조, 실제 산업 응용까지 포괄적으로 조사해드리겠습니다. 자료 준비되면 바로 공유드릴게요.

# Modbus RTU 통신 프로토콜 개요

## Modbus RTU의 개념과 특징

Modbus RTU(Modbus Remote Terminal Unit)는 **1979년 Modicon**사(현재 슈나이더 일렉트릭)에서 산업 현장의 장비간 통신을 위해 개발된 **직렬 통신 프로토콜**입니다 ([Modbus - Wikipedia](https://en.wikipedia.org/wiki/Modbus#:~:text=Modbus%20or%20MODBUS%20is%20a,1)). 오픈(공개) 프로토콜로 **로열티 없이 자유롭게 사용**할 수 있으며, 구현이 비교적 간단하고 유지보수가 쉬워 산업 자동화 분야의 사실상 표준(de facto standard)으로 널리 채택되었습니다 ([Modbus - Wikipedia](https://en.wikipedia.org/wiki/Modbus#:~:text=Modbus%20is%20popular%20in%20industrial,the%20data%20to%20be%20transmitted)) ([MODBUS 통신 알아보자 (1) - MODBUS 구조,역사, 특징](https://datawizard.co.kr/45#:~:text=%EB%AA%A8%EB%93%9C%EB%B2%84%EC%8A%A4%EC%9D%98%20%EA%B0%80%EC%9E%A5%20%ED%81%B0%20%EC%9E%A5%EC%A0%90%EC%9C%BC%EB%A1%9C%20%EA%BC%BD%ED%9E%88%EB%8A%94,%EC%9D%B4%EC%9C%A0%EA%B0%80%20%EC%97%AC%EA%B8%B0%EC%97%90%20%EC%84%A4%EB%AA%85%EC%9D%B4%20%EB%90%98%EC%96%B4%20%EC%9E%88%EC%8A%B5%EB%8B%88%EB%8B%A4)). Modbus는 **마스터/슬레이브** 구조(현재는 클라이언트/서버로도 언급)로 동작하며, 마스터 장치(예: PLC 또는 PC)가 통신을 주도하고 슬레이브 장치들이 응답하는 **요청-응답 기반 통신**입니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=During%20communication%2C%20the%20master%20device,code%2C%20and%20the%20processing%20result)) ([MODBUS 모드버스 통신, RS-485 (feat. LabVIEW, MSB624RA) - 정보업](https://leoup.tistory.com/7#:~:text=Modbus%20%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0%20,com)). 프로토콜 자체는 상위 **응용 계층 프로토콜**로서 정의되어 있어, 다양한 물리 계층 위에서 동작할 수 있습니다 ([Modbus - Wikipedia](https://en.wikipedia.org/wiki/Modbus#:~:text=The%20Modbus%20protocol%20uses%20serial,same%20%2091%2C%20via%20Modbus)).

**데이터 모델:** Modbus는 초기부터 공장 제어용 PLC의 메모리 구조에 맞게 **디지털 출력 코일(coil)**과 **디지털 입력(contact)**, **아날로그 입력 레지스터(Input Register)**, **보유 레지스터(Holding Register)**의 **4가지 데이터 타입**을 사용합니다 ([Modbus - Wikipedia](https://en.wikipedia.org/wiki/Modbus#:~:text=Modbus%20is%20often%20used%20to,discrete%20input%20or%20a%20contact)). 각 데이터 타입별로 주소 공간을 가져 장치의 메모리나 I/O 상태를 표현하며, 마스터는 **기능 코드(Function Code)**를 통해 슬레이브의 특정 주소(coil이나 레지스터 등)를 읽거나 쓸 수 있습니다. 예를 들어 **0x01 기능코드**는 디지털 코일 상태 읽기, **0x03 기능코드**는 보유 레지스터 값 읽기 등의 의미를 가지며, 슬레이브는 해당 요청에 맞춰 데이터를 반환하거나 오류 코드를 응답합니다 ([Modbus Protocol](https://www.modbustools.com/modbus.html#:~:text=The%20Request%20The%20function%20code,integrity%20of%20the%20message%20contents)) ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=How%20the%20Function%20Field%20is,are%20to%20read%20the%20ON%2FOFF)). 이러한 **단순하고 일관된 데이터 구조** 덕분에 Modbus는 이기종 기기간의 데이터 교환을 쉽게 해주며, 산업 현장의 다양한 센서/액추에이터와 제어장치를 연결하는 **표준 통신 프로토콜**로 자리잡았습니다 ([Modbus - Wikipedia](https://en.wikipedia.org/wiki/Modbus#:~:text=Modbus%20or%20MODBUS%20is%20a,1)).

## Modbus RTU의 통신 방식 (RS-232, RS-485 등)

Modbus RTU는 주로 **EIA-232 (RS-232)** 또는 **EIA-485 (RS-485)** 등의 **직렬 통신 회선**을 물리 계층으로 사용합니다 ([Modbus - Wikipedia](https://en.wikipedia.org/wiki/Modbus#:~:text=,high%20speed%20token%20passing%20network)) ([MODBUS 통신 알아보자 (1) - MODBUS 구조,역사, 특징](https://datawizard.co.kr/45#:~:text=%EC%9C%84%20%EB%8F%84%ED%91%9C%EC%97%90%EC%84%9C%20%EB%B3%B4%EC%97%AC%EC%A3%BC%EB%8A%94%20%EA%B2%83%EA%B3%BC%20%EA%B0%99%EC%9D%B4%2C)). RS-232와 RS-485는 전기적 특성과 통신 방식에 차이가 있으며, Modbus RTU의 적용 범위에도 영향을 줍니다.

- **RS-232:** **포인트-투-포인트**(Point-to-Point) 방식의 직렬 인터페이스로 **1:1 연결**에 사용됩니다. TX, RX 두 선과 접지로 통신하며 신호가 단일 종단(single-ended)이기 때문에 **노이즈에 취약**하고 통신 거리가 **약 15 m 내외**로 제한됩니다 ([RS485: 산업 표준 통신 프로토콜에 대한 종합 가이드 - 센서 원스톱 - 최고의 가치를 지닌 중국 센서 공급업체 및 공급망](https://sensor1stop.com/ko/knowledge/rs485/#:~:text=,RS485%EC%97%90%20%EC%A3%BC%EC%86%8C%20%EC%A7%80%EC%A0%95)). 또한 RS-232는 한 번에 한 쌍의 장치만 통신할 수 있어 **멀티드롭(Multidrop)** 네트워크를 지원하지 않으므로, Modbus RTU를 RS-232로 사용할 경우 마스터당 하나의 슬레이브만 직접 연결됩니다 ([RS485: 산업 표준 통신 프로토콜에 대한 종합 가이드 - 센서 원스톱 - 최고의 가치를 지닌 중국 센서 공급업체 및 공급망](https://sensor1stop.com/ko/knowledge/rs485/#:~:text=match%20at%20L292%20,RS485%EC%97%90%20%EC%A3%BC%EC%86%8C%20%EC%A7%80%EC%A0%95)). 주로 **근거리 장비 연결**이나 장치 설정용으로 쓰이고, 현장에서는 RS-485로 변환하여 다중 노드 연결을 구성하는 경우가 많습니다.
    
- **RS-485:** **2선식 차동 신호**를 사용하는 직렬 통신 규격으로, 하나의 버스에 **최대 32개의 노드**(장치)를 병렬로 연결할 수 있는 **멀티드롭** 방식을 지원합니다 ([RS485: 산업 표준 통신 프로토콜에 대한 종합 가이드 - 센서 원스톱 - 최고의 가치를 지닌 중국 센서 공급업체 및 공급망](https://sensor1stop.com/ko/knowledge/rs485/#:~:text=,%EC%B2%98%EB%A6%AC%ED%95%A0%20%EC%88%98%20%EC%9E%88%EC%96%B4%20%ED%99%95%EC%9E%A5%EC%84%B1%EC%9D%B4%20%EB%9B%B0%EC%96%B4%EB%82%A9%EB%8B%88%EB%8B%A4)). **반이중(Half-Duplex)** 모드로 두 가닥의 차동 쌍을 통해 송수신하며, 필요에 따라 **전이중(Full-Duplex)** 구성도 가능합니다. RS-485는 차동(differential) 전압 신호를 사용하므로 **전기적 잡음에 대한 내성이 높고**, 최대 **1,200 m(약 4,000피트)**까지 장거리 통신이 가능하여 산업 환경에 적합합니다 ([RS485: 산업 표준 통신 프로토콜에 대한 종합 가이드 - 센서 원스톱 - 최고의 가치를 지닌 중국 센서 공급업체 및 공급망](https://sensor1stop.com/ko/knowledge/rs485/#:~:text=,%EC%84%A4%EC%A0%95%EC%9D%B4%EC%A7%80%EB%A7%8C%20%EB%B0%98%EC%9D%B4%EC%A4%91%EC%9D%B4%20%EB%8D%94%20%EC%9D%BC%EB%B0%98%EC%A0%81%EC%9E%85%EB%8B%88%EB%8B%A4)) ([RS485: 산업 표준 통신 프로토콜에 대한 종합 가이드 - 센서 원스톱 - 최고의 가치를 지닌 중국 센서 공급업체 및 공급망](https://sensor1stop.com/ko/knowledge/rs485/#:~:text=1,%EA%B0%84%EC%9D%98%20%EC%A7%80%EC%A0%90%20%EA%B0%84%20%ED%86%B5%EC%8B%A0%EB%A7%8C%20%EC%A7%80%EC%9B%90%ED%95%A9%EB%8B%88%EB%8B%A4)). Modbus RTU는 이러한 RS-485의 특성을 활용하여 **여러 슬레이브 장치를 한 선로에 연결**하고, **장거리 배선**도 비교적 안정적으로 구현할 수 있습니다. 실제로 Modbus 프로토콜은 **산업용 RS-485 네트워크에서 가장 빈번하게 사용**되는 통신 규약이며, RS-485의 다중 장치 주소 지정 및 CRC 오류검출 기능을 통해 **다수 장치 간의 구조화된 통신 방식**을 정의합니다 ([RS485: 산업 표준 통신 프로토콜에 대한 종합 가이드 - 센서 원스톱 - 최고의 가치를 지닌 중국 센서 공급업체 및 공급망](https://sensor1stop.com/ko/knowledge/rs485/#:~:text=,%ED%86%B5%EC%8B%A0%EC%9D%84%20%EC%9C%84%ED%95%9C%20%EA%B5%AC%EC%A1%B0%ED%99%94%EB%90%9C%20%EB%B0%A9%EB%B2%95%EC%9D%84%20%EC%A0%95%EC%9D%98%ED%95%A9%EB%8B%88%EB%8B%A4)).
    

([image](https://chatgpt.com/c/67ece94b-6c94-8000-a009-2e79f1fee64e)) _그림 1: Modbus 프로토콜의 계층 구조 개념도. 상위 **Modbus 응용 계층**은 다양한 전송 매체를 통해 데이터 메시지를 주고받을 수 있다. Modbus RTU는 주로 **RS-232/RS-485 직렬 통신**(오른쪽 초록색 칸의 Master/Slave)에 실려 전송되고, **Modbus TCP/IP**는 이더넷 네트워크(오른쪽 보라색 칸의 TCP/IP 계층)를 통해 전송되는 방식이다 ([MODBUS 통신 알아보자 (1) - MODBUS 구조,역사, 특징](https://datawizard.co.kr/45#:~:text=%EC%9C%84%20%EB%8F%84%ED%91%9C%EC%97%90%EC%84%9C%20%EB%B3%B4%EC%97%AC%EC%A3%BC%EB%8A%94%20%EA%B2%83%EA%B3%BC%20%EA%B0%99%EC%9D%B4%2C))._

한편, Modbus 직렬 통신에는 **RTU 모드** 외에도 ASCII 모드가 있지만, RTU 모드는 **바이너리 프레임 형식**으로 더 효율적인 전송을 제공하기 때문에 산업 현장에서 **가장 일반적으로 사용**됩니다 ([Modbus Protocol](https://www.modbustools.com/modbus.html#:~:text=RTU%20Mode%20When%20controllers%20are,transmitted%20in%20a%20continuous%20stream)). ASCII 모드는 각 바이트를 2개의 ASCII 문자로 보내는데 반해, RTU 모드에선 8비트 이진 값으로 전송하므로 **동일한 baudrate에서 더 많은 데이터를 전달**할 수 있습니다 ([Modbus Protocol](https://www.modbustools.com/modbus.html#:~:text=When%20controllers%20are%20setup%20to,transmitted%20in%20a%20continuous%20stream)). 또한 RTU 모드에서는 프레임 사이의 간격 제약(이하 설명)을 제외하면 연속적인 데이터 스트림으로 취급되어 ASCII보다 통신 효율이 높습니다.

> **참고:** Modbus RTU에서 사용되는 **전송 매개변수**(baudrate, 데이터 비트, 패리티, 정지비트)는 통신하는 모든 장치 간에 일치해야 합니다. 일반적으로 **8비트 데이터, 패리티 없음(N), 1비트 정지(8N1)** 또는 **짝수 패리티(E), 1비트 정지(8E1)** 등의 형태로 설정하며, **baudrate**는 9,600bps, 19,200bps에서 115,200bps까지 현장 환경에 맞게 채택됩니다. 이처럼 물리계층 설정이 일치하고 배선이 올바르게 이루어지면, Modbus RTU 프로토콜은 상위에서 일정한 형식의 메시지를 주고받으며 동작하게 됩니다.

## Modbus RTU 데이터 프레임 구조

Modbus RTU 통신은 **메시지 프레임(frame)** 단위로 주고받습니다. **프레임의 시작과 끝**은 특별한 문자를 사용하지 않고 **통신 회선의 `침묵 간격(silent interval)`**으로 구분합니다. 구체적으로, **프레임 시작 전**에는 최소 **3.5 문자 시간** 이상 아무 신호를 보내지 않고 회선을 빈 상태로 두며, 이를 수신측 장비들이 새로운 프레임의 시작으로 인식합니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=In%20RTU%20mode%2C%20messages%20start,is%20received%2C%20each)). 그런 다음 첫 바이트부터 연속적으로 데이터를 전송하며, **프레임 종료 시점**에도 다시 **3.5 문자 시간 이상의 침묵**을 유지하여 수신기가 해당 프레임이 끝났음을 알 수 있도록 합니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=Following%20the%20last%20transmitted%20character%2C,can%20begin%20after%20this%20interval)). 이때 **메시지 전체를 연속된 스트림**으로 보내야 하며, 전송 중간에 **1.5 문자 시간**을 초과하는 간격이 생기면 수신기가 프레임이 끊어진 것으로 간주하여 버리게 되므로 주의가 필요합니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=The%20entire%20message%20frame%20must,If%20a%20silent)).

**프레임 형식:** Modbus RTU 프레임은 **[주소][기능 코드][데이터][CRC]**의 구조로 구성됩니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=START%20ADDRESS%20FUNCTION%20DATA%20CRC,Figure%204%20RTU%20Message%20Frame)). 프레임의 세부 구성 요소는 다음과 같습니다:

- **주소 (Address):** **1바이트** 길이로, 메시지의 목적지 슬레이브 장치 주소를 나타냅니다. 마스터가 요청 프레임을 보낼 때 대상 슬레이브의 주소를 넣으며, 슬레이브가 응답할 때는 자신의 주소를 넣어 어느 장치의 응답인지 표시합니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=bits%20%28RTU%29,example%2C%20Modbus%20Plus%20uses%20a)). **유효한 장치 주소 범위는 1~247**이며, **주소 0은 브로드캐스트(broadcast)** 용도로 예약되어 있습니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=bits%20%28RTU%29,which%20all%20slave%20devices%20recognize)). 브로드캐스트 프레임은 모든 슬레이브가 수신하여 처리하지만 응답을 보내지 않으며, 248~255는 향후 용도를 위해 예약되어 있습니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=The%20address%20field%20of%20a,which%20all%20slave%20devices%20recognize)).
    
- **기능 코드 (Function Code):** **1바이트**로, 슬레이브가 수행할 동작(기능)을 지정합니다. 예를 들어 **0x03**은 지정한 **보유 레지스터 읽기**, **0x06**은 **단일 레지스터 쓰기**, **0x10**은 **다중 레지스터 쓰기** 등의 명령을 나타냅니다. 슬레이브는 요청을 받아 정상 처리하면 **동일한 기능 코드**를 응답에 실어서 보내고, 에러가 발생하면 **기능 코드에 0x80이 추가된 값**(상위 비트 1 세트)을 넣어 오류 응답임을 표시합니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=When%20the%20slave%20responds%20to,set%20to%20a%20logic%201)). 기능 코드에 따라 뒤이어 오는 데이터 필드의 구조와 의미가 결정되며, Modbus 사양에는 1~**255 범위**의 코드 값 중 표준으로 정의된 것과 예약된 것들이 명시되어 있습니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=How%20the%20Function%20Field%20is,are%20to%20read%20the%20ON%2FOFF)).
    
- **데이터 (Data):** **가변 길이**(최대 수백 바이트)의 데이터 필드로, 해당 기능 코드가 필요로 하는 추가 정보나 실제 데이터 값을 담습니다. 예를 들어 **읽기 명령** 요청이라면 데이터 필드에 **시작 주소와 개수**를 포함하고, **응답**에서는 읽어온 **값들**이 데이터 필드에 담겨 전송됩니다 ([Modbus Protocol](https://www.modbustools.com/modbus.html#:~:text=The%20Request%20The%20function%20code,integrity%20of%20the%20message%20contents)) ([Modbus Protocol](https://www.modbustools.com/modbus.html#:~:text=The%20Response%20If%20the%20slave,the%20message%20contents%20are%20valid)). 쓰기 명령의 경우는 써야 할 **값**을 데이터 필드에 넣어서 보냅니다. 데이터 필드는 없을 수도 있는데, 예컨대 슬레이브에 **진단 명령(0x08)**을 보내는 경우 추가 데이터가 필요 없으므로 기능 코드만으로 명령이 완결됩니다. **바이트 순서**는 기본적으로 **빅엔디언**(16비트 값의 상위 바이트가 먼저)이며, 멀티바이트 데이터의 해석은 사전에 양측(장치 간) 합의된 방식에 따라 이루어집니다.
    
- **오류검출 (CRC):** **2바이트**로 된 **CRC-16** 체크섬 값입니다. 다중 장치 통신 환경에서 데이터 오류를 검출하기 위해 **순환 중복 검사(Cyclic Redundancy Check)** 알고리즘으로 계산된 16비트 값을 마지막에 추가합니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=START%20ADDRESS%20FUNCTION%20DATA%20CRC,Figure%204%20RTU%20Message%20Frame)). Modbus RTU는 **다항식 0xA001(역순 0x8005)**을 사용하는 CRC-16 방식을 표준으로 정의하며, 계산된 16비트 값의 **하위 바이트를 먼저, 상위 바이트를 나중에** 전송합니다. 수신측 슬레이브는 수신한 프레임의 주소부터 데이터 필드 끝까지 동일한 방식으로 CRC를 계산하여 받은 CRC와 비교함으로써 데이터 오류(비트 뒤바뀜 등)를 검출합니다 ([Modbus Protocol](https://www.modbustools.com/modbus.html#:~:text=The%20function%20code%20in%20the,integrity%20of%20the%20message%20contents)). 만약 CRC 값이 일치하지 않으면 슬레이브는 해당 프레임을 **오류로 폐기**하고 아무 응답도 보내지 않습니다.
    

정리하면, Modbus RTU **메시지 프레임**은 **“정숙(침묵) 구간 – [주소][기능][데이터][CRC] – 정숙 구간”**의 형태를 가지며, 모든 바이트는 **연속적으로 전송**되어야 합니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=The%20entire%20message%20frame%20must,If%20a%20silent)) ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=START%20ADDRESS%20FUNCTION%20DATA%20CRC,Figure%204%20RTU%20Message%20Frame)). 이러한 프레임 구조 덕분에 수신 장치는 버스 상에서 자신의 주소로 시작되는 올바른 프레임만을 인식하여 처리하고, 다른 주소로 된 데이터나 손상된 프레임은 무시하게 됩니다.

> **예시:** 마스터가 슬레이브 주소 0x05번 장치의 보유 레지스터(40001번 주소) 2개를 읽는 요청을 보내는 경우, 프레임 구성은 다음과 같습니다. **[0x05][0x03][0x00 0x00 0x00 0x02][CRC_LOW CRC_HIGH]**로, 여기서 0x05는 슬레이브 주소, 0x03은 기능(보유레지스터 읽기), 0x0000는 시작 레지스터 주소, 0x0002는 읽을 레지스터 개수, CRC는 이 전체에 대한 CRC-16 값입니다. 슬레이브는 정상 수행 시 자신의 주소 0x05, 기능 0x03, 다음 바이트에 바이트 수(예: 0x04), 그리고 두 레지스터의 데이터 값(4바이트)을 넣어 응답하며, 끝에 CRC를 추가합니다. 만약 슬레이브에 해당 레지스터가 없으면 0x83 (0x03|0x80)과 오류 코드를 데이터로 넣어 에러 응답을 보내게 됩니다.

## 마스터/슬레이브 통신 구조 및 동작 원리

Modbus RTU는 **단일 마스터-다중 슬레이브** 구조로 동작합니다. **마스터 장치**는 통신을 **주도하는 역할**을 하며, 주기적으로 각 슬레이브에게 **요청(query)** 메시지를 보냅니다. 슬레이브 장치는 자신의 주소로 온 요청을 받으면 지정된 기능을 수행한 뒤 그 **결과를 응답(response)** 메시지로 반환합니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=During%20communication%2C%20the%20master%20device,code%2C%20and%20the%20processing%20result)). 모든 슬레이브들은 버스를 **수신 대기**하며, 프레임의 첫 바이트(주소)를 확인하여 **자신의 주소일 경우에만** 나머지 데이터를 해석 및 처리합니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=The%20allowable%20characters%20transmitted%20for,can%20begin%20after%20this%20interval)). **브로드캐스트(주소 0)**로 온 메시지는 모든 슬레이브가 처리하지만 응답을 보내지 않습니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=bits%20%28RTU%29,example%2C%20Modbus%20Plus%20uses%20a)). 이처럼 마스터의 일방향 요청에 슬레이브가 응답하는 **폴링(polling)** 방식으로 통신이 진행되며, **슬레이브는 요청을 받지 않는 한 버스에 데이터를 송출하지 않습니다.**

**통신 절차:** 마스터는 각 주기마다 통신할 **슬레이브의 주소**와 수행할 **기능 코드**, 관련 **데이터**를 담은 요청 프레임을 송신합니다. 해당 슬레이브는 수신 즉시 프레임의 CRC를 검증하고, 유효하면 요구된 작업(예: 레지스터 읽기)을 수행합니다. 그 결과를 자신의 **응답 프레임**에 실어 마스터로 송신하는데, 이 응답에는 요청을 보낸 마스터가 이해할 수 있도록 **요청과 같은 주소와 기능 코드**(또는 오류 시 수정된 기능 코드) 및 데이터/상태 값이 포함됩니다 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=When%20a%20message%20is%20sent,the%20function%20code%20field%20to)) ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=When%20the%20slave%20responds%20to,set%20to%20a%20logic%201)). 마스터는 응답의 CRC를 검사하여 오류 없을 시 데이터를 상위 애플리케이션에 전달하고, 만약 **지정된 시간** 내에 응답이 없으면 해당 요청이 실패한 것으로 간주하여 **타임아웃** 처리합니다. 필요에 따라 마스터는 타임아웃 발생 시 동일 요청을 재시도하거나, 다음 슬레이브로 넘어가 폴링을 이어갑니다. 일반적으로 마스터는 **연속적으로 슬레이브들을 차례로 폴링**하여 데이터 수집/제어를 수행하며, **한 번에 한 슬레이브만 통신회선을 사용**하므로 버스 충돌이 발생하지 않습니다.

이러한 구조에서 **통신 순서**와 **응답 시간**은 모두 마스터에 의해 관리됩니다. 슬레이브는 **수동적 장치**로서 요청이 올 때만 동작하므로, 긴급한 이벤트가 발생해도 즉시 통보(report by exception)를 할 수 없는 한계가 있습니다 ([Modbus protocol disadvantages & limitations - MindoLife IoT](https://www.mindolife.com/blog-post/modbus-protocol-disadvantages-limitations/#:~:text=and%20175%E2%97%A6,avoid%20gaps%20in%20the%20transmission)). 대신 슬레이브의 상태 변화를 마스터가 **주기적으로 조회**(poll)하여 변화를 감지하는 방식으로 운용합니다. 마스터/슬레이브 방식은 구조가 단순하여 **복수의 슬레이브를 효율적으로 제어**할 수 있지만, 네트워크에 **마스터는 오직 하나**만 존재해야 하므로 한 버스에 여러 주체가 동시에 명령을 보내는 것은 지원하지 않습니다.

> **계층적 통신 예:** Modbus는 흔히 **SCADA 시스템의 상위 컴퓨터**(감시제어용 서버)와 원격 현장의 **RTU**(Remote Terminal Unit) 또는 **PLC**를 연결하는 데 사용됩니다 ([Modbus - Wikipedia](https://en.wikipedia.org/wiki/Modbus#:~:text=Modbus%20is%20often%20used%20to,of%20its%20use%20in%20driving)). 예를 들어 공장 전체를 모니터링하는 SCADA 서버가 Modbus 마스터가 되어 여러 지역에 분산된 PLC들을 폴링하고, 각 PLC는 해당 지역의 센서/액츄에이터들을 Modbus 슬레이브(혹은 하위 마스터 역할)로 제어하는 식의 **계층적 통신망**을 구성할 수 있습니다 ([MODBUS 모드버스 통신, RS-485 (feat. LabVIEW, MSB624RA) - 정보업](https://leoup.tistory.com/7#:~:text=Modbus%20%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0%20,com)). 이러한 유연한 **요청-응답 구조와 데이터 모델** 덕분에 Modbus는 수십 년이 지난 현재까지도 산업계에서 폭넓게 활용되고 있습니다 ([MODBUS 모드버스 통신, RS-485 (feat. LabVIEW, MSB624RA) - 정보업](https://leoup.tistory.com/7#:~:text=Modbus%20%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0%20,com)).

## 주요 사용 사례 및 산업 응용 예

Modbus RTU는 단순성과 범용성으로 인해 다양한 산업 분야에서 활용됩니다. **플랜트 자동화**, **공정 제어**, **빌딩 관리**, **에너지 모니터링** 등 데이터 수집과 장치 제어가 필요한 곳에서 표준 통신 수단으로 사용되고 있습니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=Modbus%20protocol%20has%20extensive%20applications,are%20some%20typical%20application%20scenarios)) ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=2,comfort%20control%20of%20these%20devices)). 주요 응용 사례는 다음과 같습니다:

- **산업 자동화:** 공장 제조 공정에서 **PLC(프로그램 논리 제어기)**와 **센서/액추에이터** 간 실시간 데이터 교환에 Modbus RTU가 널리 사용됩니다. 예를 들어 PLC 마스터가 여러 현장 장치(온도 센서, 밸브, 모터 드라이브 등)를 RS-485 버스로 연결된 슬레이브로 폴링하여 **상태 모니터링, 제어 명령 전송**을 수행합니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=1,of%20devices%20can%20be%20realized)). 이를 통해 **원격 감시**, **장애 진단**, **설비 제어**가 가능하며, 비용 효율적인 배선으로 다수의 장치를 연결할 수 있어 산업 생산라인의 자동화 통신망에 적합합니다.
    
- **건물 관리 시스템(BAS):** **빌딩 자동화** 분야에서도 Modbus RTU가 많이 활용됩니다. 예컨대 냉난방(HVAC) 장치, 조명 제어 모듈, 보안 시스템 등을 Modbus RTU 기반으로 연결하면 중앙 관리 컴퓨터가 각 장치의 상태를 모니터링하고 제어할 수 있습니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=2,comfort%20control%20of%20these%20devices)). 하나의 RS-485 네트워크에 다양한 설비 기기를 접속함으로써 **건물 에너지 관리**, **온도/조도 제어**, **보안 감시** 등을 통합적으로 수행할 수 있으며, 기존 설비에도 Modbus 인터페이스 모듈을 추가하여 비교적 손쉽게 통합이 가능합니다.
    
- **에너지 관리 및 시설 모니터링:** 전력 및 에너지 관리 분야에서 Modbus RTU는 **전력 미터기**, **배전반 모니터**, **수위/유량계** 등의 계측 장비와 상위 시스템을 연결하는 데 표준적으로 사용됩니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=3,usage%20patterns%2C%20and%20energy%20optimization)). 예를 들어 태양광 발전소에서는 각 인버터와 미터들이 Modbus RTU로 연결되어 발전량, 전압 등을 SCADA 시스템에 실시간 전송하고, 전력망에서는 고장 표지장치나 원격 단말을 Modbus로 연결해 원격 제어합니다. 또한 **가스/수도 원격 검침**, **환경 센서 네트워크** 등에서도 Modbus RTU 기반 장치들이 현장 데이터 수집에 활용되고 있습니다. 이처럼 Modbus는 **제조업**부터 **건물/시설 관리**, **에너지/유틸리티**에 이르기까지 폭넓은 산업 현장에서 현장 기기의 **상태 모니터링과 제어용 통신표준**으로 응용되고 있습니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=Modbus%20protocol%20has%20extensive%20applications,are%20some%20typical%20application%20scenarios)).
    

## 일반적인 장점과 단점

Modbus RTU 프로토콜은 오래된 통신 방식이지만 여전히 많이 쓰이는 데에는 그만한 **장점**이 있습니다. 동시에 현대적 관점에서 보면 몇 가지 **한계점**과 **단점**도 존재합니다. 아래는 Modbus RTU의 주요 장점과 단점을 정리한 것입니다.

### 장점

- **개방형 표준과 호환성:** Modbus는 **공개된 프로토콜**로 **라이선스 비용 없이 자유롭게 사용**할 수 있기 때문에 산업계에 폭넓게 보급되었고, 다양한 제조사의 장비들이 Modbus를 지원하여 **상호 운용성(interoperability)**이 매우 높습니다 ([Modbus - Wikipedia](https://en.wikipedia.org/wiki/Modbus#:~:text=Modbus%20is%20popular%20in%20industrial,the%20data%20to%20be%20transmitted)) ([The advantages of Modbus RTU communication over analogue signals](https://www.sentera.eu/en/news/the-advantages-of-modbus-rtu-communication-over-analogue-signals/1574#:~:text=%2A%20Interoperability%20,a%20pplicable%20in%20various%20sectors)). 즉, 서로 다른 업체의 PLC, 센서, 계측기라도 Modbus 인터페이스만 있으면 쉽게 통신을 구축할 수 있습니다.
    
- **구조 단순 및 구현 용이:** Modbus RTU의 **메시지 프레임 구조가 단순**하고 프로토콜 동작이 직관적이어서 소형 마이크로컨트롤러부터 산업용 컴퓨터까지 **구현이 쉽고 디버깅이 용이**합니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=Advantages%3A)). 또한 데이터 형식이 기본적인 레지스터/코일 단위이므로 소프트웨어에서 다루기 수월하며, 초기 개발 부담이 적습니다. 이러한 이유로 **산업 현장 엔지니어들이 가장 먼저 떠올리는 통신 프로토콜** 중 하나가 Modbus입니다.
    
- **다중 장치 연결과 확장성:** RS-485 등 멀티드롭 지원 매체 위에서 동작하는 덕분에, **한 개 통신선으로 여러 장치를 연결**하여 사용할 수 있어 배선이 간소화되고 시스템 확장이 수월합니다 ([RS485: 산업 표준 통신 프로토콜에 대한 종합 가이드 - 센서 원스톱 - 최고의 가치를 지닌 중국 센서 공급업체 및 공급망](https://sensor1stop.com/ko/knowledge/rs485/#:~:text=,%EC%B2%98%EB%A6%AC%ED%95%A0%20%EC%88%98%20%EC%9E%88%EC%96%B4%20%ED%99%95%EC%9E%A5%EC%84%B1%EC%9D%B4%20%EB%9B%B0%EC%96%B4%EB%82%A9%EB%8B%88%EB%8B%A4)). 예를 들어 하나의 RS-485 버스에 최대 32대의 노드를 연결할 수 있고, 리피터를 사용하면 네트워크를 연장할 수도 있습니다. 필요에 따라 Modbus TCP(이더넷)로도 손쉽게 전환 가능하여, **직렬통신부터 이더넷까지 다양한 전송 매체를 지원**하는 **유연성**도 장점입니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=%C2%B7%C2%A0Strong%20Scalability%3A%20Modbus%20protocol%20supports,configuration%20based%20on%20actual%20needs)).
    
- **신뢰성과 안정성:** Modbus RTU는 통신 오류를 검출하기 위한 **CRC 오류검출** 메커니즘을 내장하고 있고, RS-485 기반 통신은 **잡음에 강인한 차동신호**를 사용하므로 산업 환경에서도 **데이터 신뢰도가 높습니다** ([The advantages of Modbus RTU communication over analogue signals](https://www.sentera.eu/en/news/the-advantages-of-modbus-rtu-communication-over-analogue-signals/1574#:~:text=%2A%20Interoperability%20,a%20pplicable%20in%20various%20sectors)). 또한 프로토콜이 단순한 만큼 **통신 지연이 짧고**(프레임 처리 오버헤드가 작음), 적절한 통신속도(baudrate)를 선택하면 수십 미터~~수백 미터 거리의 노이즈 많은 현장에서도 안정적으로 데이터 전달이 가능합니다 ([The advantages of Modbus RTU communication over analogue signals](https://www.sentera.eu/en/news/the-advantages-of-modbus-rtu-communication-over-analogue-signals/1574#:~:text=%2A%20Robustness%20and%20Reliability%20,Modbus%20RTU%20communication%20is%20c)). 실제로 Modbus는 기존 아날로그 4~~20mA 신호나 0-10V 신호 대비 **정확하고 풍부한 디지털 데이터 전송**을 가능케하여 산업계의 신뢰를 얻었습니다 ([The advantages of Modbus RTU communication over analogue signals](https://www.sentera.eu/en/news/the-advantages-of-modbus-rtu-communication-over-analogue-signals/1574#:~:text=In%20addition%20to%20the%20possibility,advantages%20compared%20to%20analog%20signals)) ([The advantages of Modbus RTU communication over analogue signals](https://www.sentera.eu/en/news/the-advantages-of-modbus-rtu-communication-over-analogue-signals/1574#:~:text=%2A%20Data%20Richness%20,For)).
    
- **광범위한 적용 분야:** Modbus는 수십 년간 축적된 활용 사례로 방대한 라이브러리와 툴이 존재하고, **SCADA/HMI 소프트웨어나 시험 장비에서도 기본 프로토콜로 지원**되는 경우가 많습니다. 그만큼 **검증된 표준**으로서 산업 자동화, 건물관리, 에너지, 교통 등 **다양한 분야에 적용 가능**하며, 새로운 시스템에 통합할 때도 프로토콜 자체를 새로 배우거나 개발해야 하는 부담이 적습니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=%C2%B7%C2%A0Wide%20Applicability%3A%20Modbus%20protocol%20has,enjoying%20widespread%20support%20and%20application)).
    

### 단점

- **낮은 통신 속도와 데이터량 제한:** Modbus RTU는 비교적 **저속의 직렬 통신**을 기반으로 하기 때문에 현대 산업의 **고속/대용량 데이터 전송 요구에는 한계**가 있습니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=%C2%B7%C2%A0Slow%20Speed%3A%20Compared%20to%20other,time%20requirements)). 일반적으로 수 kbps~수십 kbps 수준의 데이터 교환에 적합하며, 수백 바이트 이상의 **대용량 데이터 전송에는 비효율적**입니다. 또한 프로토콜 설계 당시 지원하는 데이터 타입이 16비트 정수 등의 **한정된 형식**만 있었고 **대형 이진 객체나 파일 전송을 지원하지 못하도록 설계**되어 있어 ([Modbus protocol disadvantages & limitations - MindoLife IoT](https://www.mindolife.com/blog-post/modbus-protocol-disadvantages-limitations/#:~:text=TCP%2FIP%20proving%20the%20exception%29,way%20for%20a%20field%20device)), 영상이나 복잡한 데이터 구조를 직접 보내기는 어렵습니다.
    
- **마스터/슬레이브 구조 제약:** 단일 마스터에 다중 슬레이브가 응답하는 구조이므로 **동시에 여러 장치가 통신할 수 없으며**, **슬레이브 간 직접 통신**도 불가능합니다. 모든 데이터 교환이 마스터의 주기적 폴링에 의존하므로 **실시간성이 떨어지고**, 이벤트 발생 시 즉각 알려주는 **예외 보고(report by exception)** 메커니즘이 없습니다 ([Modbus protocol disadvantages & limitations - MindoLife IoT](https://www.mindolife.com/blog-post/modbus-protocol-disadvantages-limitations/#:~:text=and%20175%E2%97%A6,avoid%20gaps%20in%20the%20transmission)). 예를 들어 슬레이브 장치에서 긴급 상황이 발생해도 마스터가 폴링하기 전까지는 알아채기 어렵다는 단점이 있습니다. 또한 네트워크마다 마스터가 하나로 고정되므로 **멀티 마스터** 구성을 지원하지 않아 확장성에 제약이 있습니다.
    
- **보안 기능의 부재:** Modbus 프로토콜 자체에는 **인증(Authentication)이나 암호화(Encryption)**와 같은 **보안 기능이 전혀 없습니다 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=applications%20with%20high%20real)) ([Modbus protocol disadvantages & limitations - MindoLife IoT](https://www.mindolife.com/blog-post/modbus-protocol-disadvantages-limitations/#:~:text=to%20%E2%80%9Creport%20by%20exception%E2%80%9D%20,limiting%20the%20types%20of%20remote)).** 따라서 네트워크 상에 감청이나 명령 위/변조 공격이 가능하며, 최근 IIoT 환경에서 문제가 될 소지가 있습니다. 실제로 Modbus는 **평문으로 모든 데이터를 주고받기 때문에** 중요 인프라에 사용시 방화벽, VPN 등의 외부 보안대책에 의존해야 합니다. 이 프로토콜이 설계될 당시(1970~80년대) 폐쇄망에서의 사용을 전제로 했던 한계로, **현대 보안 요건을 만족하지 못한다**는 점이 단점으로 지적됩니다.
    
- **주소 및 장치 수 제한:** Modbus RTU는 설계상 **한 네트워크에 연결할 수 있는 슬레이브 수가 247대로 제한**됩니다 ([Modbus protocol disadvantages & limitations - MindoLife IoT](https://www.mindolife.com/blog-post/modbus-protocol-disadvantages-limitations/#:~:text=1,temperature%20between%2030%E2%97%A6%20and%20175%E2%97%A6)). 주소 필드가 1바이트(0~255) 중 일부 예약을 제외하고 247개까지만 사용 가능하므로, 더 많은 장치를 연결하려면 여러 개의 버스로 분산하거나 게이트웨이를 통해 네트워크를 분할해야 합니다. 규모가 큰 시스템에서는 이러한 주소 제한이 구조를 복잡하게 만들 수 있습니다.
    
- **데이터의 의미 및 표준 부족:** Modbus는 **데이터를 주고받는 형식만 규정**할 뿐, 각 데이터가 어떤 물리량이나 의미를 가지는지에 대한 메타데이터 표준이 없습니다 ([Modbus protocol disadvantages & limitations - MindoLife IoT](https://www.mindolife.com/blog-post/modbus-protocol-disadvantages-limitations/#:~:text=controllers%3B%20the%20number%20of%20data,commands%20or%20interception%20of%20data)). 예를 들어 어떤 슬레이브의 40001 레지스터가 온도인지 압력인지, 단위는 무엇인지를 **통신상으로 알아낼 방법이 없고**, 사용자나 엔지니어가 **개별 장치의 매뉴얼을 보고 해석**해야 합니다. 이 때문에 이기종 기기 통합 시 **데이터 해석에 혼선**이 생길 여지가 있고, 장치 교체 시 재설정을 수동으로 해야 하는 불편함이 있습니다. (후에 이를 보완하기 위해 Modbus 장치 정보의 표준 표현(XML 등)이 논의되었지만, 본질적인 프로토콜 수준에서는 여전히 한계로 남아 있습니다.)
    
- **그 외 제약:** Modbus RTU는 통신이 **연속적으로 이어져야 하는 제약**이 있어 (중간에 큰 간격이 생기면 프레임 오류) 저속 무선이나 인터넷 환경에 직접 적용하기 어렵고 ([Modbus protocol disadvantages & limitations - MindoLife IoT](https://www.mindolife.com/blog-post/modbus-protocol-disadvantages-limitations/#:~:text=to%20%E2%80%9Creport%20by%20exception%E2%80%9D%20,avoid%20gaps%20in%20the%20transmission)), 대형 시스템에서는 **설정 및 프로그래밍 작업이 많아지는 단점**도 있습니다 ([Modbus protocol disadvantages & limitations - MindoLife IoT](https://www.mindolife.com/blog-post/modbus-protocol-disadvantages-limitations/#:~:text=5,standard%20in%20the%20SIMATIC%20family)). 또한 일부 최신 산업용 통신(예: EtherCAT, PROFINET 등)과 비교하면 기능 면에서 단순하기 때문에, 고도의 동기화나 실시간 제어에는 적합하지 않은 경우도 있습니다. 그럼에도 불구하고 Modbus는 단순성과 호환성 측면의 장점이 커서, 제한사항들을 관리가능한 범위 내에서 현재까지도 다양한 산업 현장에서 활용되고 있습니다.
    

**참고 문헌:** Modbus 프로토콜 공식 문서 ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=In%20RTU%20mode%2C%20messages%20start,is%20received%2C%20each%20device)) ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=Following%20the%20last%20transmitted%20character%2C,can%20begin%20after%20this%20interval)) ([Document:](https://modbus.org/docs/PI_MBUS_300.pdf#:~:text=The%20address%20field%20of%20a,example%2C%20Modbus%20Plus%20uses%20a)), 산업용 통신 블로그 ([MODBUS 통신 알아보자 (1) - MODBUS 구조,역사, 특징](https://datawizard.co.kr/45#:~:text=%EB%AA%A8%EB%93%9C%EB%B2%84%EC%8A%A4%EC%9D%98%20%EA%B0%80%EC%9E%A5%20%ED%81%B0%20%EC%9E%A5%EC%A0%90%EC%9C%BC%EB%A1%9C%20%EA%BC%BD%ED%9E%88%EB%8A%94,%EC%9D%B4%EC%9C%A0%EA%B0%80%20%EC%97%AC%EA%B8%B0%EC%97%90%20%EC%84%A4%EB%AA%85%EC%9D%B4%20%EB%90%98%EC%96%B4%20%EC%9E%88%EC%8A%B5%EB%8B%88%EB%8B%A4)) ([RS485: 산업 표준 통신 프로토콜에 대한 종합 가이드 - 센서 원스톱 - 최고의 가치를 지닌 중국 센서 공급업체 및 공급망](https://sensor1stop.com/ko/knowledge/rs485/#:~:text=,%ED%86%B5%EC%8B%A0%EC%9D%84%20%EC%9C%84%ED%95%9C%20%EA%B5%AC%EC%A1%B0%ED%99%94%EB%90%9C%20%EB%B0%A9%EB%B2%95%EC%9D%84%20%EC%A0%95%EC%9D%98%ED%95%A9%EB%8B%88%EB%8B%A4)), PUSR IIoT 블로그 ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=Advantages%3A)) ([Modbus Protocol: Working Principles, Advantages, Disadvantages, and Applications](https://www.pusr.com/blog/Modbus-Protocol-Working-Principles-Advantages-Disadvantages-and-Applications#:~:text=%C2%B7%C2%A0Slow%20Speed%3A%20Compared%20to%20other,time%20requirements)), etc.


