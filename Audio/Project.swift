import ProjectDescription

let project = Project(
    name: "Audio",
    targets: [
        .target(
            name: "Audio",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.Audio",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "AudioTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.AudioTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Audio")
            ]
        )
    ]
)
