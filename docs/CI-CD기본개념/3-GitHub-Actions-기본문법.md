# GitHub Actions 기본 문법 정리

## 처음으로 GitHub Actions 작동시켜보기

GitHub Actions를 실제로 동작시켜보기 위한 기본 설정과 문법을 알아보자.

### 1. 새로운 프로젝트 폴더 만들기

먼저 GitHub Actions를 테스트할 새로운 프로젝트 폴더를 생성한다.

### 2. .github/workflows/deploy.yml 만들기

GitHub Actions를 실행시키기 위해서는 반드시 `.github/workflows`라는 디렉터리에 `.yml` 또는 `.yaml`의 확장자로 파일을 작성해야 한다. 그리고 `.github/workflows`는 프로젝트 폴더의 최상단에 만들어야 한다.

### 3. 기본 워크플로우 작성

```yaml
# Workflow의 이름
# Workflow : 하나의 yml 파일을 하나의 Workflow라고 부른다. 
name: Github Actions 실행시켜보기

# Event : 실행되는 시점을 설정
# main이라는 브랜치에 push 될 때 아래 Workflow를 실행
on:
  push:
    branches:
      - main

# 하나의 Workflow는 1개 이상의 Job으로 구성된다. 
# 여러 Job은 기본적으로 병렬적으로 수행된다.
jobs: 
  # Job을 식별하기 위한 id
  My-Deploy-Job: 
    # Github Actions를 실행시킬 서버 종류 선택
    runs-on: ubuntu-latest
    
    # Step : 특정 작업을 수행하는 가장 작은 단위
    # Job은 여러 Step들로 구성되어 있다.
    steps: 
      - name: Hello World 찍기 # Step에 이름 붙이는 기능
        run: echo "Hello World" # 실행시킬 명령어 작성
        
      - name: 여러 명령어 문장 작성하기
        run: |
          echo "Good"
          echo "Morning"
          
      # 참고: https://docs.github.com/en/actions/learn-github-actions/variables
      - name: Github Actions 자체에 저장되어 있는 변수 사용해보기
        run: |
          echo $GITHUB_SHA
          echo $GITHUB_REPOSITORY

      - name: Github Actions Secret 변수 사용해보기
        run: |
          echo ${{ secrets.MY_NAME }}
          echo ${{ secrets.MY_HOBBY }}
```

## GitHub Actions 핵심 구성 요소

### Workflow (워크플로우)
- 하나의 YAML 파일이 하나의 워크플로우
- 자동화된 프로세스를 정의하는 최상위 단위
- `.github/workflows/` 디렉터리에 위치

### Event (이벤트)
- 워크플로우가 실행되는 트리거 조건
- `on` 키워드로 정의
- 주요 이벤트: `push`, `pull_request`, `schedule`, `workflow_dispatch` 등

### Job (작업)
- 워크플로우 내에서 실행되는 작업의 묶음
- 여러 Job은 기본적으로 병렬 실행
- `runs-on`으로 실행 환경 지정

### Step (단계)
- Job 내에서 실행되는 가장 작은 실행 단위
- 순차적으로 실행됨
- `name`으로 단계명 지정, `run`으로 명령어 실행

### Runner (러너)
- 워크플로우가 실행되는 가상 환경
- GitHub 호스팅: `ubuntu-latest`, `windows-latest`, `macos-latest`
- 자체 호스팅 러너도 설정 가능

## 변수와 시크릿 사용

### GitHub 기본 환경 변수
```yaml
- name: 기본 환경 변수 사용
  run: |
    echo "Repository: $GITHUB_REPOSITORY"
    echo "Commit SHA: $GITHUB_SHA"
    echo "Branch: $GITHUB_REF"
    echo "Actor: $GITHUB_ACTOR"
```

### 시크릿 변수 사용
```yaml
- name: 시크릿 변수 사용
  run: |
    echo ${{ secrets.MY_NAME }}
    echo ${{ secrets.API_KEY }}
```

**시크릿 설정 방법:**
1. GitHub 저장소 → Settings → Secrets and variables → Actions
2. New repository secret 클릭
3. 이름과 값 입력 후 저장

시크릿 값 출력:
```text

Run echo ***
***
***

```

## 자주 사용하는 이벤트 트리거

### Push 이벤트
```yaml
on:
  push:
    branches: [ main, develop ]
    paths: [ 'src/**', '!docs/**' ]
```

### Pull Request 이벤트
```yaml
on:
  pull_request:
    branches: [ main ]
    types: [ opened, synchronize, reopened ]
```

### 수동 트리거
```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy'
        required: true
        default: 'staging'
```

### 스케줄 실행
```yaml
on:
  schedule:
    - cron: '0 2 * * *'  # 매일 오전 2시
```

## 실습 단계

### 4. GitHub Repository 만들어서 업로드하기

1. **GitHub에서 새 저장소 생성**
2. **로컬 프로젝트와 연결**
   ```bash
   git init
   git add .
   git commit -m "Initial commit with GitHub Actions"
   git branch -M main
   git remote add origin [저장소 URL]
   git push -u origin main
   ```
3. **Actions 탭에서 워크플로우 실행 확인**

### 5. 워크플로우 실행 결과 확인

GitHub 저장소의 Actions 탭에서:
- 워크플로우 실행 상태 확인
- 각 Job과 Step의 로그 확인
- 성공/실패 여부 및 실행 시간 확인

## 참고 자료

- **GitHub Actions 공식 문서**: [GitHub Actions 설명서](https://docs.github.com/ko/actions)
- **환경 변수 참고**: [GitHub Actions Variables](https://docs.github.com/en/actions/learn-github-actions/variables)
- **마켓플레이스**: 미리 만들어진 액션들을 찾을 수 있는 곳

이제 기본적인 GitHub Actions 워크플로우를 작성하고 실행할 수 있다. 다음 단계에서는 실제 Spring 프로젝트의 빌드와 테스트를 자동화해보자.
