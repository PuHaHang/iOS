import ProjectDescription

let project = Project(
    name: "Shared",
    targets: [
        .target(
            name: "Shared",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.Shared",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Audio", path: "../Modules/Audio"),
                .project(target: "KeyChainHelper", path: "../Modules/KeyChainHelper"),
                .project(target: "LocaleProvider", path: "../Modules/LocaleProvider"),
                .project(target: "Logger", path: "../Modules/Logger"),
                .external(name: "FirebaseCore"),
                .external(name: "FirebaseInstallations"),
                .external(name: "FirebaseMessaging"),
                .external(name: "FacebookCore")
            ],
            settings: .settings(
                base: [
                    "OTHER_LDFLAGS": ["-ObjC"]
                ]
            )
        ),
        .target(
            name: "SharedTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.SharedTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Shared")
            ]
        )
    ]
)
