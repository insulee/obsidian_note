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
  - workflow
  - tutorial
  - practical
---

# Git 실전 워크플로우

> Git을 실제로 사용하는 방법을 단계별로 안내하는 실전 가이드

---

## 목차

1. [Git 저장소 초기화](#git-저장소-초기화)
2. [첫 커밋하기](#첫-커밋하기)
3. [일상적인 작업 흐름](#일상적인-작업-흐름)
4. [커밋 메시지 작성 가이드](#커밋-메시지-작성-가이드)
5. [브랜치 생성 및 전환](#브랜치-생성-및-전환)
6. [브랜치 병합](#브랜치-병합)
7. [충돌 해결하기](#충돌-해결하기)
8. [원격 저장소 연결](#원격-저장소-연결)
9. [마크다운 문서 변경사항 관리](#마크다운-문서-변경사항-관리)

---

## Git 저장소 초기화

### 1단계: Git 설치 확인

먼저 Git이 설치되어 있는지 확인합니다:

```bash
git --version
```

설치되어 있지 않다면 [Git 공식 웹사이트](https://git-scm.com/downloads)에서 다운로드하세요.

### 2단계: 사용자 정보 설정 (최초 1회만)

```bash
# 이름 설정
git config --global user.name "홍길동"

# 이메일 설정
git config --global user.email "hong@example.com"
```

이 정보는 모든 커밋에 기록됩니다.

### 3단계: 프로젝트 폴더에서 Git 초기화

프로젝트 폴더로 이동한 후:

```bash
cd "D:\Note\20_Marketing_Team"
git init
```

이 명령어는 `.git` 폴더를 생성하여 Git 저장소를 초기화합니다.

**중요**: 처음에는 전체 폴더를 한 번에 커밋하는 것이 일반적입니다. 이후에는 수정하거나 새로 만든 파일만 커밋하면 됩니다.

### 4단계: .gitignore 파일 확인

`.gitignore` 파일이 있는지 확인하세요. 이 파일은 Git이 추적하지 않을 파일들을 지정합니다.

---

## 첫 커밋하기

### 1단계: 현재 상태 확인

```bash
git status
```

출력 예시:
```
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        21_Project/
        22_Area/
        20_Inbox/
        ...
```

**주의**: `.gitignore` 파일에 설정된 파일들은 표시되지 않습니다 (예: `.obsidian/` 폴더).

### 2단계: 모든 파일 스테이징

```bash
# 모든 파일을 스테이징 영역에 추가
git add .
```

또는 특정 폴더나 파일만 추가:
```bash
git add "20_Inbox/git/"
git add "22_Area/할일관리.md"
```

**팁**: 첫 커밋은 보통 전체 폴더를 한 번에 추가합니다 (`git add .`).

### 3단계: 첫 커밋 생성

```bash
git commit -m "프로젝트 초기 설정 및 Git 가이드 문서 추가"
```

### 4단계: 커밋 확인

```bash
git log
```

출력 예시:
```
commit abc123def456... (HEAD -> main)
Author: 홍길동 <hong@example.com>
Date: Mon Jan 21 2025 10:00:00 +0900

    프로젝트 초기 설정 및 Git 가이드 문서 추가
```

**축하합니다! 첫 커밋이 완료되었습니다!** 🎉

---

## 일상적인 작업 흐름

### 기본 워크플로우 (매일 반복)

```
1. 작업 시작 전: 최신 버전 가져오기 (git pull)
2. 파일 수정 (코드 또는 문서)
3. 변경사항 확인 (git status)
4. 스테이징 (git add)
5. 커밋 (git commit)
6. 푸시 (git push)
```

### 상세 단계별 가이드

#### 1단계: 작업 시작 전 최신 버전 가져오기

```bash
# 원격 저장소의 최신 변경사항 가져오기
git pull
```

**중요**: 다른 컴퓨터에서 작업했거나 팀원이 변경사항을 푸시했다면 반드시 먼저 `git pull`을 실행하세요!

#### 2단계: 파일 수정 또는 새 파일 생성

문서를 수정하거나 새 문서를 만듭니다.

**예시:**
- `22_Area/할일관리.md` 문서 수정
- `22_Area/21_공유자산/업체관리_가이드.md` 문서 업데이트
- `새로_만든_문서.md` 새 문서 작성

**중요**: 새로 만든 문서도 수정된 문서와 동일하게 처리합니다!

#### 3단계: 변경사항 확인

```bash
git status
```

출력 예시:
```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   22_Area/할일관리.md
        modified:   22_Area/21_공유자산/업체관리_가이드.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        새로_만든_문서.md
```

**주의사항:**
- `modified:`는 수정된 파일
- `Untracked files:`는 새로 만든 파일
- **둘 다 동일하게 `git add`로 처리하면 됩니다**

#### 4단계: 변경 내용 상세 확인 (선택사항)

```bash
# 변경된 내용을 확인 (수정된 파일만)
git diff

# 특정 파일만 확인
git diff "22_Area/할일관리.md"

# 새 파일은 git diff로 확인할 수 없음 (아직 추적되지 않음)
# 새 파일은 git status로 확인
```

#### 5단계: 스테이징

**방법 1: 모든 변경사항 스테이징**
```bash
git add .
```

**방법 2: 특정 파일만 스테이징**
```bash
# 수정된 파일 스테이징
git add "22_Area/할일관리.md"

# 새로 만든 파일도 스테이징 (처리 방법 동일!)
git add "새로_만든_문서.md"

# 여러 파일 동시에
git add "22_Area/할일관리.md" "새로_만든_문서.md"
```

**방법 3: 수정된 파일만 스테이징 (새 파일 제외)**
```bash
git add -u
```

#### 6단계: 커밋

```bash
# 수정된 문서만 커밋
git commit -m "docs: 할일관리 문서 업데이트"

# 새로 만든 문서 커밋
git commit -m "docs: 새 문서 추가"

# 수정된 문서와 새 문서를 함께 커밋
git commit -m "docs: 할일관리 문서 업데이트 및 새 가이드 문서 추가"
```

좋은 커밋 메시지 작성 방법은 아래 섹션을 참고하세요.

#### 7단계: 푸시 (원격 저장소가 있는 경우)

```bash
git push
```

처음 푸시하는 경우:
```bash
git push -u origin main
```

---

## 커밋 메시지 작성 가이드

### 좋은 커밋 메시지의 특징

1. **명확하고 간결함**
2. **무엇을 했는지 명시**
3. **왜 변경했는지 설명 (필요시)**

### 커밋 메시지 형식

```
<타입>: <간단한 설명>

<상세 설명 (선택사항)>
```

### 타입 종류

- `feat`: 새 기능 추가
- `fix`: 버그 수정
- `docs`: 문서 수정
- `style`: 코드 포맷팅 (기능 변경 없음)
- `refactor`: 코드 리팩토링
- `test`: 테스트 추가/수정
- `chore`: 빌드 설정, 패키지 관리 등

### 좋은 예시

```bash
# ✅ 좋은 예시
git commit -m "docs: 제품 설치 매뉴얼 업데이트"
git commit -m "docs: 사용자 가이드 오타 수정"
git commit -m "docs: 새 기능 가이드 문서 추가"
git commit -m "docs: FAQ 문서 전면 개정

- 사용자 피드백 반영
- 새로운 질문 섹션 추가
- 답변 내용 보강"
```

### 나쁜 예시

```bash
# ❌ 나쁜 예시
git commit -m "수정"
git commit -m "업데이트"
git commit -m "asdf"
git commit -m "버그 수정 및 기능 추가 및 문서 업데이트"
```

### 제품 문서 관리 시스템 예시

```bash
# 기존 문서 수정
git commit -m "docs: 사용자 가이드 설치 섹션 개선"

# 새 문서 추가
git commit -m "docs: 고급 기능 가이드 문서 추가"

# 여러 문서 함께 변경
git commit -m "docs: 제품 매뉴얼 업데이트 및 FAQ 추가

- 사용자 가이드에 새 기능 섹션 추가
- 설치 매뉴얼 오타 수정
- FAQ 문서에 자주 묻는 질문 추가"
```

**새로 만든 문서 처리:**
```bash
# 새 문서 작성 후
git add "새_문서.md"
git commit -m "docs: 새 문서 추가"
# 또는 기존 문서와 함께
git add "수정된_문서.md" "새_문서.md"
git commit -m "docs: 문서 업데이트 및 새 문서 추가"
```

---

## 브랜치 생성 및 전환

### 새 브랜치 생성

```bash
# 새 브랜치 생성 및 전환
git checkout -b feature/new-feature

# 또는 (Git 2.23+)
git switch -c feature/new-feature
```

### 브랜치 목록 확인

```bash
# 로컬 브랜치 목록
git branch

# 원격 브랜치 포함
git branch -a
```

### 브랜치 전환

```bash
# 다른 브랜치로 전환
git checkout main

# 또는
git switch main
```

### 브랜치 삭제

```bash
# 로컬 브랜치 삭제
git branch -d feature/old-feature

# 강제 삭제 (병합되지 않은 브랜치)
git branch -D feature/old-feature
```

### 실제 예시: 새 문서 작성하기

```bash
# 1. 메인 브랜치에서 시작
git checkout main
git pull  # 최신 버전 가져오기

# 2. 새 문서 작업 브랜치 생성
git checkout -b docs/new-product-guide

# 3. 작업 수행
# - 새 문서 작성
# - 관련 기존 문서 업데이트
git add .
git commit -m "docs: 새 제품 가이드 문서 추가 및 관련 문서 업데이트"

# 4. 원격 저장소에 푸시
git push -u origin docs/new-product-guide
```

---

## 브랜치 병합

### 기본 병합 방법

```bash
# 1. 메인 브랜치로 전환
git checkout main

# 2. 최신 버전 가져오기
git pull

# 3. 병합할 브랜치 병합
git merge feature/new-feature

# 4. 병합된 내용 푸시
git push
```

### 병합 커밋 메시지

병합 시 기본 메시지가 나타나면 `:wq`를 눌러 저장하거나 (Vim), `Ctrl+X` (Nano)를 눌러 저장하세요.

### 병합 취소 (병합 전으로 되돌리기)

```bash
# 병합을 아직 커밋하지 않은 경우
git merge --abort

# 이미 커밋한 경우
git reset --hard HEAD~1
```

### 실제 예시: 문서 작업 완료 후 병합

```bash
# docs/new-product-guide 브랜치에서 작업 완료

# 1. 메인 브랜치로 전환
git checkout main
git pull

# 2. 문서 브랜치 병합
git merge docs/new-product-guide

# 3. 병합 확인
git log --oneline --graph

# 4. 원격 저장소에 반영
git push

# 5. (선택사항) 병합된 브랜치 삭제
git branch -d docs/new-product-guide
git push origin --delete docs/new-product-guide
```

---

## 충돌 해결하기

### 충돌이 발생하는 경우

두 브랜치에서 같은 파일의 같은 부분을 수정했을 때 발생합니다.

### 충돌 해결 과정

#### 1단계: 충돌 발생 확인

```bash
git merge feature/other-branch
```

출력 예시:
```
Auto-merging chatbot.py
CONFLICT (content): Merge conflict in chatbot.py
Automatic merge failed; fix conflicts and then commit the result.
```

#### 2단계: 충돌 파일 확인

```bash
git status
```

#### 3단계: 충돌 파일 열기

충돌이 발생한 파일을 열어보면 다음과 같은 표시가 있습니다:

```markdown
<<<<<<< HEAD
# 현재 브랜치의 내용
## 제품 설치 방법
제품을 설치하세요.
=======
# 병합하려는 브랜치의 내용
## 제품 설치 방법
제품 설치 방법을 아래 단계별로 따라하세요.
>>>>>>> docs/other-branch
```

#### 4단계: 충돌 해결

원하는 내용을 선택하고 충돌 표시를 제거합니다:

```markdown
# 해결된 내용
## 제품 설치 방법
제품 설치 방법을 아래 단계별로 따라하세요.
```

#### 5단계: 해결된 파일 스테이징

```bash
git add "사용자_가이드.md"
```

#### 6단계: 병합 커밋 완료

```bash
git commit -m "Merge branch 'feature/other-branch' into main"
```

### 충돌 해결 도구 사용

복잡한 충돌의 경우 GUI 도구를 사용할 수 있습니다:

- **VS Code**: 내장 Git 도구
- **SourceTree**: 무료 Git GUI
- **GitKraken**: 고급 기능 제공

### 충돌 예방 팁

1. **작업 전 항상 `git pull`**: 최신 버전 가져오기
2. **작은 단위로 자주 커밋**: 충돌 범위 최소화
3. **팀원과 소통**: 같은 파일 작업 전 확인

---

## 원격 저장소 연결

### GitHub에 저장소 생성

1. [GitHub](https://github.com)에 로그인
2. "New repository" 클릭
3. 저장소 이름 입력 (예: `marketing-team-docs`)
4. "Create repository" 클릭

### 로컬 저장소를 원격 저장소에 연결

```bash
# 원격 저장소 추가
git remote add origin https://github.com/사용자명/marketing-team-docs.git

# 원격 저장소 확인
git remote -v
```

### 첫 푸시

```bash
# 메인 브랜치를 원격 저장소에 푸시
git push -u origin main
```

이후부터는 `git push`만 입력하면 됩니다.

### 원격 저장소에서 가져오기

```bash
# 원격 저장소의 변경사항 가져오기 및 병합
git pull

# 또는 단계별로
git fetch          # 원격 저장소 정보 가져오기
git merge origin/main  # 로컬 브랜치에 병합
```

### 원격 저장소 정보 확인

```bash
# 원격 저장소 목록
git remote -v

# 원격 브랜치 확인
git branch -r
```

---

## 마크다운 문서 변경사항 관리

### 문서도 코드와 동일하게 관리

마크다운 문서는 코드 파일과 동일한 방식으로 관리합니다:

```bash
# 기존 문서 수정 후
git add "22_Area/할일관리.md"
git commit -m "docs: 할일관리 문서 업데이트"
git push

# 새로 만든 문서도 동일하게
git add "새_문서.md"
git commit -m "docs: 새 문서 추가"
git push
```

**핵심**: 수정된 문서든 새로 만든 문서든 `git add` → `git commit` → `git push` 순서는 동일합니다!

### 문서 변경 이력 확인

```bash
# 특정 문서의 변경 이력
git log "22_Area/할일관리.md"

# 변경 내용 확인
git log -p "22_Area/할일관리.md"
```

### 문서의 이전 버전 보기

```bash
# 특정 커밋의 문서 내용 보기
git show 커밋해시:"22_Area/할일관리.md"

# 이전 버전으로 되돌리기
git checkout 커밋해시 -- "22_Area/할일관리.md"
```

### 문서 관련 작업 예시

#### 예시 1: 기존 문서 수정

```bash
git status
# 22_Area/할일관리.md (수정됨)

git add "22_Area/할일관리.md"
git commit -m "docs: 할일관리 문서 업데이트"
git push
```

#### 예시 2: 새로 만든 문서 추가

```bash
git status
# 새로_만든_문서.md (Untracked files)

# 새 문서도 동일하게 처리!
git add "새로_만든_문서.md"
git commit -m "docs: 새 문서 추가"
git push
```

#### 예시 3: 수정된 문서와 새 문서 함께 커밋

```bash
# 수정된 문서와 새 문서를 함께
git add "22_Area/할일관리.md" "새로_만든_문서.md"
git commit -m "docs: 할일관리 문서 업데이트 및 새 가이드 추가"
git push
```

#### 예시 4: 문서 리뷰를 위한 브랜치

```bash
# 문서 작업 전용 브랜치
git checkout -b docs/user-guide-update

# 문서 수정 및 새 문서 추가
git add "사용자_가이드.md" "새_FAQ.md"
git commit -m "docs: 사용자 가이드 전면 개정 및 FAQ 추가"
git push -u origin docs/user-guide-update

# 리뷰 후 메인에 병합
git checkout main
git merge docs/user-guide-update
git push
```

---

## 자주 발생하는 상황별 해결 방법

### 1. 실수로 잘못된 파일을 스테이징했을 때

```bash
# 스테이징 영역에서 제거 (파일은 그대로 유지)
git reset HEAD 파일명

# 모든 파일 제거
git reset
```

### 2. 커밋 메시지를 잘못 입력했을 때

```bash
# 마지막 커밋 메시지 수정
git commit --amend -m "올바른 커밋 메시지"
```

### 3. 파일을 수정했는데 되돌리고 싶을 때

```bash
# 변경사항 취소 (주의: 저장되지 않은 변경사항은 사라집니다)
git restore 파일명

# 모든 변경사항 취소
git restore .
```

### 4. 커밋을 되돌리고 싶을 때

```bash
# 마지막 커밋 취소 (변경사항은 유지)
git reset --soft HEAD~1

# 마지막 커밋 취소 (변경사항도 제거)
git reset --hard HEAD~1
```

### 5. 원격 저장소와 로컬 저장소가 달라졌을 때

```bash
# 원격 저장소의 최신 정보 가져오기
git fetch

# 로컬과 원격의 차이 확인
git log HEAD..origin/main

# 원격 저장소의 변경사항 병합
git pull
```

---

## 다음 단계

이제 Git을 실전에서 사용할 수 있습니다! 다음 문서들을 참고하세요:

1. **[마크다운 문서 버전관리 전략](마크다운_문서_버전관리_전략.md)** - 문서 관리 전문 가이드
2. **[Git 빠른 참조 치트시트](Git_빠른참조_치트시트.md)** - 자주 사용하는 명령어 모음

---

## 요약

**일상적인 작업 흐름:**
1. `git pull` - 최신 버전 가져오기
2. 파일 수정
3. `git status` - 변경사항 확인
4. `git add` - 스테이징
5. `git commit` - 커밋
6. `git push` - 원격 저장소에 업로드

**브랜치 작업:**
- `git checkout -b 브랜치명` - 새 브랜치 생성
- `git merge 브랜치명` - 브랜치 병합

**문서 관리:**
- 코드와 동일한 방식으로 관리
- 문서 변경 이력 추적 가능

