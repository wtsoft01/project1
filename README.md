# project1

개발 환경 기준 파일과 자동 검증을 관리하는 저장소입니다.

## 시작하기

1. [DEV-SETUP.md](DEV-SETUP.md)의 Windows 환경 설정을 완료합니다.
2. VS Code로 저장소를 엽니다.
3. 애플리케이션 코드를 추가할 때 언어별 포맷터, 린터, 타입 검사, 테스트를 함께 구성합니다.

## 검증

```powershell
.\verify-dev-environment.ps1
git status
```

Push 또는 Pull Request 생성 시 GitHub Actions가 기본 파일과 의심스러운 비밀정보를 검사합니다.
