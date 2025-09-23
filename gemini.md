# PuHaHang 프로젝트 컨텍스트 및 코드 생성 규칙

## 1. 프로젝트 개요
- **앱 이름**: PuHaHang (가칭)
- **목표**: iOS 레시피 추천 및 관리 앱
- **주요 기술**: Swift, SwiftUI, TCA(The Composable Architecture), Tuist
- **핵심 아키텍처**: 모듈화된 클린 아키텍처 (Presentation - Domain - Data - Entity)
- **의존성 관리**: `swift-dependencies`를 사용한 DI

## 2. 기본 원칙
- **코딩 컨벤션**: `.swiftlint.yml` 규칙을 항상 준수합니다.
- **네이밍**: 타입은 `UpperCamelCase`, 변수/함수는 `lowerCamelCase`를 사용합니다.
- **주석**: `MARK:` 주석으로 코드 블록을 명확히 구분합니다.
- **파일 수정**: 기존 파일을 수정할 때는, 해당 파일의 스타일과 구조를 반드시 먼저 파악하고 일관성을 유지합니다.

---

상세한 코드 생성 규칙은 [clean_architecture_rule.md](./clean_architecture_rule.md) 파일을 참조해주세요.

## 3. 코드 생성 키워드 및 규칙

다음 키워드를 사용하여 코드 생성을 요청할 수 있습니다. 각 키워드에 대한 자세한 규칙은 `clean_architecture_rule.md` 파일을 참조하세요.

- **`전체 기능 생성`**: Presentation - Domain - Data - Entity 계층에 걸친 전체 모듈 파일을 생성합니다.
- **`DataSource 레이어 생성`**: DataSource 관련 파일만 생성합니다.
- **`Repository 레이어 생성`**: Repository 관련 파일만 생성합니다.
- **`UseCase 레이어 생성`**: UseCase 관련 파일만 생성합니다.
- **`메소드 추가`**: 기존 파일에 새로운 메소드를 추가합니다.