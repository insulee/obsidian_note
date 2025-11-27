# Git 병합 커밋 만들기 가이드

> 브랜치 분기점을 명확하게 보이게 하는 방법

---

## 문제: Fast-forward 병합

### 현재 상황

```bash
git merge docs/견적문의폼-업데이트
```

**결과:**
```
Updating e3f8e15..543d5fe
Fast-forward
```

**그래프:**
```
* 543d5fe (main, docs/견적문의폼-업데이트) ← 직선으로 보임
* e3f8e15
```

**문제점:**
- 병합 커밋이 생성되지 않음
- 그래프에서 브랜치 분기점이 보이지 않음
- 브랜치가 분기되었다가 병합된 흔적이 없음

---

## 해결: --no-ff 옵션 사용

### 병합 커밋을 만드는 방법

```bash
git merge --no-ff docs/견적문의폼-업데이트
```

**결과:**
```
Merge made by the 'recursive' strategy.
```

**그래프:**
```
*   abc1234 (main) Merge branch 'docs/견적문의폼-업데이트' ← 병합 커밋
|\
| * 543d5fe (docs/견적문의폼-업데이트) ← 분기점이 명확함
* e3f8e15
```

**장점:**
- ✅ 브랜치 분기점이 명확하게 보임
- ✅ 병합 이력이 남음
- ✅ 그래프에서 브랜치 구조를 시각적으로 확인 가능

---

## 현재 병합을 되돌리고 다시 병합하기

### 방법 1: 병합 되돌리기 (권장)

```bash
# 1. 현재 병합 되돌리기
git reset --hard e3f8e15

# 2. --no-ff 옵션으로 다시 병합
git merge --no-ff docs/견적문의폼-업데이트

# 3. 병합 커밋 메시지 작성 (에디터가 열림)
# 기본 메시지: "Merge branch 'docs/견적문의폼-업데이트' into main"
# 또는 직접 메시지 지정:
git merge --no-ff -m "Merge branch 'docs/견적문의폼-업데이트' into main" docs/견적문의폼-업데이트

# 4. 푸시 (force push 필요)
git push origin main --force
```

**주의:** `--force`는 원격 저장소의 히스토리를 덮어쓰므로, 다른 사람과 공유하는 브랜치에서는 주의해야 합니다.

### 방법 2: 다음 병합부터 적용

이미 병합이 완료되었으므로, 다음 작업부터 적용:

```bash
# 다음 브랜치 병합 시
git merge --no-ff 브랜치명
```

---

## --no-ff vs Fast-forward 비교

### Fast-forward 병합 (기본)

```bash
git merge 브랜치명
```

**조건:**
- 작업 브랜치가 메인 브랜치의 직접적인 연속일 때
- 메인 브랜치에 새로운 커밋이 없을 때

**결과:**
- 병합 커밋 없음
- 그래프가 직선으로 보임
- 히스토리가 단순함

**그래프:**
```
* 543d5fe (main, 브랜치명)
* e3f8e15
```

### --no-ff 병합 (병합 커밋 생성)

```bash
git merge --no-ff 브랜치명
```

**조건:**
- 항상 병합 커밋 생성

**결과:**
- 병합 커밋 생성
- 그래프에서 분기점이 명확함
- 브랜치 작업 이력이 보존됨

**그래프:**
```
*   abc1234 (main) Merge branch '브랜치명'
|\
| * 543d5fe (브랜치명)
* e3f8e15
```

---

## 실전 예시

### 시나리오: 견적문의 폼 업데이트 (현재 상황)

#### 현재 상태 (Fast-forward 병합됨)

```bash
# 현재 그래프
* 543d5fe (main, docs/견적문의폼-업데이트)
* e3f8e15
```

#### 되돌리고 --no-ff로 다시 병합

```bash
# 1. 메인 브랜치 확인
git checkout main

# 2. 병합 되돌리기
git reset --hard e3f8e15

# 3. --no-ff로 다시 병합
git merge --no-ff docs/견적문의폼-업데이트

# 4. 병합 커밋 메시지 확인/수정
# 에디터가 열리면 메시지를 확인하고 저장

# 5. 푸시 (force push)
git push origin main --force
```

#### 결과 그래프

```bash
git log --graph --all --oneline --decorate
```

**출력:**
```
*   def5678 (main) Merge branch 'docs/견적문의폼-업데이트' into main
|\
| * 543d5fe (docs/견적문의폼-업데이트) docs: 견적문의 폼 초안 업데이트
* e3f8e15 chore: 커밋 메시지 가이드 및 템플릿 추가
```

**차이점:**
- ✅ 분기점이 명확하게 보임 (`|\` 형태)
- ✅ 병합 커밋이 생성됨
- ✅ 브랜치 작업 이력이 보존됨

---

## 언제 --no-ff를 사용해야 하나요?

### --no-ff를 사용하는 경우

1. **브랜치 작업 이력을 보존하고 싶을 때**
2. **그래프에서 브랜치 구조를 명확히 보고 싶을 때**
3. **팀 작업에서 브랜치 병합을 추적하고 싶을 때**
4. **기능별/작업별로 브랜치를 구분하고 싶을 때**

### Fast-forward를 사용하는 경우

1. **히스토리를 단순하게 유지하고 싶을 때**
2. **작은 변경사항을 빠르게 병합할 때**
3. **개인 작업에서 브랜치 이력이 중요하지 않을 때**

---

## Git 설정으로 기본값 변경

### 전역 설정 (모든 저장소에 적용)

```bash
# --no-ff를 기본값으로 설정
git config --global merge.ff false

# 다시 Fast-forward 허용하려면
git config --global merge.ff true
```

### 로컬 설정 (현재 저장소만)

```bash
# 현재 저장소에만 적용
git config merge.ff false
```

---

## 요약

### 현재 상황

- ✅ 병합은 성공적으로 완료됨
- ⚠️ Fast-forward 병합으로 그래프가 직선으로 보임
- ⚠️ 브랜치 분기점이 명확하지 않음

### 해결 방법

1. **되돌리고 다시 병합** (--no-ff 사용)
2. **다음 병합부터 적용** (--no-ff 사용)
3. **Git 설정 변경** (--no-ff를 기본값으로)

### 권장사항

**팀 작업이나 브랜치 이력을 중요하게 생각한다면:**
- `--no-ff` 옵션 사용 권장
- 또는 `git config merge.ff false` 설정

**개인 작업이고 히스토리를 단순하게 유지하고 싶다면:**
- Fast-forward 병합 유지

---

## 다음 단계

현재 병합을 되돌리고 `--no-ff`로 다시 병합할까요?

```bash
# 되돌리기 및 재병합
git reset --hard e3f8e15
git merge --no-ff docs/견적문의폼-업데이트
git push origin main --force
```

또는 다음 작업부터 `--no-ff`를 사용하시겠어요?






