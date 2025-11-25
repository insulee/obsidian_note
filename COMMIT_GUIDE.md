# 커밋 메시지 작성 가이드 (빠른 참고)

## 커밋 메시지 형식

```
<타입>: <간단한 설명>

<상세 설명 (선택사항)>
```

## 타입 종류

- `feat`: 새 기능 추가
- `fix`: 버그 수정
- `docs`: 문서 수정
- `style`: 코드 포맷팅 (기능 변경 없음)
- `refactor`: 코드 리팩토링
- `test`: 테스트 추가/수정
- `chore`: 빌드 설정, 패키지 관리 등

## 좋은 예시

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

## 나쁜 예시

```bash
# ❌ 나쁜 예시
git commit -m "수정"
git commit -m "업데이트"
git commit -m "asdf"
git commit -m "버그 수정 및 기능 추가 및 문서 업데이트"
```

## 실제 사용 예시

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

## 상세 가이드

더 자세한 내용은 `20_Inbox/git/Git_실전_워크플로우.md` 파일의 "커밋 메시지 작성 가이드" 섹션을 참고하세요.

