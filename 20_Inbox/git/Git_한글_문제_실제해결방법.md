---
Created_date: 2025-01-21
Last_Modified_date: 2025-01-21
Version: 1.0
Status: Active
Category: guide
Priority: high
tags:
  - guide
  - git
  - encoding
  - troubleshooting
  - real-solution
---

# Git 한글 문제 실제 해결 방법

> 솔직한 현실과 가장 확실한 해결책

---

## 현실적인 문제

Windows PowerShell에서 Git 한글 인코딩 문제는 **완전히 해결하기 어렵습니다**.

**이유:**
1. PowerShell 콘솔 자체의 인코딩 한계
2. Windows 콘솔 코드 페이지 문제
3. 폰트 문제
4. 설정이 세션마다 초기화됨

---

## 가장 확실한 해결책

### 방법 1: Windows Terminal 사용 (가장 권장)

**왜?**
- Windows Terminal은 기본적으로 UTF-8을 잘 지원
- PowerShell 설정 없이도 한글이 잘 표시됨
- 현대적이고 안정적

**설치:**
1. Microsoft Store에서 "Windows Terminal" 검색
2. 설치 후 PowerShell 실행

**장점:**
- 설정이 거의 필요 없음
- 자동으로 UTF-8 지원
- 여러 터미널 통합 관리

### 방법 2: Git Bash 사용

**왜?**
- Git과 함께 설치되는 Bash 환경
- 리눅스/맥과 동일한 환경
- 한글 문제가 거의 없음

**사용:**
```bash
# Git Bash 실행 후
git commit -m "한글 커밋 메시지"
git log
```

**장점:**
- Git 전용 환경
- 크로스 플랫폼 호환성
- 한글 문제 거의 없음

### 방법 3: VS Code 통합 터미널 사용

**왜?**
- VS Code의 통합 터미널은 UTF-8 지원이 좋음
- Git GUI와 터미널 통합

**사용:**
1. VS Code에서 터미널 열기 (Ctrl + `)
2. Git 명령어 실행

---

## PowerShell에서 꼭 써야 한다면

### 최소 설정 (매번 실행)

```powershell
# PowerShell 시작할 때마다 실행
$env:LC_ALL='C.UTF-8'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# Git 설정 확인
git config --local i18n.logOutputEncoding utf-8
```

### 영구 설정 (프로필에 추가)

```powershell
# 1. 프로필 확인
$profile

# 2. 프로필 열기
notepad $profile

# 3. 다음 추가
$env:LC_ALL='C.UTF-8'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null
```

**주의:** 
- PowerShell을 재시작해야 적용
- 여전히 완벽하지 않을 수 있음

---

## 실제 저장 확인 방법

PowerShell에서 출력이 깨져도 **실제로는 UTF-8로 저장되었을 수 있습니다**.

### 확인 방법 1: GitHub에서 확인

1. 커밋 후 GitHub에 push
2. GitHub 웹사이트에서 커밋 메시지 확인
3. 한글이 제대로 보이면 → 저장은 정상, 출력만 깨진 것

### 확인 방법 2: 파일로 저장해서 확인

```powershell
# 로그를 UTF-8 파일로 저장
git log -1 --format="%B" | Out-File -Encoding UTF8 log.txt

# 메모장이나 VS Code로 열어서 확인
notepad log.txt
```

### 확인 방법 3: Git Bash에서 확인

```bash
# Git Bash 실행
git log --oneline -5
```

---

## 권장 워크플로우

### 개발자별 권장도구

1. **Windows Terminal + PowerShell** (가장 권장)
   - 현대적이고 안정적
   - 설정 거의 필요 없음

2. **VS Code 통합 터미널**
   - 코딩 중이라면 가장 편리
   - Git GUI와 통합

3. **Git Bash**
   - Git 전용이라 가장 확실
   - 크로스 플랫폼 호환

4. **PowerShell (마지막 선택지)**
   - 프로필 설정 필수
   - 여전히 문제 있을 수 있음

---

## 결론

**가장 확실한 해결책:**

1. ✅ **Windows Terminal 사용** (가장 권장)
2. ✅ **Git Bash 사용** (확실함)
3. ✅ **VS Code 통합 터미널** (편리함)
4. ⚠️ **PowerShell + 프로필 설정** (마지막 선택지)

**중요:**
- PowerShell 콘솔 출력이 깨져도 **GitHub에서는 정상**일 수 있음
- 실제 저장 데이터는 UTF-8로 되어 있을 가능성이 높음
- 출력 문제와 저장 문제는 별개

**권장:**
- Windows Terminal 사용하면 대부분의 문제가 해결됨
- 또는 GitHub에서 확인하는 것이 가장 확실함

---

## 참고

- PowerShell 한글 문제는 Windows의 구조적 문제
- 완벽한 해결은 어렵지만, Windows Terminal 사용으로 대부분 해결
- 저장소에는 UTF-8로 저장되므로 GitHub에서는 정상 표시

