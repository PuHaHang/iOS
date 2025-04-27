import ProjectDescription

let project = Project(
    name: "PuHaHang",
    targets: [
        .target(
            name: "PuHaHang",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.PuHaHang",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["PuHaHang/Sources/**"],
            resources: ["PuHaHang/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "PuHaHangTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHangTests",
            infoPlist: .default,
            sources: ["PuHaHang/Tests/**"],
            resources: [],
            dependencies: [.target(name: "PuHaHang")]
        ),
    ]
)
