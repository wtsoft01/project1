# 기여 가이드

## 작업 흐름

1. `main`에서 작업 브랜치를 만듭니다.
2. 작은 단위로 커밋합니다.
3. `npm test`를 실행합니다.
4. Pull Request로 검토 후 병합합니다.

## 커밋 전 확인

```powershell
npm test
git diff --check
git status
```

비밀키, 토큰, `.env` 파일은 커밋하지 않습니다.
