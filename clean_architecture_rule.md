## 3. 코드 생성 요청 가이드

제가 "생성해줘", "만들어줘", "추가해줘" 등의 요청을 할 때, 아래의 규칙에 따라 파일 생성 및 수정을 수행해주세요. **`{FeatureName}`** 부분은 제가 요청하는 기능 이름(예: `FavoriteRecipe`)으로, **`{camelCaseFeatureName}`**은 이를 camelCase로 변환한 이름(예: `favoriteRecipe`)으로 대체하여 사용해주세요.

### 3.1. 전체 기능 생성 (`full`)
**요청 예시**: "Gemini, `FavoriteRecipe`라는 이름으로 전체 기능을 생성해줘."

**수행 작업**: 아래 목록의 모든 파일을 생성하고, 지정된 파일에 DI 코드를 추가합니다.

<details>
<summary><b>전체 기능 생성 시 생성 및 수정될 파일 목록 보기</b></summary>

#### 신규 파일 생성
1.  **Entity VO**: `Entity/Sources/VO/{FeatureName}/{FeatureName}VO.swift`
2.  **DataSource Protocol**: `Data/Sources/DataSource/{FeatureName}/{FeatureName}DataSource.swift`
3.  **DataSource Impl**: `Data/Sources/DataSource/{FeatureName}/{FeatureName}DataSourceImpl.swift`
4.  **Empty DataSource**: `Data/Sources/Dependencies/EmptyImpl/DataSource/Empty{FeatureName}DataSource.swift`
5.  **Repository Protocol**: `Domain/Sources/Repository/{FeatureName}Repository.swift`
6.  **Repository Impl**: `Data/Sources/RepositoryImpl/{FeatureName}/{FeatureName}RepositoryImpl.swift`
7.  **Mock Repository**: `Data/Sources/RepositoryImpl/{FeatureName}/Mock{FeatureName}RepositoryImpl.swift`
8.  **Empty Repository**: `Data/Sources/Dependencies/EmptyImpl/Repository/Empty{FeatureName}Repository.swift`
9.  **UseCase Protocol**: `Domain/Sources/UseCase/{FeatureName}/{FeatureName}UseCase.swift`
10. **UseCase Impl**: `Domain/Sources/UseCase/{FeatureName}/{FeatureName}UseCaseImpl.swift`
11. **Empty UseCase**: `Domain/Sources/Dependencies/EmptyImpl/Empty{FeatureName}UseCase.swift`
12. **DTO**: `Data/Sources/DTO/{FeatureName}DTO.swift`

#### 기존 파일 수정 (코드 추가)
1.  **Data DI**: `Data/Sources/Dependencies/DataSource.swift`
2.  **Repository DI**: `Data/Sources/Dependencies/Repository.swift`
3.  **UseCase DI**: `Domain/Sources/Dependencies/UseCase.swift`
4.  **App DI (DataSource)**: `RecipeIt/Sources/DI/DataSource.swift`
5.  **App DI (Repository)**: `RecipeIt/Sources/DI/Repository.swift`
6.  **App DI (UseCase)**: `RecipeIt/Sources/DI/UseCase.swift`

</details>

### 3.2. DataSource 레이어 생성 (`datasource_only`)
**요청 예시**: "Gemini, `UserProfile` DataSource 레이어만 만들어줘."

**수행 작업**:
<details>
<summary><b>DataSource 생성 시 생성 및 수정될 파일 목록 보기</b></summary>

- **신규 생성**:
  - `Data/Sources/DataSource/{FeatureName}/{FeatureName}DataSource.swift`
  - `Data/Sources/DataSource/{FeatureName}/{FeatureName}DataSourceImpl.swift`
  - `Data/Sources/Dependencies/EmptyImpl/DataSource/Empty{FeatureName}DataSource.swift`
  - `Data/Sources/DTO/{FeatureName}DTO.swift`
- **코드 추가**:
  - `Data/Sources/Dependencies/DataSource.swift`
  - `RecipeIt/Sources/DI/DataSource.swift`
</details>

### 3.3. Repository 레이어 생성 (`repository_only`)
**요청 예시**: "Gemini, `RecipeSearch` Repository만 생성해줘."

**수행 작업**:
<details>
<summary><b>Repository 생성 시 생성 및 수정될 파일 목록 보기</b></summary>

- **신규 생성**:
  - `Domain/Sources/Repository/{FeatureName}Repository.swift`
  - `Data/Sources/RepositoryImpl/{FeatureName}/{FeatureName}RepositoryImpl.swift`
  - `Data/Sources/RepositoryImpl/{FeatureName}/Mock{FeatureName}RepositoryImpl.swift`
  - `Data/Sources/Dependencies/EmptyImpl/Repository/Empty{FeatureName}Repository.swift`
- **코드 추가**:
  - `Data/Sources/Dependencies/Repository.swift`
  - `RecipeIt/Sources/DI/Repository.swift`
</details>

### 3.4. UseCase 레이어 생성 (`usecase_only`)
**요청 예시**: "Gemini, `Login` UseCase만 만들어줘."

**수행 작업**:
<details>
<summary><b>UseCase 생성 시 생성 및 수정될 파일 목록 보기</b></summary>

- **신규 생성**:
  - `Domain/Sources/UseCase/{FeatureName}/{FeatureName}UseCase.swift`
  - `Domain/Sources/UseCase/{FeatureName}/{FeatureName}UseCaseImpl.swift`
  - `Domain/Sources/Dependencies/EmptyImpl/Empty{FeatureName}UseCase.swift`
- **코드 추가**:
  - `Domain/Sources/Dependencies/UseCase.swift`
  - `RecipeIt/Sources/DI/UseCase.swift`
</details>

### 3.5. 메소드 추가 (`add_method`)
**요청 예시**: "Gemini, `FavoriteRecipeRepository`에 '레시피 삭제' 메소드를 추가해줘."

**수행 작업**:
1.  요청받은 컴포넌트 이름(예: `FavoriteRecipeRepository`)으로 프로젝트 내에서 관련 소스 파일을 검색합니다. (`*FavoriteRecipeRepository*.swift`)
2.  적절한 파일을 찾으면(주로 프로토콜과 구현체), 해당 파일의 내용을 읽습니다.
3.  요청받은 내용(예: '레시피 삭제')에 맞는 Swift 메소드 코드를 생성합니다.
4.  기존 파일의 클래스/구조체 닫는 괄호 `}` 바로 앞에 생성한 메소드 코드를 삽입합니다. 프로토콜과 구현체 모두에 적절한 코드를 추가해야 합니다.

---

## 4. 코드 템플릿

### 4.1. 신규 파일 템플릿
<details>
<summary>각 파일 타입에 대한 Swift 코드 템플릿 보기</summary>

**ENTITY_VO**:
```swift
import Foundation

public struct {FeatureName}VO {
    public let id: String
    public let name: String

    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
```

**DATA_SOURCE_PROTOCOL**:
```swift
import Foundation

public protocol {FeatureName}DataSource {
    func fetch() async throws -> String
}
```

**DATA_SOURCE_IMPL**:
```swift
import Foundation
import Dependencies

public struct {FeatureName}DataSourceImpl: {FeatureName}DataSource {
    public init() {}

    public func fetch() async throws -> String {
        // TODO: Implement actual data fetching logic
        return "Hello from {FeatureName}DataSourceImpl"
    }
}
```

**EMPTY_DATA_SOURCE**:
```swift
import Foundation

public struct Empty{FeatureName}DataSource: {FeatureName}DataSource {
    public init() {}

    public func fetch() async throws -> String {
        return "Empty {FeatureName} Data"
    }
}
```

**DOMAIN_REPOSITORY_PROTOCOL**:
```swift
import Foundation
import Entity

public protocol {FeatureName}Repository {
    func fetch() async throws -> {FeatureName}VO
}
```

**REPOSITORY_IMPL**:
```swift
import Foundation
import Entity
import Domain
import Dependencies

public struct {FeatureName}RepositoryImpl: {FeatureName}Repository {
    @Dependency(\.{camelCaseFeatureName}DataSource) var dataSource

    public init() {}

    public func fetch() async throws -> {FeatureName}VO {
        let data = try await dataSource.fetch()
        return {FeatureName}VO(id: "1", name: data)
    }
}
```

**MOCK_REPOSITORY_IMPL**:
```swift
import Foundation
import Entity
import Domain

public struct Mock{FeatureName}RepositoryImpl: {FeatureName}Repository {
    public init() {}

    public func fetch() async throws -> {FeatureName}VO {
        return {FeatureName}VO(id: "mock-id", name: "Mock Data")
    }
}
```

**EMPTY_REPOSITORY**:
```swift
import Foundation
import Entity
import Domain

struct Empty{FeatureName}Repository: {FeatureName}Repository {
    func fetch() async throws -> {FeatureName}VO {
        return {FeatureName}VO(id: "empty", name: "Empty")
    }
}
```

**DOMAIN_USECASE_PROTOCOL**:
```swift
import Foundation
import Entity

public protocol {FeatureName}UseCase {
    func execute() async throws -> {FeatureName}VO
}
```

**USECASE_IMPL**:
```swift
import Foundation
import Entity
import Domain
import Dependencies

public struct {FeatureName}UseCaseImpl: {FeatureName}UseCase {
    private let repository: {FeatureName}Repository
    
    public init(repository: {FeatureName}Repository) {
        self.repository = repository
    }

    public func execute() async throws -> {FeatureName}VO {
        return try await repository.fetch()
    }
}
```

**EMPTY_USECASE**:
```swift
import Foundation
import Entity

struct Empty{FeatureName}UseCase: {FeatureName}UseCase {
    func execute() async throws -> {FeatureName}VO {
        return {FeatureName}VO(id: "empty", name: "Empty UseCase")
    }
}
```

**DTO**:
```swift
import Foundation

public struct {FeatureName}DTO: Decodable {
    let id: String
    let title: String
}
```
</details>

### 4.2. DI 코드 추가 템플릿
<details>
<summary>DI 파일에 추가할 코드 템플릿 보기</summary>

**DATA_DEPENDENCIES_DI**:
```swift
// MARK: - {FeatureName}DataSource DI

public enum {FeatureName}DataSourceKey: TestDependencyKey {
    public static let testValue: any {FeatureName}DataSource = Empty{FeatureName}DataSource()
}

public extension DependencyValues {
    var {camelCaseFeatureName}DataSource: any {FeatureName}DataSource {
        get { self[{FeatureName}DataSourceKey.self] }
        set { self[{FeatureName}DataSourceKey.self] = newValue }
    }
}
```

**DOMAIN_DEPENDENCIES_REPOSITORY_DI**:
```swift
// MARK: - {FeatureName}Repository DI

public enum {FeatureName}RepositoryKey: TestDependencyKey {
    public static let testValue: any {FeatureName}Repository = Empty{FeatureName}Repository()
}

public extension DependencyValues {
    var {camelCaseFeatureName}Repository: any {FeatureName}Repository {
        get { self[{FeatureName}RepositoryKey.self] }
        set { self[{FeatureName}RepositoryKey.self] = newValue }
    }
}
```

**DOMAIN_DEPENDENCIES_USECASE_DI**:
```swift
// MARK: - {FeatureName}UseCase DI

public enum {FeatureName}UseCaseKey: TestDependencyKey {
    public static let testValue: any {FeatureName}UseCase = Empty{FeatureName}UseCase()
}

public extension DependencyValues {
    var {camelCaseFeatureName}UseCase: any {FeatureName}UseCase {
        get { self[{FeatureName}UseCaseKey.self] }
        set { self[{FeatureName}UseCaseKey.self] = newValue }
    }
}
```

**RECIPEIT_DI_DATASOURCE**:
```swift
import Dependencies
import Data

extension {FeatureName}DataSourceKey: @retroactive DependencyKey {
    public static let liveValue: any {FeatureName}DataSource = {FeatureName}DataSourceImpl()
}
```

**RECIPEIT_DI_REPOSITORY**:
```swift
import Dependencies
import Domain
import Data

extension {FeatureName}RepositoryKey: @retroactive DependencyKey {
    public static let liveValue: any {FeatureName}Repository = {FeatureName}RepositoryImpl()
}
```

**RECIPEIT_DI_USECASE**:
```swift
import Dependencies
import Domain

extension {FeatureName}UseCaseKey: @retroactive DependencyKey {
    public static let liveValue: any {FeatureName}UseCase = {
        @Dependency(\.{camelCaseFeatureName}Repository) var repository
        return {FeatureName}UseCaseImpl(repository: repository)
    }()
}
```
