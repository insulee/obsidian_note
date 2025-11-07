# Git UTF-8 커밋 메시지 사용법

> PowerShell에서 한글 커밋 메시지가 깨지는 문제를 해결하는 간편한 방법

## 업데이트 내역
- 2025-01-21: 문서 초기 작성

---

## 현재 설정 상태

**현재는 특정 ps1 파일을 참고하지 않습니다.**  
테스트에서 사용한 방법은 **임시로 직접 코드를 실행**한 것입니다.

---

## 해결 방법: 간편한 함수 사용

매번 긴 코드를 입력할 필요 없이, **간단한 함수**를 사용할 수 있습니다.

### 방법 1: PowerShell 함수 사용 (권장) ⭐

**설정:**
```powershell
# 한 번만 실행 (프로필에 자동 추가됨)
.\setup-git-commit-utf8.ps1
```

**사용법:**
```powershell
# 기본 사용
git-commit-utf8 "docs: 한글 커밋 메시지"

# 짧은 별칭 사용 (gcm)
gcm "fix: 버그 수정"

# 커밋 메시지 수정
git-commit-utf8 "docs: 커밋 메시지 수정" -Amend
```

**장점:**
- ✅ 간단하고 편리함
- ✅ 프로필에 저장되어 영구 사용 가능
- ✅ 매번 긴 코드 입력 불필요

---

### 방법 2: 스크립트 파일 사용

**사용법:**
```powershell
.\git-commit-utf8.ps1 -Message "docs: 한글 커밋 메시지"
```

**장점:**
- ✅ 스크립트 파일로 관리 가능
- ✅ 다른 프로젝트에서도 사용 가능

---

### 방법 3: 직접 코드 사용 (비권장)

매번 다음 코드를 입력해야 합니다:

```powershell
$commitMsgFile = Join-Path $env:TEMP "git_commit_msg_$(Get-Date -Format 'yyyyMMddHHmmss').txt"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($commitMsgFile, "커밋 메시지", $utf8NoBom)
git commit -F $commitMsgFile
Remove-Item $commitMsgFile -Force -ErrorAction SilentlyContinue
```

**단점:**
- ❌ 매번 긴 코드 입력 필요
- ❌ 실수하기 쉬움

---

## 권장 워크플로우

### 1단계: 초기 설정 (한 번만)

```powershell
# 프로필에 함수 추가
.\setup-git-commit-utf8.ps1
```

### 2단계: PowerShell 재시작 또는 프로필 로드

```powershell
# 현재 세션에 적용
. $profile
```

### 3단계: 일상적인 사용

```powershell
# 파일 스테이징
git add .

# UTF-8 커밋 (간단!)
git-commit-utf8 "docs: 문서 업데이트"

# 또는 짧게
gcm "fix: 버그 수정"
```

---

## 함수가 작동하지 않을 때

### 프로필 확인
```powershell
# 프로필 경로 확인
$profile

# 프로필 내용 확인
Get-Content $profile -Encoding UTF8
```

### 수동으로 함수 정의
```powershell
function git-commit-utf8 {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [switch]$Amend
    )
    $commitMsgFile = Join-Path $env:TEMP "git_commit_msg_$(Get-Date -Format 'yyyyMMddHHmmss').txt"
    try {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($commitMsgFile, $Message, $utf8NoBom)
        if ($Amend) {
            git commit --amend -F $commitMsgFile
        } else {
            git commit -F $commitMsgFile
        }
    }
    finally {
        if (Test-Path $commitMsgFile) {
            Remove-Item $commitMsgFile -Force -ErrorAction SilentlyContinue
        }
    }
}
```

---

## 비교: 방법별 사용 예시

### ❌ 기존 방법 (깨짐)
```powershell
git commit -m "한글 커밋 메시지"  # 한글이 깨짐!
```

### ✅ 방법 1: 함수 사용 (권장)
```powershell
git-commit-utf8 "한글 커밋 메시지"  # 간단하고 확실!
```

### ✅ 방법 2: 스크립트 사용
```powershell
.\git-commit-utf8.ps1 -Message "한글 커밋 메시지"
```

### ✅ 방법 3: 직접 코드 (비권장)
```powershell
# 긴 코드 입력...
```

---

## 요약

**현재 상태:**
- 특정 ps1 파일을 참고하지 않음
- 테스트 시 임시로 코드 직접 실행

**권장 방법:**
1. ✅ `setup-git-commit-utf8.ps1` 실행 (한 번만)
2. ✅ `git-commit-utf8 "메시지"` 또는 `gcm "메시지"` 사용
3. ✅ 매번 긴 코드 입력 불필요!

**결론:**
- **함수 방식**이 가장 편리하고 권장됩니다.
- 한 번 설정하면 `git-commit-utf8 "메시지"`만 입력하면 됩니다!

