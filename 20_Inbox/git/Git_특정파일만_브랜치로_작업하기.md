# Git: 특정 파일만 브랜치로 작업하기

> 여러 파일이 변경되어 있을 때, 특정 파일만 선택해서 브랜치로 작업하는 방법

---

## 문제 상황

작업 중인 파일이 여러 개인데, 특정 파일만 브랜치로 작업하고 싶을 때:

```
변경된 파일들:
- 20_Inbox/견적문의 폼 초안.md  ← 이 파일만 브랜치로 작업
- 22_Area/20_업무노트/2025-11-25(화).md  ← 이건 나중에 처리
- 기타 파일들...
```

---

## 해결 방법

### 방법 1: 작업 전에 변경사항 커밋하기 (권장)

**원칙: 작업 시작 전에 작업 디렉토리를 깨끗하게 유지**

```bash
# 1. 현재 변경사항 확인
git status

# 2. 브랜치로 작업할 파일이 아닌 것들을 먼저 커밋
git add "22_Area/20_업무노트/2025-11-25(화).md"
git commit -m "docs: 업무노트 업데이트"

# 3. 이제 작업 디렉토리가 깨끗해짐
git status  # 변경사항 없음 확인

# 4. 새 브랜치 생성 및 전환
git checkout -b docs/견적문의폼-업데이트

# 5. 원하는 파일만 수정
# 6. 커밋
git add "20_Inbox/견적문의 폼 초안.md"
git commit -m "docs: 견적문의 폼 초안 업데이트"
```

### 방법 2: Stash 사용하기

**변경사항을 임시 저장하고 나중에 복구**

```bash
# 1. 현재 변경사항 확인
git status

# 2. 모든 변경사항을 임시 저장 (stash)
git stash push -m "작업 중인 다른 파일들 임시 저장"

# 3. 작업 디렉토리가 깨끗해짐
git status  # 변경사항 없음

# 4. 새 브랜치 생성 및 전환
git checkout -b docs/견적문의폼-업데이트

# 5. 원하는 파일만 수정
# 6. 커밋
git add "20_Inbox/견적문의 폼 초안.md"
git commit -m "docs: 견적문의 폼 초안 업데이트"

# 7. 작업 완료 후 메인으로 돌아가서 stash 복구
git checkout main
git stash pop  # 또는 git stash apply
```

### 방법 3: 특정 파일만 스테이징하기

**브랜치를 만든 후, 원하는 파일만 선택해서 커밋**

```bash
# 1. 현재 변경사항 확인
git status

# 2. 새 브랜치 생성 및 전환
git checkout -b docs/견적문의폼-업데이트

# 3. 원하는 파일만 스테이징 (다른 파일은 제외)
git add "20_Inbox/견적문의 폼 초안.md"

# 4. 커밋 (스테이징한 파일만 커밋됨)
git commit -m "docs: 견적문의 폼 초안 업데이트"

# 5. 다른 파일들은 그대로 남아있음
git status
# 22_Area/20_업무노트/2025-11-25(화).md  ← 아직 변경사항으로 남아있음
```

**주의:** 이 방법은 브랜치에 다른 파일의 변경사항도 포함되지만, 커밋은 하지 않았으므로 나중에 메인 브랜치로 돌아가서 별도로 처리할 수 있습니다.

---

## 실전 예시: 견적문의 폼만 브랜치로 작업하기

### 시나리오

```
현재 변경사항:
- 20_Inbox/견적문의 폼 초안.md  ← 브랜치로 작업
- 22_Area/20_업무노트/2025-11-25(화).md  ← 나중에 처리
- 기타 파일들...
```

### 올바른 작업 순서

#### 1단계: 다른 파일들 먼저 처리

```bash
# 메인 브랜치에서
git checkout main

# 견적문의 폼이 아닌 파일들 먼저 커밋
git add "22_Area/20_업무노트/2025-11-25(화).md"
git commit -m "docs: 업무노트 업데이트"

# 기타 파일들도 커밋
git add .
git commit -m "chore: 기타 파일 업데이트"
```

#### 2단계: 작업 디렉토리 깨끗하게 만들기

```bash
# 변경사항 확인
git status
# 출력: "nothing to commit, working tree clean" ← 깨끗함!
```

#### 3단계: 새 브랜치 생성 및 작업

```bash
# 새 브랜치 생성
git checkout -b docs/견적문의폼-업데이트

# 견적문의 폼 파일만 수정
# (에디터에서 파일 수정)

# 커밋
git add "20_Inbox/견적문의 폼 초안.md"
git commit -m "docs: 견적문의 폼 초안 업데이트"
```

#### 4단계: 병합

```bash
# 메인으로 돌아가기
git checkout main

# 병합
git merge --no-ff docs/견적문의폼-업데이트
```

---

## Stash 사용 상세 가이드

### Stash란?

**임시 저장소**: 작업 중인 변경사항을 임시로 저장하고 나중에 복구할 수 있는 기능

### Stash 사용법

```bash
# 1. 현재 변경사항을 stash에 저장
git stash push -m "작업 중인 파일들 임시 저장"

# 2. stash 목록 확인
git stash list

# 3. stash 복구 (stash에서 제거)
git stash pop

# 4. stash 복구 (stash 유지)
git stash apply

# 5. 특정 stash 삭제
git stash drop stash@{0}

# 6. 모든 stash 삭제
git stash clear
```

### Stash 사용 예시

```bash
# 현재 여러 파일이 변경되어 있음
git status
# - 20_Inbox/견적문의 폼 초안.md (수정됨)
# - 22_Area/20_업무노트/2025-11-25(화).md (수정됨)

# 모든 변경사항 임시 저장
git stash push -m "견적문의 폼 작업 전 임시 저장"

# 작업 디렉토리 깨끗해짐
git status
# 출력: "nothing to commit, working tree clean"

# 새 브랜치 생성 및 작업
git checkout -b docs/견적문의폼-업데이트
# 파일 수정
git add "20_Inbox/견적문의 폼 초안.md"
git commit -m "docs: 견적문의 폼 초안 업데이트"

# 메인으로 돌아가서 stash 복구
git checkout main
git stash pop
# 22_Area/20_업무노트/2025-11-25(화).md 파일이 다시 나타남
```

---

## 실수했을 때 복구하기

### 상황: 브랜치에 원하지 않는 파일도 포함됨

```bash
# 1. 브랜치에서 원하지 않는 파일 제거
git reset HEAD~1  # 마지막 커밋 취소 (변경사항은 유지)

# 2. 원하는 파일만 다시 스테이징
git add "20_Inbox/견적문의 폼 초안.md"

# 3. 다시 커밋
git commit -m "docs: 견적문의 폼 초안 업데이트"

# 4. 다른 파일들은 그대로 남아있음 (나중에 처리)
```

### 상황: 이미 커밋했는데 다른 파일도 포함됨

```bash
# 1. 마지막 커밋 취소 (변경사항은 유지)
git reset --soft HEAD~1

# 2. 원하는 파일만 스테이징
git reset HEAD  # 모든 파일 스테이징 해제
git add "20_Inbox/견적문의 폼 초안.md"  # 원하는 파일만

# 3. 다시 커밋
git commit -m "docs: 견적문의 폼 초안 업데이트"
```

---

## 체크리스트

### 브랜치 작업 시작 전

- [ ] 현재 변경사항 확인 (`git status`)
- [ ] 브랜치로 작업할 파일과 그렇지 않은 파일 구분
- [ ] 다른 파일들 먼저 커밋하거나 stash에 저장
- [ ] 작업 디렉토리가 깨끗한지 확인

### 브랜치 작업 중

- [ ] 원하는 파일만 수정
- [ ] 원하는 파일만 스테이징 (`git add 특정파일`)
- [ ] 커밋 전에 스테이징된 파일 확인 (`git status`)

### 브랜치 작업 후

- [ ] 메인 브랜치로 돌아가기
- [ ] stash가 있다면 복구
- [ ] 다른 파일들 별도로 처리

---

## 요약

### 핵심 원칙

1. **작업 시작 전에 작업 디렉토리를 깨끗하게 유지**
2. **브랜치로 작업할 파일과 그렇지 않은 파일을 명확히 구분**
3. **특정 파일만 스테이징하여 커밋**

### 권장 워크플로우

```bash
# 1. 다른 파일들 먼저 처리
git add 다른파일들
git commit -m "..."

# 2. 작업 디렉토리 깨끗하게
git status  # 확인

# 3. 새 브랜치 생성
git checkout -b 브랜치명

# 4. 원하는 파일만 작업 및 커밋
git add 특정파일
git commit -m "..."
```

이렇게 하면 브랜치에 원하는 파일만 포함시킬 수 있습니다!






