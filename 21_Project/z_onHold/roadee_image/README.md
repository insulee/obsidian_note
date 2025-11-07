# DB300eMqtt 이미지 업로드 도구

이 프로그램은 DB300eMqtt 장치에 이미지를 업로드하고 스케줄을 관리하는 도구입니다.

## 빠른 실행 방법

1. `run_app.bat` 파일을 더블클릭하여 프로그램을 실행합니다.
   - 필요한 라이브러리(PIL/Pillow, paho-mqtt)가 자동으로 설치됩니다.

## 배포 파일 생성 방법

### Windows

1. `build_exe.bat` 파일을 더블클릭합니다.
2. 빌드가 완료되면 `dist` 폴더에 `DB300eMqtt_Uploader.exe` 파일이 생성됩니다.

### macOS/Linux

1. 터미널에서 프로젝트 폴더로 이동합니다.
2. `chmod +x build.sh` 명령으로 빌드 스크립트에 실행 권한을 부여합니다.
3. `./build.sh` 명령으로 빌드 스크립트를 실행합니다.
4. 빌드가 완료되면 `dist` 폴더에 `DB300eMqtt_Uploader` 실행 파일이 생성됩니다.

### 수동 빌드 (모든 OS)

다음 명령어를 사용하여 직접 빌드할 수도 있습니다:

```bash
# 필요한 패키지 설치
python -m pip install pyinstaller pillow paho-mqtt

# Windows에서 빌드
python -m PyInstaller --onefile --windowed --name="DB300eMqtt_Uploader" --add-data="db300emqtt_uploader_config.json;." main.py

# macOS/Linux에서 빌드
python -m PyInstaller --onefile --windowed --name="DB300eMqtt_Uploader" --add-data="db300emqtt_uploader_config.json:." main.py
```

## 배포 관련 중요 정보

### 배포용 파일 (최종 사용자에게 제공할 파일)

최종 사용자에게는 다음 파일만 배포하면 됩니다:

1. **실행 파일 (필수)**

   - Windows: `dist` 폴더의 `DB300eMqtt_Uploader.exe`
   - macOS/Linux: `dist` 폴더의 `DB300eMqtt_Uploader`

2. **설정 파일 (선택사항)**
   - `db300emqtt_uploader_config.json` (기존 설정을 유지하려는 경우)

### 배포용이 아닌 파일 (개발/빌드 용도)

다음 파일들은 개발 및 빌드 과정에만 사용되며, 최종 사용자에게 배포하지 않습니다:

- `build_exe.bat` - 실행 파일 빌드 스크립트 (Windows)
- `build.sh` - 실행 파일 빌드 스크립트 (macOS/Linux)
- `run_app.bat` - 개발 중 프로그램 실행 스크립트
- 소스 코드 파일들 (`main.py` 등)
- `build` 및 `__pycache__` 폴더

## 실행 파일 배포 방법

1. `dist` 폴더의 `DB300eMqtt_Uploader.exe`(Windows) 또는 `DB300eMqtt_Uploader`(macOS/Linux) 파일을 복사합니다.
2. 설정 파일(`db300emqtt_uploader_config.json`)을 함께 제공하면 기존 설정을 유지할 수 있습니다.
3. 이미지 업로드 도구를 사용할 컴퓨터에서 실행 파일을 더블클릭하면 됩니다.

## 주요 기능

- 이미지 파일 업로드 (BMP 8비트 그레이스케일 이미지 지원)
- 스케줄 관리 (목록 조회, 삭제)
- 장치 제어 (재부팅, 초기화)
- 수동 커밋 (deploy)

## 참고사항

- 이미지 크기는 최대 96×32 픽셀로 제한됩니다.
- 스케줄은 최대 10개까지 등록 가능합니다.
- 기본 MQTT 브로커 주소는 192.168.1.58입니다.
- 기본 MQTT 사용자명/비밀번호는 dabit/dabit입니다.

## 시스템 요구사항

- **Windows**: Windows 7 이상
- **macOS**: macOS 10.13 이상
- **Linux**: 대부분의 현대 Linux 배포판 지원

## 문제 해결

빌드 중 문제가 발생하면 다음을 확인해 보세요:

1. Python 3.6 이상이 설치되어 있는지 확인합니다.
2. pip가 최신 버전인지 확인합니다.
3. 필요한 라이브러리(pyinstaller, pillow, paho-mqtt)가 설치되어 있는지 확인합니다.

==============================================================

## 구현된 내용 요약

성공적으로 Roadee 서버의 기본 인프라 구조를 구축했습니다:

1. 설정 시스템 (config/settings.py)

- 환경별 설정 관리

- 사용자 설정 파일 지원

- 중첩된 설정 옵션 처리

- 환경 변수를 통한 설정 오버라이드

1. 로깅 시스템 (utils/logger.py)

- 표준 Python 로깅 시스템 활용

- 콘솔 및 파일 로깅 지원

- 설정에 따른 로그 레벨 조정

- 순환 참조 문제 해결

1. 예외 처리 시스템 (utils/exceptions.py, utils/error_handler.py)

- 표준화된 예외 클래스 계층 구조

- 예외 처리를 위한 데코레이터 및 컨텍스트 매니저

- 일관된 로깅 및 오류 처리

1. 설정 관리자 (utils/config_manager.py)

- 설정 파일 로드 및 저장

- 점 표기법을 사용한 중첩 설정 접근

- 기본 설정 생성 기능

1. 메인 애플리케이션 (main.py)

- 초기화 로직

- 오류 처리 및 로깅 설정

- 필요한 디렉토리 생성

이제 이 기본 인프라 위에 다음과 같은 기능들을 구현할 수 있습니다:

1. MQTT 클라이언트 (이미 기본 구조가 있음)

2. UI 컴포넌트 및 뷰

3. 이미지 관리 시스템

4. 스케줄링 서비스

프로젝트의 기본 구조는 잘 설계되어 있으며, 확장성과 유지보수가 용이한 방식으로 구현되었습니다. 특히 로거와 예외 처리 시스템은 다양한 상황에서 일관된 오류 처리를 가능하게 합니다.
