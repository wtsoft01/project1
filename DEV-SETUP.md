# Windows 개발 환경 설정

## 실행 순서

1. Microsoft Store에서 **App Installer**를 설치해 `winget`을 활성화합니다.
2. 관리자 PowerShell에서 다음을 실행합니다.

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
.\setup-dev-environment.ps1
```

3. 재부팅 요청이 나오면 재부팅합니다.
4. Ubuntu 설치:

```powershell
wsl --install -d Ubuntu
```

5. 새 터미널에서 버전을 확인합니다.

```powershell
git --version
node --version
python --version
code --version
wsl --status
```

현재 점검 결과: Git과 WSL은 정상이며 VS Code, Node.js, Python, Docker는 아직 설치되지 않았습니다.

VS Code 설치 후 이 폴더를 열면 권장 확장 목록이 표시됩니다. `.vscode/extensions.json`의 권장 확장을 모두 설치하세요.

## GitHub SSH

기존 키를 덮어쓰지 않는 스크립트입니다.

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setup-github-ssh.ps1 -Email "GitHub 계정 이메일"
```

출력된 공개키를 GitHub의 Settings > SSH and GPG keys에 등록한 후 연결을 확인합니다.

```powershell
ssh -T git@github.com
```

## Docker

Docker Desktop은 공식 설치 프로그램으로 설치한 뒤 WSL2 backend를 활성화하세요. 설치 후 새 터미널에서 `docker --version`과 `docker run hello-world`를 실행합니다.

## 다음 단계

- GitHub MFA와 SSH 키 구성
- VS Code 확장: ESLint, Prettier, Python, Docker, WSL
- 프로젝트별 `.editorconfig`, `.gitignore`, `.env.example` 작성
- GitHub Actions로 lint, type check, test 자동화
- Docker Desktop은 컨테이너가 필요한 프로젝트를 시작할 때 설치

## 보안 규칙

- `.env`, 개인키, 토큰은 커밋하지 않습니다.
- API 키는 비밀번호 관리자 또는 Secret Manager에 보관합니다.
- `main` 브랜치 직접 push를 제한합니다.
- 새 패키지는 공식 저장소와 유지보수 상태를 확인한 후 설치합니다.
