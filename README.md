# 20_Marketing_Team 저장소

이 저장소는 마크다운 문서와 관련 파일들을 버전 관리합니다.

## 초기 설정

### 1. 저장소 Clone

```powershell
git clone <저장소_URL>
cd 20_Marketing_Team
```

### 2. Git 한글 인코딩 설정

**중요**: 이 저장소를 사용하기 전에 반드시 인코딩 설정을 실행하세요!

```powershell
# 자동 설정 스크립트 실행
.\setup-git-encoding.ps1
```

또는 수동으로 설정:

```powershell
git config --local i18n.commitEncoding utf-8
git config --local i18n.logOutputEncoding utf-8
git config --local core.quotepath false

# PowerShell 인코딩 설정 (현재 세션)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
```

### 3. 설정 확인

```powershell
git config --local --list | Select-String "i18n|quotepath"
```

자세한 설정 방법은 [`20_Inbox/git/Git_인코딩_설정_가이드.md`](20_Inbox/git/Git_인코딩_설정_가이드.md)를 참고하세요.

## 포함되는 파일

- `.md` 파일 (마크다운 문서)
- 이미지 파일 (`.png`, `.jpg`, `.jpeg`, `.gif`, `.svg`)
- PDF 파일 (`.pdf`)

## 제외되는 파일

- 비디오 파일 (용량이 크므로)
- 비밀번호가 포함된 파일

## Git 사용 가이드

Git 사용 방법은 `20_Inbox/git/` 폴더의 가이드를 참고하세요:

- [`Git_버전관리_완전가이드.md`](20_Inbox/git/Git_버전관리_완전가이드.md)
- [`Git_실전_워크플로우.md`](20_Inbox/git/Git_실전_워크플로우.md)
- [`Git_빠른참조_치트시트.md`](20_Inbox/git/Git_빠른참조_치트시트.md)
- [`마크다운_문서_버전관리_전략.md`](20_Inbox/git/마크다운_문서_버전관리_전략.md)

