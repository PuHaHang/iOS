import ProjectDescription

let project = Project(
    name: "KeyChainHelper",
    targets: [
        .target(
            name: "KeyChainHelper",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.KeyChainHelper",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "KeyChainHelperTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.KeyChainHelperTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "KeyChainHelper")
            ]
        )
    ]
)
