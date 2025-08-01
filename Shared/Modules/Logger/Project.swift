import Foundation
import ProjectDescription

let amplitudeKey = Environment.amplitudeApiKey.getString(default: "")

let project = Project(
    name: "Logger",
    targets: [
        .target(
            name: "Logger",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.PuHaHang.Logger",
            infoPlist: .extendingDefault(with: [
                "AMPLITUDE_API_KEY": .string(amplitudeKey)
            ]),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture"),
                .external(name: "AmplitudeSwift")
            ],
            settings: .settings(base: [
                "AMPLITUDE_API_KEY": .string(amplitudeKey)
            ])
        ),
        .target(
            name: "LoggerTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.PuHaHang.LoggerTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Logger")
            ]
        )
    ]
)
