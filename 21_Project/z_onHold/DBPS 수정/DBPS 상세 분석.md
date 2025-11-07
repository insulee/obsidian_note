## 1. 프로젝트 구조 개요

DBPS Simulator는 데이터베이스 처리 시스템(DBPS)을 시뮬레이션하는 JavaFX 기반 애플리케이션입니다. 이 프로젝트는 다양한 통신 프로토콜(시리얼, TCP, UDP, 블루투스 등)을 지원하며, 전광판 디스플레이 제어와 관련된 다양한 기능을 제공합니다.

## 2. 핵심 파일 및 역할

### 2.1. 애플리케이션 진입점

#### **module-info.java**
- **역할**: Java 모듈 시스템 설정 파일
- **기능**: 
  - 필요한 외부 모듈 의존성 정의 (JavaFX, Jackson, jSerialComm 등)
  - 패키지 export 및 open 설정
- **연계 파일**: 프로젝트의 모든 Java 파일과 연계됨

#### **Simulator.java**
- **역할**: 애플리케이션의 메인 클래스
- **기능**: 
  - JavaFX 애플리케이션 초기화 및 실행
  - UI 로딩 및 표시
  - 종료 시 모든 연결 리소스 정리
- **작동 방식**: 
  - `start()` 메서드에서 메인 UI를 로드하고 표시
  - 백그라운드에서 FXML 로드 작업 수행
  - 종료 시 모든 통신 연결 닫기
- **연계 파일**: 
  - `main.fxml`: 메인 UI 정의
  - `ConfigService.java`: 설정값 로드
  - 다양한 연결 관리자(SerialPortManager, TCPManager 등)

#### **Constants.java**
- **역할**: 시스템 전반에서 사용되는 상수 및 유틸리티 메서드 정의
- **기능**: 
  - 연결 유형, 포트, 주소 등 글로벌 설정값
  - CRC 계산, 바이트 변환, 패킷 생성 등 유틸리티 함수
  - 모달 창 열기, 데이터 처리, 로그 포맷팅 함수
- **연계 파일**: 
  - `ConfigService.java`: 설정값 로드
  - 대부분의 컨트롤러 및 서비스 클래스

### 2.2. 컨트롤러 클래스 (`src/main/java/dbps/dbps/controller/`)

#### **MainController.java**
- **역할**: 메인 화면 컨트롤러
- **기능**: 
  - 탭 전환 관리 (메시지 탭, 설정 탭)
  - UI 초기화
- **연계 파일**: 
  - `main.fxml`: UI 정의
  - `MainService.java`: 비즈니스 로직

#### **주요 컨트롤러들**
1. **CommunicationSettingController.java** (28KB)
   - **역할**: 통신 설정 관리
   - **기능**: 시리얼, TCP, UDP, 블루투스 등 통신 설정
   - **연계 파일**: connectManager 디렉토리의 관리자 클래스들

2. **HEXMessageController.java** (64KB)
   - **역할**: HEX 메시지 관리
   - **기능**: HEX 형식 메시지 작성, 전송, 표시
   - **연계 파일**: `HexMsgService.java`, `HexMsgTransceiver.java`

3. **FontSettingController.java** (51KB)
   - **역할**: 폰트 설정 관리
   - **기능**: 전광판에 사용될 폰트 설정
   - **연계 파일**: `FontService.java`, `fontSetting.fxml`

4. **DabitNetController.java** (31KB)
   - **역할**: DABIT 네트워크 제어
   - **기능**: DABIT 네트워크 설정 및 통신
   - **연계 파일**: `DabitNetService.java`, `dabitNet.fxml`

5. **FirmwareUpgradeController.java** (15KB)
   - **역할**: 펌웨어 업그레이드 관리
   - **기능**: 펌웨어 업로드 및 업그레이드
   - **연계 파일**: `FirmwareService.java`, `firmwareUpgrade.fxml`

6. **DisplaySignalSettingController.java** (14KB)
   - **역할**: 디스플레이 신호 설정
   - **기능**: 전광판 표시 신호 제어
   - **연계 파일**: `DisplaySignal.java`, `displaySignalSetting.fxml`

### 2.3. 서비스 클래스 (`src/main/java/dbps/dbps/service/`)

#### **ConfigService.java** (16KB)
- **역할**: 애플리케이션 설정 관리
- **기능**: 
  - 설정 로드, 저장, 업데이트
  - 기본 설정값 제공
- **작동 방식**: 싱글톤 패턴으로 구현
- **연계 파일**: 거의 모든 클래스가 이 서비스를 사용

#### **ResourceManager.java**
- **역할**: 다국어 리소스 관리
- **기능**: 
  - 현재 로케일에 맞는 메시지 번들 제공
  - 언어 변경 지원
- **연계 파일**: 
  - `messages.properties`, `messages_ko.properties`, `messages_en.properties`

#### **통신 관련 서비스**
1. **HexMsgTransceiver.java** (18KB)
   - **역할**: HEX 형식 메시지 송수신
   - **기능**: HEX 메시지 패킷 생성, 송신, 수신 처리
   - **연계 파일**: 통신 관리자 클래스들, `HEXMessageController.java`

2. **AsciiMsgTransceiver.java** (22KB)
   - **역할**: ASCII 형식 메시지 송수신
   - **기능**: ASCII 메시지 패킷 생성, 송신, 수신 처리
   - **연계 파일**: 통신 관리자 클래스들, `ASCiiMsgController.java`

3. **LogService.java** (5.4KB)
   - **역할**: 로그 기록 및 표시
   - **기능**: 애플리케이션 로그 관리
   - **연계 파일**: 대부분의 컨트롤러 및 서비스 클래스

#### **connectManager/ 디렉토리**
1. **SerialPortManager.java** (33KB)
   - **역할**: 시리얼 포트 통신 관리
   - **기능**: 시리얼 포트 열기, 닫기, 데이터 송수신
   - **연계 파일**: `CommunicationSettingController.java`, 메시지 송수신 클래스들

2. **TCPManager.java** (15KB) & **ServerTCPManager.java** (15KB)
   - **역할**: TCP 클라이언트/서버 통신 관리
   - **기능**: TCP 연결 설정, 데이터 송수신
   - **연계 파일**: `CommunicationSettingController.java`, 메시지 송수신 클래스들

3. **UDPManager.java** (28KB)
   - **역할**: UDP 통신 관리
   - **기능**: UDP 소켓 설정, 데이터 송수신
   - **연계 파일**: `CommunicationSettingController.java`, 메시지 송수신 클래스들

4. **BTManager.java** (4.5KB)
   - **역할**: 블루투스 통신 관리
   - **기능**: 블루투스 연결 설정, 데이터 송수신
   - **연계 파일**: `BlueToothController.java`

### 2.4. UI 정의 파일 (`src/main/resources/dbps/dbps/fxmls/`)

1. **main.fxml**: 메인 UI 레이아웃 정의
2. **HEXMessage.fxml**: HEX 메시지 화면 정의
3. **communicationSetting.fxml**: 통신 설정 화면 정의
4. **fontSetting.fxml**: 폰트 설정 화면 정의
5. **dabitNet.fxml**: DABIT 네트워크 설정 화면 정의

### 2.5. 리소스 파일

1. **다국어 지원 파일**:
   - `messages.properties`: 기본 메시지
   - `messages_ko.properties`: 한국어 메시지
   - `messages_en.properties`: 영어 메시지

2. **아이콘 및 이미지**:
   - `icon.ico`, `icon.jpg`, `icon-removebg.ico`: 애플리케이션 아이콘
   - `/dbps/dbps/images/`: 애플리케이션에서 사용되는 이미지 파일들

3. **폰트**:
   - `gulim.ttc`: 한글 폰트 파일

## 3. 주요 기능 흐름

### 3.1. 애플리케이션 시작 및 UI 초기화
1. `Simulator.java`의 `main` 메서드에서 시작
2. `init()` 메서드에서 설정 로드 및 리소스 초기화
3. `start()` 메서드에서 메인 UI 로드 및 표시
4. `MainController` 초기화 및 탭 전환 처리 설정

### 3.2. 통신 설정 및 연결
1. 사용자가 `CommunicationSettingController`를 통해 통신 설정 선택 (시리얼, TCP, UDP, 블루투스)
2. 선택된 통신 방식에 따라 해당 매니저 클래스(SerialPortManager, TCPManager 등) 초기화
3. 연결 설정 후 ConfigService에 설정 저장

### 3.3. 메시지 송수신
1. HEX 또는 ASCII 메시지 컨트롤러를 통해 사용자 메시지 입력
2. 메시지 트랜시버(HexMsgTransceiver 또는 AsciiMsgTransceiver)가 메시지 패킷 생성
3. 연결된 통신 매니저를 통해 메시지 전송
4. 수신된 응답은 다시 트랜시버에서 처리 후 UI에 표시

### 3.4. 전광판 설정
1. 사용자가 디스플레이 관련 설정(폰트, 크기, 신호 등) 조정
2. 설정값이 ConfigService에 저장됨
3. 해당 설정을 포함한 메시지 패킷 생성
4. 통신 매니저를 통해 전광판으로 전송

## 4. 애플리케이션 핵심 특징

1. **MVC 아키텍처**: 컨트롤러-서비스-뷰(FXML) 구조로 구현
2. **싱글톤 패턴**: 서비스 클래스들은 대부분 싱글톤으로 구현됨
3. **다양한 통신 프로토콜**: 시리얼, TCP, UDP, 블루투스 지원
4. **다국어 지원**: 한국어, 영어 지원
5. **동적 UI 전환**: 타입에 따른 UI 동적 로드
6. **비동기 작업 처리**: 백그라운드 작업을 위한 Task 활용

## 5. 확장 및 유지보수

1. **새 통신 프로토콜 추가**: `connectManager` 패키지에 새 매니저 클래스 추가
2. **새 기능 추가**: 새 컨트롤러와 서비스 클래스를 추가하고 메인 UI에 통합
3. **UI 변경**: FXML 파일 수정 및 해당 컨트롤러 업데이트
4. **다국어 지원 확장**: 새 언어의 메시지 파일(`messages_xx.properties`) 추가

## 6. 요약

DBPS Simulator는 전광판과 같은 디스플레이 장치를 제어하고 시뮬레이션하기 위한 복잡한 JavaFX 애플리케이션입니다. 다양한 통신 프로토콜을 지원하고, 사용자 친화적인 UI를 제공하며, 확장성을 고려한 설계를 가지고 있습니다. MVC 아키텍처와 싱글톤 패턴을 활용해 깔끔한 코드 구조를 유지하고 있습니다. 다국어 지원과 다양한 설정 옵션을 통해 다양한 환경에서 사용할 수 있는 유연성을 제공합니다.
