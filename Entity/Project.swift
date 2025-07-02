import ProjectDescription

let project = Project(
    name: "Entity",
    targets: [
        // Entity 모듈 - 순수 Swift만 사용, iOS 프레임워크 접근 불가
        .target(
            name: "Entity",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.Entity",
            sources: ["Sources/**"],
            dependencies: []
        ),
        
        // Entity 모듈 테스트
        .target(
            name: "EntityTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.EntityTests",
            sources: ["Tests/**"],
            dependencies: [.target(name: "Entity")]
        )
    ]
) 
