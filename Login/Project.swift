import ProjectDescription

let project = Project(
    name: "Login",
    targets: [
        .target(
            name: "Login",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.Login",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Shared", path: "../Shared/Shared"),
                .external(name: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "LoginTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.LoginTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Login")
            ]
        )
    ]
)
