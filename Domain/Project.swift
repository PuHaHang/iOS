import ProjectDescription

let project = Project(
    name: "Domain",
    targets: [
        // Domain 모듈 - Entity 모듈에 의존, iOS 프레임워크 접근 불가
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.Domain",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Entity", path: "../Entity"),
                .external(name: "ComposableArchitecture")
            ]
        ),
        
        // Domain 모듈 테스트
        .target(
            name: "DomainTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.DomainTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Domain"),
                .project(target: "Entity", path: "../Entity")
            ]
        )
    ]
)
