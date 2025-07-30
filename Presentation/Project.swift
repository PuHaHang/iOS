import ProjectDescription

let project = Project(
    name: "Presentation",
    targets: [
        .target(
            name: "Presentation",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.Presentation",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Shared", path: "../Shared/Shared"),
                .project(target: "Login", path: "../Login"),
                .external(name: "Kingfisher"),
                .external(name: "YouTubePlayerKit"),
                .external(name: "ComposableArchitecture"),
                .external(name: "Lottie")
            ]
        ),
        .target(
            name: "PresentationTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.PresentationTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Presentation")
            ]
        )
    ]
)
