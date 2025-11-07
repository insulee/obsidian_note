# USB로 UTF-8 설정 적용하기

**목적**: Git 저장소 없는 다른 컴퓨터에서 USB 메모리로 한글 깨짐 해결  
**대상**: 홈 노트북, 회사 다른 PC 등

---

## 📋 준비물

- ✅ USB 메모리
- ✅ 설정 스크립트 1개 파일

---

## 💾 USB 준비 (회사 데스크톱에서)

### 방법 1: 범용 스크립트만 복사 (권장)

```powershell
# 1. USB 메모리 연결 (예: E:\)

# 2. 스크립트 복사
Copy-Item "D:\Gitea\Firmware\Controller\scripts\setup_utf8_anywhere.ps1" -Destination "E:\"

# 끝!
```

**USB에 복사된 것:**
- `E:\setup_utf8_anywhere.ps1` (단 1개 파일!)

---

### 방법 2: 전체 스크립트 + Hook 복사 (Git 저장소용)

Git 저장소가 있는 컴퓨터라면:

```powershell
# USB 메모리에 폴더 생성
New-Item -ItemType Directory -Path "E:\firmware_utf8_fix" -Force

# 필요한 파일들 복사
Copy-Item "D:\Gitea\Firmware\Controller\scripts\setup_utf8_anywhere.ps1" -Destination "E:\firmware_utf8_fix\"
Copy-Item "D:\Gitea\Firmware\Controller\git_hooks\*" -Destination "E:\firmware_utf8_fix\git_hooks\" -Recurse
```

**USB에 복사된 것:**
```
E:\firmware_utf8_fix\
├── setup_utf8_anywhere.ps1
└── git_hooks\
    ├── commit-msg
    └── commit-msg.ps1
```

---

## 🖥️ 다른 컴퓨터에서 적용

### 시나리오 1: Git 저장소 없는 컴퓨터

```powershell
# 1. USB에서 스크립트 실행
E:\setup_utf8_anywhere.ps1 -SkipGitHook
```

**설정되는 것:**
- ✅ Git 전역 UTF-8 설정
- ✅ PowerShell 프로필 UTF-8 설정
- ✅ 현재 세션 UTF-8 적용
- ⏭️ Git hook 건너뜀

**충분한 경우:**
- 일반적인 Git 사용
- 간단한 커밋

---

### 시나리오 2: Git 저장소 있는 컴퓨터 (Firmware 아님)

```powershell
# 1. Git 저장소로 이동
cd C:\Projects\MyProject

# 2. USB에서 스크립트 실행
E:\setup_utf8_anywhere.ps1

# 또는 Git hook만 수동 설치
Copy-Item "E:\firmware_utf8_fix\git_hooks\*" -Destination ".git\hooks\" -Force
```

**설정되는 것:**
- ✅ Git 전역 UTF-8 설정
- ✅ PowerShell 프로필 UTF-8
- ✅ commit-msg hook 설치 (자동)

---

### 시나리오 3: Firmware 저장소 있는 컴퓨터 (홈 노트북)

**홈 노트북이라면 git pull 사용 권장:**

```powershell
# 방법 A: Git 사용 (권장)
cd <Firmware 경로>
git pull
.\Controller\scripts\setup_utf8_encoding.ps1

# 방법 B: USB 사용 (Git 없을 때)
E:\setup_utf8_anywhere.ps1
```

---

## 🔧 스크립트 기능

### setup_utf8_anywhere.ps1이 하는 일

**자동 설정:**
1. **Git 전역 설정**
   - `i18n.commit.encoding=utf-8`
   - `core.quotepath=false`

2. **PowerShell 프로필**
   - UTF-8 인코딩 자동 로드 코드 추가
   - 중복 확인하여 추가

3. **Git commit-msg Hook** (Git 저장소 발견 시)
   - 자동으로 `.git/hooks/` 찾기
   - commit-msg.ps1 및 래퍼 생성
   - 모든 커밋 시 UTF-8 자동 변환

4. **현재 세션 즉시 적용**
   - 스크립트 실행 즉시 UTF-8 사용 가능

**스마트 기능:**
- 🔍 자동으로 Git 저장소 탐지
- 🔍 PowerShell 프로필 중복 방지
- 🔍 경로 자동 탐지
- ⚠️ 오류 발생해도 계속 진행

---

## ✅ 체크리스트

### USB 준비 (회사 PC)

- [ ] USB 메모리 연결
- [ ] `setup_utf8_anywhere.ps1` 복사
- [ ] (선택) `git_hooks` 폴더도 복사

### 다른 컴퓨터에서 적용

- [ ] USB 연결
- [ ] PowerShell 관리자 권한 실행
- [ ] 스크립트 실행
- [ ] Cursor 재시작
- [ ] 테스트 커밋
- [ ] git log로 한글 확인

---

## 🎯 각 컴퓨터별 권장 방법

### 홈 노트북 (Firmware 저장소 있음)

**최선:**
```powershell
git pull
.\Controller\scripts\setup_utf8_encoding.ps1
```

**차선 (네트워크 없을 때):**
```powershell
E:\setup_utf8_anywhere.ps1
```

---

### 회사 다른 PC (Firmware 저장소 없음)

**Git 저장소 있음:**
```powershell
cd <해당 저장소>
E:\setup_utf8_anywhere.ps1
```

**Git 저장소 없음:**
```powershell
E:\setup_utf8_anywhere.ps1 -SkipGitHook
```

---

### 완전히 새로운 PC

**1단계: Git 설치**
```powershell
winget install Git.Git
```

**2단계: USB 스크립트 실행**
```powershell
E:\setup_utf8_anywhere.ps1 -SkipGitHook
```

**3단계: Git 저장소 클론 시**
```powershell
git clone ...
cd <저장소>
E:\setup_utf8_anywhere.ps1  # Hook 다시 설치
```

---

## ⚠️ 주의사항

### Git 저장소 자동 탐지

스크립트는 자동으로 Git 저장소를 탐지하지만:

- ✅ Git 저장소 **내부**에서 실행 → Hook 자동 설치
- ℹ️ Git 저장소 **외부**에서 실행 → Hook 건너뜀

### 여러 저장소가 있는 경우

**각 저장소마다 실행:**
```powershell
cd C:\Projects\Project1
E:\setup_utf8_anywhere.ps1

cd C:\Projects\Project2
E:\setup_utf8_anywhere.ps1
```

### PowerShell 프로필은 1번만

PowerShell 프로필은 **사용자 전역**이므로:
- 첫 번째 실행에서 설정됨
- 이후 실행에서는 "이미 존재" 메시지

---

## 🔄 업데이트 방법

### 스크립트 업데이트가 필요한 경우

**회사 PC에서 최신 버전 복사:**
```powershell
# 최신 코드 받기
git pull

# USB에 복사
Copy-Item "Controller\scripts\setup_utf8_anywhere.ps1" -Destination "E:\" -Force
```

---

## 💡 문제 해결

### "스크립트 실행이 차단되었습니다"

```powershell
# PowerShell 실행 정책 확인
Get-ExecutionPolicy

# 현재 세션만 허용
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# 또는 직접 실행
powershell.exe -ExecutionPolicy Bypass -File E:\setup_utf8_anywhere.ps1
```

### "Git을 찾을 수 없습니다"

```powershell
# Git 설치 확인
git --version

# 없으면 설치
winget install Git.Git
```

### 설정 후에도 한글 깨짐

```powershell
# 1. Cursor 완전 재시작 (필수!)
# 2. 새 PowerShell 창 열기
# 3. 인코딩 확인
echo $OutputEncoding
# 출력: Unicode (UTF-8) 이어야 함

# 4. Git 설정 확인
git config --get i18n.commit.encoding
# 출력: utf-8 이어야 함
```

---

## 📊 비교

### Git Pull vs USB

| 항목 | Git Pull | USB 메모리 |
|------|----------|-----------|
| **속도** | 빠름 | 중간 |
| **최신 버전** | 항상 최신 | 복사 시점 |
| **필요 조건** | 네트워크 + Git | USB만 |
| **Git 저장소** | 필요 | 불필요 |
| **권장 대상** | Firmware 프로젝트 | 다른 프로젝트 |

**결론:**
- Firmware 프로젝트 → `git pull` 사용
- 다른 프로젝트/컴퓨터 → USB 사용

---

## 예시

### 예시 1: 홈 노트북 (Firmware 있음)

```powershell
# 홈 노트북에서
cd D:\Projects\Firmware

# Git pull 사용 (권장)
git pull
.\Controller\scripts\setup_utf8_encoding.ps1

# Cursor 재시작
```

---

### 예시 2: 회사 노트북 (Firmware 없음)

```powershell
# USB 연결 (E:\)

# 다른 프로젝트에서
cd C:\Work\OtherProject

# USB 스크립트 실행
E:\setup_utf8_anywhere.ps1

# Cursor 재시작
```

---

### 예시 3: 집 데스크톱 (Git 없음)

```powershell
# Git만 사용하는 경우
E:\setup_utf8_anywhere.ps1 -SkipGitHook

# 나중에 Git 저장소 생성 시
cd C:\MyRepo
E:\setup_utf8_anywhere.ps1  # Hook 설치
```

---

## 🎉 결론

### USB로 가능한 것

- ✅ 한 번만 복사하면 여러 컴퓨터에 적용 가능
- ✅ 네트워크 없이도 설정 가능
- ✅ Git 저장소 유무와 상관없이 작동
- ✅ 자동으로 환경 감지하여 적용

### 편리함

**회사 PC에서 USB 준비:**
```powershell
Copy-Item "Controller\scripts\setup_utf8_anywhere.ps1" -Destination "E:\"
```

**어디서든 사용:**
```powershell
E:\setup_utf8_anywhere.ps1
```

**끝!** 🚀

---

**작성일**: 2025년 11월 6일  
**관련 문서**: `doc/UTF-8-인코딩-해결-보고서.md`

