import ProjectDescription

let project = Project(
    name: "LocaleProvider",
    targets: [
        .target(
            name: "LocaleProvider",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.LocaleProvider",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "LocaleProviderTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.LocaleProviderTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "LocaleProvider")
            ]
        )
    ]
)
