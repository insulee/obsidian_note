---
Created_date: 2025-01-21
Last_Modified_date: 2025-01-21
Version: 2.0
Status: Active
Category: guide
Priority: high
tags:
  - guide
  - git
  - encoding
  - utf-8
  - powershell
  - 한글
  - 완전해결
---

# Git 한글 인코딩 완전 해결 가이드

> Windows PowerShell에서 Git 커밋 메시지와 로그 출력 시 한글이 깨지는 문제를 완전히 해결하는 종합 가이드

---

## 문제 상황

Windows PowerShell에서 Git을 사용할 때 다음과 같은 문제가 발생합니다:

1. **커밋 메시지 한글 깨짐**: `git commit -m "한글"` 사용 시 깨짐
2. **로그 출력 한글 깨짐**: `git log` 출력 시 한글이 깨짐
3. **변수에 담을 때 깨짐**: `$log = git log` 후 출력 시 깨짐

**원인:**
- PowerShell의 기본 인코딩이 CP949 (EUC-KR)
- Git의 기본 인코딩이 UTF-8
- Windows 콘솔 코드 페이지 불일치

---

## 종합 해결 방법

### 방법 1: 자동 설정 스크립트 사용 (권장)

저장소 루트에서 다음 스크립트를 실행:

```powershell
.\setup-git-encoding.ps1
```

이 스크립트는 다음을 자동으로 설정합니다:
- Git 인코딩 설정 (저장소별)
- PowerShell 인코딩 설정 (현재 세션)

---

### 방법 2: 수동 설정 (저장소별)

#### 1단계: Git 인코딩 설정

```powershell
# 저장소 폴더로 이동
cd "저장소_경로"

# Git 전역 설정 (모든 저장소에 적용) - Gemini 심층 리서치 권장
git config --global i18n.commitEncoding utf-8
git config --global i18n.logOutputEncoding utf-8
git config --global core.quotepath false

# Git 저장소별 설정 (현재 저장소에만 적용)
git config --local i18n.commitEncoding utf-8
git config --local i18n.logOutputEncoding utf-8
git config --local core.quotepath false
git config --local gui.encoding utf-8
```

**참고:** 
- `--global`: 모든 저장소에 적용 (전체 시스템) - 권장
- `--local`: 현재 저장소에만 적용 (특정 저장소별 설정)
- Gemini 심층 리서치: 전역 설정을 먼저 적용하고, 필요시 저장소별로 오버라이드

#### 2단계: PowerShell 인코딩 설정 (현재 세션)

```powershell
# UTF-8 인코딩 객체 정의 (BOM 없는 UTF-8 보장, Gemini 심층 리서치 권장)
$utf8 = New-Object System.Text.UTF8Encoding $false

# PowerShell 콘솔 I/O 인코딩 설정 (입력/출력 모두)
[Console]::InputEncoding = $utf8
[Console]::OutputEncoding = $utf8

# PowerShell 외부 프로세스 통신 인코딩 설정
$OutputEncoding = $utf8

# 파일 출력 인코딩 설정 (Out-File, Set-Content 등)
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# 코드 페이지를 UTF-8로 변경 (콘솔 호스트 레벨)
chcp 65001 | Out-Null

# Git/Unix 유틸리티 환경 변수 설정
$env:LC_ALL = 'C.UTF-8'

# Git log 페이저 (less)의 문자셋 설정 (필수!)
$env:LESSCHARSET = 'UTF-8'
```

**중요 변경사항 (Gemini 심층 리서치 반영):**
- `[Console]::InputEncoding` 추가: 입력 인코딩도 UTF-8로 설정
- `New-Object System.Text.UTF8Encoding $false`: BOM 없는 UTF-8 인코딩 객체 사용
- `$env:LESSCHARSET`: Git의 less 페이저가 UTF-8 출력을 올바르게 표시하도록 필수 설정

---

### 방법 3: 영구 설정 (PowerShell 프로필)

PowerShell을 재시작해도 유지하려면 프로필에 추가:

#### 1단계: 프로필 경로 확인

```powershell
$profile
```

출력 예시:
```
C:\Users\사용자명\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
```

#### 2단계: 프로필 파일 열기 (없으면 생성)

```powershell
# 파일이 없으면 생성
if (!(Test-Path $profile)) {
    New-Item -Path $profile -Type File -Force
}

# 파일 열기
notepad $profile
```

#### 3단계: 다음 내용 추가 (Gemini 심층 리서치 완전 버전)

```powershell
# Git 한글 인코딩 설정 (자동 생성)
# 이 설정은 PowerShell이 시작될 때마다 자동으로 적용됩니다

# UTF-8 인코딩 객체 정의 (BOM 없는 UTF-8)
$utf8 = New-Object System.Text.UTF8Encoding $false

# PowerShell 콘솔 I/O 인코딩 설정 (입력/출력 모두)
[Console]::InputEncoding = $utf8
[Console]::OutputEncoding = $utf8

# PowerShell 외부 프로세스 통신 인코딩 설정
$OutputEncoding = $utf8

# 파일 출력 인코딩 설정
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# 콘솔 액티브 코드 페이지를 UTF-8로 설정
chcp 65001 | Out-Null

# Git/Unix 유틸리티 환경 변수
$env:LC_ALL = 'C.UTF-8'
$env:LESSCHARSET = 'UTF-8'
```

**설정 설명 (Gemini 심층 리서치 기반):**
- `$utf8 = New-Object System.Text.UTF8Encoding $false`: BOM 없는 UTF-8 인코딩 객체 생성 (일관성 보장)
- `[Console]::InputEncoding`: 콘솔 입력 인코딩 설정 (필수 추가!)
- `[Console]::OutputEncoding`: 콘솔 출력 인코딩 (변수에 담을 때도 깨지지 않음)
- `$OutputEncoding`: PowerShell 외부 프로세스 통신 인코딩
- `$PSDefaultParameterValues['Out-File:Encoding']`: 파일 출력 인코딩 (Out-File, Set-Content 등)
- `chcp 65001`: 콘솔 호스트 레벨의 액티브 코드 페이지를 UTF-8로 변경
- `$env:LC_ALL`: Git 내부의 Unix 로케일 설정 강제
- `$env:LESSCHARSET`: Git의 less 페이저가 UTF-8 출력을 올바르게 표시하도록 필수!

#### 4단계: PowerShell 재시작

프로필을 저장한 후 PowerShell을 재시작하면 자동으로 적용됩니다.

---

### 방법 4: VS Code/Cursor 터미널 설정 (추가 권장)

VS Code나 Cursor를 사용하는 경우, 통합 터미널 인코딩도 확인하세요:

#### 1단계: 설정 열기

1. **파일(File)** > **기본 설정(Preferences)** > **설정(Settings)** (또는 `Ctrl + ,`)
2. 검색창에 `terminal.integrated.encoding` 입력

#### 2단계: 인코딩 설정 확인 및 변경

- **Windows 프로필**에서 `utf8` 또는 `UTF-8`로 설정되어 있는지 확인
- 설정되어 있지 않다면 `utf8`로 설정

**설정 파일 직접 편집 (선택사항):**

```json
// settings.json
{
  "terminal.integrated.encoding": "utf8"
}
```

이 설정은 VS Code/Cursor의 통합 터미널에서 한글 출력을 개선합니다.

---

## 설정 확인

### Git 설정 확인

```powershell
git config --local --list | Select-String "i18n|quotepath|gui"
```

출력 예시:
```
core.quotepath=false
i18n.commitencoding=utf-8
i18n.logoutputencoding=utf-8
gui.encoding=utf-8
```

### PowerShell 인코딩 확인

```powershell
[Console]::OutputEncoding
$OutputEncoding
chcp
```

출력 예시:
```
BodyName          : utf-8
EncodingName      : Unicode (UTF-8)
CodePage          : 65001
```

---

## 테스트

### 1. 커밋 메시지 테스트

```powershell
# 테스트 파일 생성
echo "# 테스트" > test.md

# 스테이징
git add test.md

# 한글 커밋 메시지로 커밋
git commit -m "테스트: 한글 커밋 메시지"

# 로그 확인 (한글이 제대로 보여야 함)
git log --oneline -1

# 테스트 파일 삭제
git rm test.md
git commit -m "테스트 파일 제거"
```

### 2. 변수에 담아서 출력 테스트

```powershell
# 로그를 변수에 담기
$log = git log --oneline -5

# 변수 출력 (한글이 깨지지 않아야 함)
$log
```

---

## 참고 자료

이 가이드는 다음 블로그들을 종합하여 작성되었습니다:

1. **PowerShell 한글 깨짐 해결** (https://holjjack.tistory.com/144)
   - `$env:LC_ALL='C.UTF-8'` 환경 변수 설정
   - `[System.Console]::OutputEncoding` 설정 (변수에 담을 때도 깨지지 않음)

2. **Git GUI 인코딩 설정** (https://bbogle2.tistory.com/entry/git-%EA%B9%83-%EC%BB%A4%EB%B0%8B-%EC%8B%9C-%EC%A3%BC%EC%84%9D-%EC%9D%B8%EC%BD%94%EB%94%A9-%EA%B9%A8%EC%A7%88-%EB%95%8C-%ED%95%B4%EA%B2%B0%EB%B2%95)
   - `gui.encoding=utf-8` 설정 추가

3. **PowerShell 프로필 영구 설정** (https://hbase.tistory.com/364)
   - PowerShell 프로필에 `$env:LC_ALL='C.UTF-8'` 추가

4. **Git 전역 인코딩 설정** (https://daily1313.tistory.com/entry/git-git-commit-message-%ED%95%9C%EA%B8%80-%EA%B9%A8%EC%A7%90-%ED%98%84%EC%83%81-%ED%95%B4%EA%B2%B0)
   - `--global` 옵션 사용 시 전체 시스템에 적용

---

## 설정 비교

### 저장소별 설정 (--local) - 권장

```powershell
git config --local i18n.commitEncoding utf-8
git config --local i18n.logOutputEncoding utf-8
```

**장점:**
- 각 프로젝트별로 다른 설정 가능
- 팀 프로젝트에서 설정 충돌 방지
- 저장소별로 다른 인코딩 필요 시 유연함

**단점:**
- 각 저장소마다 설정해야 함

### 전역 설정 (--global)

```powershell
git config --global i18n.commitEncoding utf-8
git config --global i18n.logOutputEncoding utf-8
```

**장점:**
- 한 번 설정하면 모든 저장소에 적용
- 편리함

**단점:**
- 모든 저장소에 강제 적용
- 팀 프로젝트에서 충돌 가능

---

## 문제 해결

### 문제 1: 여전히 한글이 깨짐

**해결책:**

1. **PowerShell 재시작**
   ```powershell
   # PowerShell을 완전히 종료하고 다시 시작
   ```

2. **프로필 확인**
   ```powershell
   # 프로필이 제대로 로드되었는지 확인
   Get-Content $profile
   ```

3. **설정 재확인**
   ```powershell
   git config --local --list
   ```

4. **Windows Terminal 사용**
   - Windows Terminal은 기본적으로 UTF-8을 잘 지원합니다
   - Microsoft Store에서 설치 가능

### 문제 2: PowerShell 프로필이 적용되지 않음

**해결책:**

1. **실행 정책 확인**
   ```powershell
   Get-ExecutionPolicy
   ```

2. **실행 정책 변경 (필요시)**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

### 문제 3: 커밋 메시지를 파일로 작성해야 함

**해결책:**

```powershell
# UTF-8로 메시지 파일 생성
$message = "docs: 한글 커밋 메시지"
[System.IO.File]::WriteAllText("commit_msg.txt", $message, [System.Text.Encoding]::UTF8)

# 파일로 커밋
git commit -F commit_msg.txt

# 파일 삭제
Remove-Item commit_msg.txt
```

---

## 요약 체크리스트

### 최초 설정 (저장소별)

- [ ] Git 인코딩 설정 (`--local`)
  - [ ] `i18n.commitEncoding=utf-8`
  - [ ] `i18n.logOutputEncoding=utf-8`
  - [ ] `core.quotepath=false`
  - [ ] `gui.encoding=utf-8`

- [ ] PowerShell 인코딩 설정 (현재 세션)
  - [ ] `$env:LC_ALL='C.UTF-8'`
  - [ ] `[System.Console]::OutputEncoding = UTF8`
  - [ ] `$OutputEncoding = UTF8`
  - [ ] `$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'`
  - [ ] `chcp 65001`
- [ ] VS Code/Cursor 터미널 설정 (선택사항)
  - [ ] `terminal.integrated.encoding` 설정 확인

### 영구 설정 (선택사항)

- [ ] PowerShell 프로필 설정
  - [ ] 프로필 파일 생성/편집
  - [ ] 인코딩 설정 추가
  - [ ] PowerShell 재시작

### 테스트

- [ ] 한글 커밋 메시지 테스트
- [ ] 로그 출력 확인
- [ ] 변수에 담아서 출력 확인

---

## 결론

**가장 완벽한 해결 방법:**

1. ✅ Git 저장소별 인코딩 설정 (`--local`)
2. ✅ PowerShell 프로필에 영구 인코딩 설정 추가
3. ✅ Windows Terminal 사용 (권장)

이렇게 설정하면 PowerShell을 재시작해도 한글이 깨지지 않습니다!

---

## 관련 파일

- `setup-git-encoding.ps1`: 자동 설정 스크립트
- `.gitattributes`: 파일 인코딩 자동 처리
- `Git_인코딩_설정_가이드.md`: 기본 설정 가이드

