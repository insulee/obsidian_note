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
  - utf-8
  - setup
---

# Git 한글 인코딩 설정 가이드

> 이 저장소를 다른 컴퓨터에서 clone 했을 때 한글 커밋 메시지가 깨지지 않도록 설정하는 방법

---

## 문제 상황

Windows PowerShell에서 Git 커밋 메시지에 한글을 사용하면 깨져서 표시되는 경우가 있습니다.

**원인:**
- PowerShell의 기본 인코딩이 CP949 (EUC-KR)
- Git의 기본 인코딩이 UTF-8
- 인코딩 불일치로 인한 문제

---

## 해결 방법

### 1단계: 저장소 클론 후 설정 적용

이 저장소를 clone한 후, 다음 명령어를 실행하세요:

```powershell
# 저장소 폴더로 이동
cd "저장소_경로"

# Git 인코딩 설정 (저장소별)
git config --local i18n.commitEncoding utf-8
git config --local i18n.logOutputEncoding utf-8
git config --local core.quotepath false
git config --local gui.encoding utf-8
```

### 2단계: PowerShell 인코딩 설정 (현재 세션)

```powershell
# 현재 PowerShell 세션에만 적용
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
```

### 3단계: PowerShell 인코딩 영구 설정 (선택사항)

모든 PowerShell 세션에서 자동으로 UTF-8을 사용하려면:

```powershell
# 1. PowerShell 프로필 경로 확인
$PROFILE

# 2. 프로필 파일 열기 (없으면 자동 생성)
if (!(Test-Path $PROFILE)) {
    New-Item -Path $PROFILE -Type File -Force
}
notepad $PROFILE

# 3. 다음 내용 추가:
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
```

---

## 설정 확인

설정이 제대로 적용되었는지 확인:

```powershell
# Git 설정 확인
git config --local --list | Select-String "i18n|quotepath"

# 출력 예시:
# i18n.commitencoding=utf-8
# i18n.logoutputencoding=utf-8
# core.quotepath=false
```

---

## 테스트

설정 후 테스트 커밋:

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

---

## .gitattributes 파일

이 저장소에는 `.gitattributes` 파일이 포함되어 있어 모든 텍스트 파일이 UTF-8로 처리됩니다.

**주요 내용:**
- 모든 마크다운 파일: UTF-8 인코딩
- 모든 텍스트 파일: UTF-8 인코딩
- 이미지/PDF: 바이너리로 처리

이 파일은 저장소에 커밋되어 있으므로, 다른 컴퓨터에서 clone해도 자동으로 적용됩니다.

---

## Windows Terminal 사용 권장

Windows Terminal을 사용하면 인코딩 문제가 거의 발생하지 않습니다.

1. Microsoft Store에서 "Windows Terminal" 설치
2. Windows Terminal에서 PowerShell 실행
3. 위의 Git 설정만 적용하면 됨

---

## 문제 해결

### 문제: 여전히 한글이 깨짐

**해결책 1: PowerShell 재시작**
```powershell
# PowerShell을 완전히 종료하고 다시 시작
```

**해결책 2: Git 설정 재확인**
```powershell
git config --local --list
```

**해결책 3: Windows Terminal 사용**
- Windows Terminal은 기본적으로 UTF-8을 지원합니다

**해결책 4: 커밋 메시지를 파일로 작성**
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

## 참고사항

- `--local` 설정은 현재 저장소에만 적용됩니다
- 다른 저장소에서도 동일한 설정을 원하면 각 저장소마다 위 설정을 반복해야 합니다
- 또는 `--global` 설정을 사용하면 모든 저장소에 적용되지만, 저장소별로 다를 수 있습니다

---

## 요약

1. ✅ 저장소 clone 후 `git config --local` 명령어 실행
2. ✅ PowerShell 인코딩 설정 (현재 세션 또는 영구)
3. ✅ `.gitattributes` 파일이 자동으로 적용됨
4. ✅ 테스트 커밋으로 확인

이제 한글 커밋 메시지가 깨지지 않습니다! 🎉

