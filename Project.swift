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
            scripts: [
                .pre(script: """
        if [ -d "$HOME/.local/share/mise/shims" ]; then
            export PATH="$HOME/.local/share/mise/shims:$PATH"
        else
            echo "mise shims directory not found"
        fi
        
        SWIFTLINT_PATH=$(which swiftlint)
        SWIFTLINT_CONFIG_PATH="$SRCROOT/.swiftlint.yml"
        
        if [ -n "$SWIFTLINT_PATH" ]; then
            swiftlint --config "$SWIFTLINT_CONFIG_PATH"
        else
            echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
        fi
        """, name: "SwiftLint")
            ],
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
