import ProjectDescription

let project = Project(
    name: "Data",
    targets: [
        .target(
            name: "Data",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.Data",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .external(name: "Minifire"),
                .external(name: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "DataTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.DataTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Data"),
                .project(target: "Domain", path: "../Domain")
            ]
        )
    ]
)
