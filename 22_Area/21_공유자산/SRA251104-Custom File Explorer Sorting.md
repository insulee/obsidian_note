## 플러그인 설치

1. 옵시디언 실행 →  
    **설정 → 커뮤니티 플러그인 → 플러그인 검색**
2. 검색창에 `Custom File Explorer Sorting` 입력
3. `설치` → `활성화` 클릭
4. 활성화 후 왼쪽 리본(사이드바)에 📑 비슷한 아이콘이 생김  
    (이게 플러그인 on/off 토글 버튼)

---

## 기본 개념

이 플러그인은 **정렬 규칙을 "sortspec.md"라는 노트의 YAML 영역**에 저장합니다.  
즉, 특정 폴더 안에 “sortspec.md” 파일을 만들어 놓으면,  
그 폴더 내부의 정렬 방식이 그 설정대로 바뀌게 됩니다.

> 📁 예시 구조
> 
> ```
> 📂 Projects
> ├── sortspec.md  ← 이 파일이 정렬 기준을 지정
> ├── A_테스트.md
> ├── C_프로젝트.md
> ├── B_참조자료.md
> ```

---

## 예제 1: 오름차순 / 내림차순 정렬

1. 정렬하고 싶은 폴더로 이동
2. 새 노트를 만들고 이름을 `sortspec` 으로 지정
	- 커뮤니티 플러그인 설정에서 `Path or name of additional note(s) containing sorting specification` 값을 바꾸면 파일명 변경 가능
3. 맨 위에 다음 YAML 코드 입력

### 오름차순 (A → Z)

```yaml
---
sorting-spec: |
  order-asc: a-z
---
```

### 내림차순 (Z → A)

```yaml
---
sorting-spec: |
  order-desc: a-z
---
```

4. 왼쪽 리본에 있는 Toggle custom sorting 아이콘 클릭
5. 이제 해당 폴더 안의 **파일과 폴더가 섞여서** 정렬됩니다.  
    (폴더가 항상 위에 있던 기본 구조가 사라짐)
    

---

## 예제 2: 직접 순서 지정 (수동 정렬)

특정 파일/폴더를 원하는 순서로 직접 지정하고 싶다면 다음처럼 입력합니다.

```yaml
---
sorting-spec: |
  고객사 A 폴더
  고객사 B 폴더
  제품 소개.md
  매뉴얼 초안.md
---
```

이렇게 하면 위에 적은 순서 그대로 정렬됩니다.  
중간에 빠진 파일은 맨 아래로 자동 배치됩니다.

---

## 3: 수정일 / 생성일 기준 정렬

### 최근 수정된 순으로 내림차순 정렬

```yaml
---
sorting-spec: |
  order-desc: modified
---
```

### 생성일 기준 오래된 순으로 오름차순 정렬

```yaml
---
sorting-spec: |
  order-asc: created
---
```

> 📌 `modified` = 수정일  
> 📌 `created` = 생성일  
> 📌 `advanced modified` / `advanced created` = 폴더 내부 파일까지 포함해서 날짜 계산

---

## 고급 정렬 팁

|기능|설정 키워드|설명|
|---|---|---|
|이름순 (숫자 포함)|`order-asc: a-z`|일반 알파벳+숫자 정렬|
|이름순 (문자만)|`order-asc: true a-z`|숫자 무시|
|날짜순|`order-asc: created` / `order-desc: modified`|생성일 또는 수정일|
|폴더+파일 섞기|`treat folders and files equally`|기본 적용됨|
|북마크 순서대로|`by-bookmarks-order`|Bookmarks 탭의 순서 반영|
|수동 지정|(파일명 나열)|원하는 순서 지정|
|접두사/접미사 숫자 기준|`extract numbers`|파일명에 숫자 있으면 자동 인식|
