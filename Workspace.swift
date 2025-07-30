import ProjectDescription

let workspace = Workspace(
    name: "RecipeIt",
    projects: [
        "Entity",
        "Domain",
        "Data",
        "Presentation",
        "Login",
        "Shared/Modules/KeyChainHelper",
        "Shared/Modules/LocaleProvider",
        "Shared/Modules/Audio",
        "Shared/Shared",
        "RecipeIt"
    ],
    schemes: [
        Scheme.scheme(
            name: "AllTests",
            shared: true,
            buildAction: nil,
            testAction: .targets(
                [
                    .testableTarget(target: .project(path: "Domain", target: "DomainTests")),
                    .testableTarget(target: .project(path: "Data", target: "DataTests")),
                    .testableTarget(target: .project(path: "Entity", target: "EntityTests")),
                    .testableTarget(target: .project(path: "Login", target: "LoginTests")),
                    .testableTarget(target: .project(path: "Audio", target: "AudioTests")),
                    .testableTarget(target: .project(path: "LocaleProvider", target: "LocaleProviderTests")),
                    .testableTarget(target: .project(path: "KeyChainHelper", target: "KeyChainHelperTests")),
                    .testableTarget(target: .project(path: "Shared", target: "SharedTests")),
                    .testableTarget(target: .project(path: "Presentation", target: "PresentationTests"))
                ],
                configuration: .debug
            )
        )
    ]
)
