import ProjectDescription

let project = Project(
    name: "RecipeIt",
    targets: [
        // 메인 앱 - Domain 모듈에 의존
        .target(
            name: "RecipeIt",
            destinations: .iOS,
            product: .app,
            bundleId: "com.puhahang.recipe-it",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "NSSpeechRecognitionUsageDescription": "음성 인식을 사용하기 위해 필요합니다.",
                    "NSMicrophoneUsageDescription": "음성 입력을 위해 마이크 접근 권한이 필요합니다.",
                    "UIBackgroundModes": ["remote-notification"],
                    "FirebaseAppDelegateProxyEnabled": false,
                    "NSAppTransportSecurity": [
                        "NSAllowsArbitraryLoads": true
                    ],
                    "UIUserInterfaceStyle": "Light"
                ]
            ),
            sources: ["Sources/**"],
            resources: [
                "Resources/**",
                .glob(pattern: "Resources/*.lproj/**")
            ],
            entitlements: .dictionary([
                "aps-environment": "development"
            ]),
            scripts: [
                .pre(script: """
        if [ -d "$HOME/.local/share/mise/shims" ]; then
            export PATH="$HOME/.local/share/mise/shims:$PATH"
        else
            echo "mise shims directory not found"
        fi
        
        SWIFTLINT_PATH=$(which swiftlint)
        SWIFTLINT_CONFIG_PATH="$SRCROOT/../.swiftlint.yml"
        
        if [ -n "$SWIFTLINT_PATH" ]; then
            swiftlint --config "$SWIFTLINT_CONFIG_PATH"
        else
            echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
        fi
        """, name: "SwiftLint")
            ],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Data", path: "../Data"),
                .project(target: "Shared", path: "../Shared/Shared"),
                .project(target: "Login", path: "../Login"),
                .project(target: "Presentation", path: "../Presentation")
            ]
        ),
    ]
) 
