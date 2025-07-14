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
