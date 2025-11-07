---
Created_date: 2025-01-21
Last_Modified_date: 2025-01-21
Version: 1.0
Status: Active
Category: reference
Priority: high
tags:
  - reference
  - git
  - cheatsheet
  - quick-reference
---

# Git 빠른 참조 치트시트

> 자주 사용하는 Git 명령어를 빠르게 찾아보는 참조 가이드

---

## 목차

1. [기초 명령어](#기초-명령어)
2. [브랜치 명령어](#브랜치-명령어)
3. [원격 저장소 명령어](#원격-저장소-명령어)
4. [변경사항 확인 명령어](#변경사항-확인-명령어)
5. [상황별 해결 방법](#상황별-해결-방법)
6. [용어 사전](#용어-사전)

---

## 기초 명령어

### 저장소 초기화

```bash
# 현재 폴더를 Git 저장소로 초기화
git init

# 사용자 정보 설정 (최초 1회만)
git config --global user.name "이름"
git config --global user.email "이메일@example.com"
```

### 상태 확인

```bash
# 현재 상태 확인
git status

# 간단한 상태 확인
git status -s

# 변경사항 확인
git diff

# 특정 파일만 확인
git diff 파일명
```

### 스테이징 및 커밋

```bash
# 모든 파일 스테이징
git add .

# 특정 파일만 스테이징
git add 파일명

# 수정된 파일만 스테이징 (새 파일 제외)
git add -u

# 스테이징 취소
git reset HEAD 파일명

# 커밋 생성
git commit -m "커밋 메시지"

# 스테이징과 커밋을 한 번에
git commit -am "커밋 메시지"

# 마지막 커밋 메시지 수정
git commit --amend -m "새 커밋 메시지"
```

### 커밋 이력 확인

```bash
# 커밋 이력 보기
git log

# 간단한 이력 보기
git log --oneline

# 그래프와 함께 보기
git log --oneline --graph

# 특정 파일의 이력
git log 파일명

# 최근 N개 커밋만 보기
git log -n 5
```

---

## 브랜치 명령어

### 브랜치 생성 및 전환

```bash
# 브랜치 목록 확인
git branch

# 새 브랜치 생성 및 전환
git checkout -b 브랜치명

# 또는 (Git 2.23+)
git switch -c 브랜치명

# 브랜치 전환
git checkout 브랜치명
# 또는
git switch 브랜치명

# 이전 브랜치로 돌아가기
git checkout -
```

### 브랜치 병합

```bash
# 메인 브랜치로 전환
git checkout main

# 브랜치 병합
git merge 브랜치명

# 병합 취소 (병합 전)
git merge --abort
```

### 브랜치 삭제

```bash
# 로컬 브랜치 삭제
git branch -d 브랜치명

# 강제 삭제 (병합되지 않은 브랜치)
git branch -D 브랜치명

# 원격 브랜치 삭제
git push origin --delete 브랜치명
```

---

## 원격 저장소 명령어

### 원격 저장소 연결

```bash
# 원격 저장소 추가
git remote add origin https://github.com/사용자명/저장소명.git

# 원격 저장소 확인
git remote -v

# 원격 저장소 이름 변경
git remote rename old new

# 원격 저장소 제거
git remote remove origin
```

### 푸시 및 풀

```bash
# 원격 저장소에 푸시
git push

# 첫 푸시 (브랜치 설정)
git push -u origin main

# 특정 브랜치 푸시
git push origin 브랜치명

# 원격 저장소에서 가져오기 및 병합
git pull

# 원격 저장소 정보만 가져오기 (병합 안 함)
git fetch

# 원격 브랜치 확인
git branch -r

# 모든 브랜치 확인 (로컬 + 원격)
git branch -a
```

---

## 변경사항 확인 명령어

### 파일 상태 확인

```bash
# 현재 상태
git status

# 변경된 파일 목록만
git status -s

# 특정 파일의 변경 내용
git diff 파일명

# 스테이징된 변경 내용
git diff --staged

# 두 커밋 간 차이
git diff 커밋1 커밋2
```

### 커밋 상세 확인

```bash
# 커밋 상세 내용
git show 커밋해시

# 특정 파일의 커밋 이력
git log 파일명

# 커밋의 변경 내용까지
git log -p 파일명

# 작성자별 커밋 통계
git shortlog -sn

# 파일별 변경 통계
git log --stat
```

### 특정 버전 보기

```bash
# 특정 커밋의 파일 내용
git show 커밋해시:파일명

# 이전 버전으로 되돌리기
git checkout 커밋해시 -- 파일명

# 특정 브랜치의 파일 보기
git show 브랜치명:파일명
```

---

## 상황별 해결 방법

### 실수로 파일을 스테이징했을 때

```bash
# 스테이징 취소 (파일은 그대로)
git reset HEAD 파일명

# 모든 스테이징 취소
git reset
```

### 파일 변경사항을 되돌리고 싶을 때

```bash
# 특정 파일 되돌리기 (주의: 저장 안 됨)
git restore 파일명

# 모든 변경사항 되돌리기
git restore .

# 또는
git checkout -- 파일명
```

### 커밋을 취소하고 싶을 때

```bash
# 마지막 커밋 취소 (변경사항 유지)
git reset --soft HEAD~1

# 마지막 커밋 취소 (변경사항도 제거)
git reset --hard HEAD~1

# 여러 커밋 취소
git reset --hard HEAD~3  # 최근 3개 커밋 취소
```

### 커밋 메시지를 수정하고 싶을 때

```bash
# 마지막 커밋 메시지 수정
git commit --amend -m "새 메시지"
```

### 이미 푸시한 커밋을 수정하고 싶을 때

```bash
# 커밋 메시지 수정
git commit --amend -m "새 메시지"

# 강제 푸시 (주의: 다른 사람과 협의 필요)
git push --force
# 또는
git push --force-with-lease  # 더 안전한 방법
```

### 충돌 해결

```bash
# 충돌 발생 시
git status  # 충돌 파일 확인

# 충돌 파일 수정 후
git add 파일명
git commit -m "충돌 해결"
```

### 원격 저장소와 동기화

```bash
# 원격 저장소 정보 가져오기
git fetch

# 원격과 로컬 차이 확인
git log HEAD..origin/main

# 원격 변경사항 병합
git pull

# 또는 단계별로
git fetch
git merge origin/main
```

### 작업 중인 변경사항 임시 저장

```bash
# 현재 작업 임시 저장
git stash

# 임시 저장 목록 확인
git stash list

# 임시 저장 복원
git stash pop

# 임시 저장 삭제
git stash drop
```

---

## 상황별 명령어 조합

### 새 기능 개발 시작

```bash
git checkout main
git pull
git checkout -b feature/기능명
```

### 작업 완료 후 메인에 병합

```bash
git add .
git commit -m "feat: 기능 추가"
git push -u origin feature/기능명
# (GitHub/GitLab에서 Pull Request 생성)
git checkout main
git pull
git merge feature/기능명
git push
```

### 기존 문서 수정

```bash
git add "22_Area/할일관리.md"
git commit -m "docs: 할일관리 문서 업데이트"
git push
```

### 새로 만든 문서 추가

```bash
# 새 문서도 동일하게 처리!
git add "새로_만든_문서.md"
git commit -m "docs: 새 문서 추가"
git push
```

### 수정된 문서와 새 문서 함께 업데이트

```bash
git add "22_Area/할일관리.md" "새로_만든_문서.md"
git commit -m "docs: 할일관리 문서 업데이트 및 새 가이드 추가"
git push
```

### 오늘 작업한 내용 확인

```bash
# 오늘 커밋 확인
git log --since="today" --oneline

# 오늘 변경된 파일
git log --since="today" --name-only

# 오늘 작업한 파일과 변경 줄 수
git log --since="today" --stat
```

### 특정 기간의 변경사항 확인

```bash
# 지난 주
git log --since="1 week ago" --oneline

# 특정 날짜 이후
git log --since="2025-01-01" --oneline

# 특정 날짜 범위
git log --since="2025-01-01" --until="2025-01-31" --oneline
```

---

## 고급 명령어

### 커밋 이력 검색

```bash
# 커밋 메시지로 검색
git log --grep="검색어"

# 파일 내용으로 검색
git log -S "검색어"

# 작성자로 검색
git log --author="이름"
```

### 파일 추적 관리

```bash
# 파일 추적 제거 (파일은 유지)
git rm --cached 파일명

# 파일 삭제 및 추적 제거
git rm 파일명
```

### 태그 관리

```bash
# 태그 생성
git tag v1.0.0

# 태그 목록
git tag

# 태그 푸시
git push origin v1.0.0
```

### 브랜치 정보 확인

```bash
# 브랜치별 최근 커밋
git branch -v

# 병합된 브랜치 확인
git branch --merged

# 병합되지 않은 브랜치 확인
git branch --no-merged
```

---

## 용어 사전

### 저장소 (Repository, Repo)
- Git이 관리하는 프로젝트 폴더
- `.git` 폴더가 있는 디렉토리

### 커밋 (Commit)
- 변경사항의 스냅샷
- 프로젝트의 특정 시점을 기록

### 브랜치 (Branch)
- 독립적인 작업 공간
- 메인 코드와 분리하여 개발 가능

### 스테이징 (Staging)
- 커밋에 포함시킬 파일을 선택하는 과정
- `git add` 명령어로 수행

### 푸시 (Push)
- 로컬 저장소의 변경사항을 원격 저장소에 업로드

### 풀 (Pull)
- 원격 저장소의 변경사항을 가져와서 병합

### 병합 (Merge)
- 두 브랜치의 변경사항을 합치는 과정

### 충돌 (Conflict)
- 같은 파일의 같은 부분을 두 브랜치에서 수정했을 때 발생
- 수동으로 해결해야 함

### 원격 저장소 (Remote Repository)
- GitHub, GitLab 같은 온라인 저장소
- 백업 및 협업에 사용

### HEAD
- 현재 작업 중인 브랜치의 최신 커밋을 가리키는 포인터

### 체크아웃 (Checkout)
- 브랜치나 커밋으로 전환하는 과정

### 스태시 (Stash)
- 작업 중인 변경사항을 임시 저장
- 나중에 다시 불러올 수 있음

---

## 자주 사용하는 명령어 TOP 10

1. **`git status`** - 현재 상태 확인
2. **`git add .`** - 모든 변경사항 스테이징
3. **`git commit -m "메시지"`** - 커밋 생성
4. **`git push`** - 원격 저장소에 업로드
5. **`git pull`** - 원격 저장소에서 가져오기
6. **`git log --oneline`** - 커밋 이력 확인
7. **`git checkout -b 브랜치명`** - 새 브랜치 생성
8. **`git checkout 브랜치명`** - 브랜치 전환
9. **`git merge 브랜치명`** - 브랜치 병합
10. **`git diff`** - 변경사항 확인

---

## 빠른 참조 표

| 작업 | 명령어 |
|------|--------|
| 상태 확인 | `git status` |
| 변경사항 확인 | `git diff` |
| 스테이징 | `git add 파일명` |
| 커밋 | `git commit -m "메시지"` |
| 푸시 | `git push` |
| 풀 | `git pull` |
| 브랜치 생성 | `git checkout -b 브랜치명` |
| 브랜치 전환 | `git checkout 브랜치명` |
| 브랜치 병합 | `git merge 브랜치명` |
| 커밋 이력 | `git log --oneline` |
| 변경사항 취소 | `git restore 파일명` |
| 커밋 취소 | `git reset --soft HEAD~1` |

---

## 다음 단계

더 자세한 내용은 다음 문서들을 참고하세요:

1. **[Git 버전관리 완전 가이드](Git_버전관리_완전가이드.md)** - 기초 개념 설명
2. **[Git 실전 워크플로우](Git_실전_워크플로우.md)** - 실제 작업 방법
3. **[마크다운 문서 버전관리 전략](마크다운_문서_버전관리_전략.md)** - 문서 관리 방법

---

## 팁

- **명령어 자동완성**: Git은 명령어 자동완성을 지원합니다
- **별칭(Alias) 설정**: 자주 사용하는 명령어를 짧게 만들 수 있습니다
  ```bash
  git config --global alias.st status
  git config --global alias.co checkout
  git config --global alias.br branch
  ```
  이후 `git st`로 `git status`를 실행할 수 있습니다.

- **도움말 보기**: 명령어 뒤에 `--help`를 붙이면 자세한 도움말을 볼 수 있습니다
  ```bash
  git commit --help
  ```

---

## 요약

이 치트시트는 가장 자주 사용하는 Git 명령어를 모아놓은 것입니다. 처음에는 자주 참고하다 보면 자연스럽게 익숙해집니다!

**가장 중요한 것:**
- `git status` - 무엇이 변경되었는지 확인
- `git add` - 커밋할 파일 선택
- `git commit` - 변경사항 저장
- `git push` - 원격 저장소에 업로드

이 4가지 명령어만 알아도 기본적인 버전관리는 가능합니다!

