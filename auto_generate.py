#!/usr/bin/env python3
import sys
import os
import json
import re
from pathlib import Path

try:
    import google.generativeai as genai
except ImportError:
    print("pip3 install google-generativeai")
    sys.exit(1)

def generate_code(feature_name, creation_type, target_component=None, method_description=None):
    # API 설정
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        print("export GEMINI_API_KEY='your-api-key'")
        sys.exit(1)
    
    genai.configure(api_key=api_key)
    model = genai.GenerativeModel('gemini-1.5-flash')
    
    # 프롬프트 생성
    if creation_type == "full":
        prompt = """
iOS Clean Architecture 패턴에 맞춰 '{feature_name}' 기능을 생성해주세요.

다음 파일들의 Swift 코드를 생성하고, JSON 형식으로 응답해주세요:
1. Entity/Sources/VO/{feature_name}/{feature_name}VO.swift
2. Data/Sources/DataSource/{feature_name}/{feature_name}DataSource.swift  
3. Data/Sources/DataSource/{feature_name}/{feature_name}DataSourceImpl.swift
4. Data/Sources/Dependencies/EmptyImpl/DataSource/Empty{feature_name}DataSource.swift
5. Data/Sources/Dependencies/DataSource.swift (새로운 DI 등록 코드만)
6. Domain/Sources/Repository/{feature_name}Repository.swift
7. Data/Sources/RepositoryImpl/{feature_name}/{feature_name}RepositoryImpl.swift
8. Data/Sources/RepositoryImpl/{feature_name}/Mock{feature_name}RepositoryImpl.swift
9. Data/Sources/Dependencies/EmptyImpl/Repository/Empty{feature_name}Repository.swift
10. Data/Sources/Dependencies/Repository.swift (새로운 DI 등록 코드만)
11. Domain/Sources/UseCase/{feature_name}/{feature_name}UseCase.swift
12. Domain/Sources/UseCase/{feature_name}/{feature_name}UseCaseImpl.swift
13. Domain/Sources/Dependencies/EmptyImpl/Empty{feature_name}UseCase.swift
14. Domain/Sources/Dependencies/UseCase.swift (새로운 DI 등록 코드만)
15. Data/Sources/DTO/{feature_name}DTO.swift
16. RecipeIt/Sources/DI/DataSource.swift (새로운 liveValue 등록 코드만)
17. RecipeIt/Sources/DI/Repository.swift (새로운 liveValue 등록 코드만)
18. RecipeIt/Sources/DI/UseCase.swift (새로운 liveValue 등록 코드만)

접근 제어자 가이드라인:
- Entity VO: public struct (다른 모듈에서 사용)
  - 프로퍼티: public let
  - 생성자: public init
- Domain Repository/UseCase 프로토콜: public protocol (다른 모듈에서 사용)
- Data DataSource 프로토콜: public protocol (다른 모듈에서 사용)  
- 구현체 (Impl): public struct/class (DI 주입용)
- Mock 구현체: public struct (DI 주입용)
- Empty DataSource: public struct (DI testValue용)
- Empty Repository: struct (internal, DI testValue용)
- Empty UseCase: struct (internal, 같은 모듈 내에서만 사용)
- DTO: public struct (DataSource 메소드 리턴 타입으로 사용)
  - 프로퍼티: let (internal, Decodable 사용)

Import 가이드라인:
- Entity VO: import Foundation
- DataSource 프로토콜: import Foundation
- DataSource 구현체: import Foundation, import Dependencies
- Empty DataSource: import Foundation
- Repository 프로토콜: import Foundation, import Entity
- Repository 구현체: import Foundation, import Entity, import Domain
- Mock Repository: import Foundation, import Entity, import Domain
- Empty Repository: import Foundation, import Entity, import Domain
- UseCase 프로토콜: import Foundation, import Entity
- UseCase 구현체: import Foundation, import Entity
- Empty UseCase: import Foundation, import Entity
- DTO: import Foundation

구현 가이드라인:
- DataSource 구현체: public init 포함, 함수 시그니처만 제공하고 TODO 주석으로 실제 구현 필요함을 표시
- Repository 구현체: public init 포함, 완전한 구현 제공
- UseCase 구현체: public init 포함, 완전한 구현 제공
- UseCase 함수명: 무조건 execute 사용
- Mock 구현체들: public init 포함, 완전한 구현 제공

DI 등록 가이드라인:
- DataSource: Data/Sources/Dependencies/DataSource.swift에 TestDependencyKey 등록 (MARK 주석 + enum + DependencyValues extension)
- Repository: Data/Sources/Dependencies/Repository.swift에 TestDependencyKey 등록 (MARK 주석 + enum + DependencyValues extension)
- UseCase: Domain/Sources/Dependencies/UseCase.swift에 TestDependencyKey 등록 (MARK 주석 + enum + DependencyValues extension)
- RecipeIt 모듈: 각각 RecipeIt/Sources/DI/ 파일들에 DependencyKey extension으로 liveValue 등록
- 패턴: extension {feature_name}DataSourceKey: @retroactive DependencyKey
- liveValue에는 실제 구현체 사용, testValue에는 Empty 구현체 사용
- 변수명은 camelCase 사용

변수명 변환 예시:
- TestFeature → testFeature
- FavoriteRecipe → favoriteRecipe
- UserProfile → userProfile

중요: DI 등록 파일들 (Dependencies/*.swift, DI/*.swift)의 경우, 
기존 파일에 추가될 새로운 DI 등록 코드만 생성해주세요. 
파일 전체 내용이 아닌 추가할 부분만 생성하면 됩니다.
예를 들어 Domain/Sources/Dependencies/UseCase.swift의 경우:
1. 기존 파일의 모든 내용 (기존 DI 등록들)
2. + 새로운 {feature_name}UseCase DI 등록

예시: 새로운 {feature_name}UseCase DI 등록 코드만 생성

DI 등록 패턴 예시:
- UseCase DI 등록:
```
// MARK: - {feature_name}UseCase DI

public enum {feature_name}UseCaseKey: TestDependencyKey {{
    #if DEBUG
    public static let testValue: {feature_name}UseCase = Empty{feature_name}UseCase()
    #endif
}}

public extension DependencyValues {{
    var {{camelCase변수명}}UseCase: {feature_name}UseCase {{
        get {{ self[{feature_name}UseCaseKey.self] }}
        set {{ self[{feature_name}UseCaseKey.self] = newValue }}
    }}
}}
```

- Repository DI 등록:
```
// MARK: - {feature_name}Repository DI

public enum {feature_name}RepositoryKey: TestDependencyKey {{
    #if DEBUG
    public static let testValue: {feature_name}Repository = Empty{feature_name}Repository()
    #endif
}}

public extension DependencyValues {{
    var {{camelCase변수명}}Repository: {feature_name}Repository {{
        get {{ self[{feature_name}RepositoryKey.self] }}
        set {{ self[{feature_name}RepositoryKey.self] = newValue }}
    }}
}}
```

- DataSource DI 등록:
```
// MARK: - {feature_name}DataSource DI

public enum {feature_name}DataSourceKey: TestDependencyKey {{
    #if DEBUG
    public static let testValue: {feature_name}DataSource = Empty{feature_name}DataSource()
    #endif
}}

public extension DependencyValues {{
    var {{camelCase변수명}}DataSource: {feature_name}DataSource {{
        get {{ self[{feature_name}DataSourceKey.self] }}
        set {{ self[{feature_name}DataSourceKey.self] = newValue }}
    }}
}}
```

- RecipeIt 모듈 DI 등록 (liveValue):
```
extension {feature_name}DataSourceKey: @retroactive DependencyKey {{
    public static let liveValue: any {feature_name}DataSource = {feature_name}DataSourceImpl()
}}

extension {feature_name}RepositoryKey: @retroactive DependencyKey {{
    public static let liveValue: any {feature_name}Repository = {{
        @Dependency(\.{{camelCase변수명}}DataSource) var dataSource
        return {feature_name}RepositoryImpl(dataSource: dataSource)
    }}()
}}

extension {feature_name}UseCaseKey: @retroactive DependencyKey {{
    public static let liveValue: any {feature_name}UseCase = {{
        @Dependency(\.{{camelCase변수명}}Repository) var repository
        return {feature_name}UseCaseImpl(repository: repository)
    }}()
}}
```

구현체 가이드라인:
- DataSource 구현체는 반드시 public init 포함
- Repository 구현체는 반드시 public init 포함
- UseCase 구현체도 반드시 public init 포함  

응답 형식:
{{"files": [{{"path": "파일경로", "content": "Swift코드"}}]}}

JSON 생성 주의사항:
- Swift 코드 내의 백슬래시(\)는 \\로 이스케이프
- Swift 코드 내의 쌍따옴표(")는 \"로 이스케이프  
- 개행 문자는 \n으로 표현
- JSON이 유효한 형식인지 확인
""".format(feature_name=feature_name)
    elif creation_type == "datasource_only":
        prompt = """
'{feature_name}' DataSource의 Swift 코드를 생성하고, JSON 형식으로 응답해주세요.

생성할 파일들:
1. Data/Sources/DataSource/{feature_name}/{feature_name}DataSource.swift
2. Data/Sources/DataSource/{feature_name}/{feature_name}DataSourceImpl.swift  
3. Data/Sources/Dependencies/EmptyImpl/DataSource/Empty{feature_name}DataSource.swift
4. Data/Sources/DTO/{feature_name}DTO.swift
5. Data/Sources/Dependencies/DataSource.swift (새로운 DI 등록 코드만)
6. RecipeIt/Sources/DI/DataSource.swift (새로운 liveValue 등록 코드만)

접근 제어자:
- DataSource 프로토콜: public protocol
- DataSource 구현체: public struct/class  
- Empty DataSource: public struct
- DTO: public struct

Import 가이드라인:
- DataSource 프로토콜: import Foundation
- DataSource 구현체: import Foundation, import Dependencies
- Empty DataSource: import Foundation
- DTO: import Foundation

응답 형식:
{{"files": [{{"path": "파일경로", "content": "Swift코드"}}]}}
""".format(feature_name=feature_name)
    elif creation_type == "repository_only":
        prompt = """
'{feature_name}' Repository의 Swift 코드를 생성하고, JSON 형식으로 응답해주세요.

생성할 파일들:
1. Domain/Sources/Repository/{feature_name}Repository.swift
2. Data/Sources/RepositoryImpl/{feature_name}/{feature_name}RepositoryImpl.swift
3. Data/Sources/RepositoryImpl/{feature_name}/Mock{feature_name}RepositoryImpl.swift
4. Data/Sources/Dependencies/EmptyImpl/Repository/Empty{feature_name}Repository.swift
5. Data/Sources/Dependencies/Repository.swift (새로운 DI 등록 코드만)
6. RecipeIt/Sources/DI/Repository.swift (새로운 liveValue 등록 코드만)

접근 제어자:
- Repository 프로토콜: public protocol
- Repository 구현체: public struct/class
- Mock Repository: public struct (DI 주입용)
- Empty Repository: struct (internal)

Import 가이드라인:
- Repository 프로토콜: import Foundation, import Entity
- Repository 구현체: import Foundation, import Entity, import Domain
- Mock Repository: import Foundation, import Entity, import Domain
- Empty Repository: import Foundation, import Entity, import Domain

응답 형식:
{{"files": [{{"path": "파일경로", "content": "Swift코드"}}]}}
""".format(feature_name=feature_name)
    elif creation_type == "usecase_only":
        prompt = """
'{feature_name}' UseCase의 Swift 코드를 생성하고, JSON 형식으로 응답해주세요.

생성할 파일들:
1. Domain/Sources/UseCase/{feature_name}/{feature_name}UseCase.swift
2. Domain/Sources/UseCase/{feature_name}/{feature_name}UseCaseImpl.swift
3. Domain/Sources/Dependencies/EmptyImpl/Empty{feature_name}UseCase.swift
4. Domain/Sources/Dependencies/UseCase.swift (새로운 DI 등록 코드만)
5. RecipeIt/Sources/DI/UseCase.swift (새로운 liveValue 등록 코드만)

접근 제어자:
- UseCase 프로토콜: public protocol
- UseCase 구현체: public struct/class
- Empty UseCase: struct (internal)

Import 가이드라인:
- UseCase 프로토콜: import Foundation, import Entity
- UseCase 구현체: import Foundation, import Entity
- Empty UseCase: import Foundation, import Entity

응답 형식:
{{"files": [{{"path": "파일경로", "content": "Swift코드"}}]}}
""".format(feature_name=feature_name)
    elif creation_type == "method_add":
        prompt = """
기존 {target_component}에 '{method_description}' 메소드를 추가하는 Swift 코드를 생성하고, JSON 형식으로 응답해주세요.

응답 형식:
{{"files": [{{"path": "수정할파일경로", "content": "추가할Swift메소드코드"}}]}}
""".format(target_component=target_component, method_description=method_description)
    
    # API 호출
    response = model.generate_content(prompt)
    
    # JSON 파싱 및 파일 생성
    json_match = re.search(r'```json\s*(.*?)\s*```', response.text, re.DOTALL)
    if json_match:
        json_text = json_match.group(1)
    else:
        json_text = response.text.strip()
    
    # JSON 파싱 전 전처리 (일반적인 문제 수정)
    # json_text = json_text.replace('\\n', '\\\\n').replace('\\"', '\\\\"')
    
    try:
        data = json.loads(json_text)
    except json.JSONDecodeError:
        print("❌ JSON 파싱 실패 - Gemini 응답을 다시 시도하세요")
        return
    
    # 파일 생성
    for file_info in data["files"]:
        file_path = Path(file_info["path"])
        content = file_info["content"]
        
        # JSON에서 온 개행문자를 실제 개행으로 변환
        content = content.replace('\\n', '\n').replace('\\"', '"')
        
        full_path = Path.cwd() / file_path
        
        # DI 등록 파일들은 기존 파일에 추가
        is_di_file = any(di_path in str(file_path) for di_path in [
            "Dependencies/DataSource.swift",
            "Dependencies/Repository.swift", 
            "Dependencies/UseCase.swift",
            "DI/DataSource.swift",
            "DI/Repository.swift",
            "DI/UseCase.swift"
        ])
        
        if is_di_file and full_path.exists():
            # 기존 파일에 새로운 내용 추가
            existing_content = full_path.read_text(encoding='utf-8')
            new_content = existing_content + '\n' + content + '\n'
            full_path.write_text(new_content, encoding='utf-8')
            print(f"✅ Added to: {full_path}")
        else:
            # 일반 파일들은 새로 생성
            full_path.parent.mkdir(parents=True, exist_ok=True)
            full_path.write_text(content, encoding='utf-8')
            print(f"✅ Created: {full_path}")

def main():
    if len(sys.argv) < 2:
        print("사용법: python3 auto_generate.py <기능명>")
        sys.exit(1)
    
    feature_name = sys.argv[1]
    
    print("1. full - 전체")
    print("2. datasource_only - DataSource만")  
    print("3. repository_only - Repository만")
    print("4. usecase_only - UseCase만")
    print("5. method_add - 메소드 추가")
    
    choice = input("선택: ").strip()
    
    if choice == "1":
        generate_code(feature_name, "full")
    elif choice == "2":
        generate_code(feature_name, "datasource_only")
    elif choice == "3":
        generate_code(feature_name, "repository_only")
    elif choice == "4":
        generate_code(feature_name, "usecase_only")
    elif choice == "5":
        target_component = input("대상 컴포넌트: ").strip()
        method_description = input("추가할 메소드: ").strip()
        generate_code(feature_name, "method_add", target_component, method_description)

if __name__ == "__main__":
    main() 