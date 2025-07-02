import ProjectDescription

let workspace = Workspace(
    name: "PuHaHang",
    projects: [
        "Entity",
        "Domain",
        "Data",
        "Presentation",
        "PuHaHang"
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
                    .testableTarget(target: .project(path: "Presentation", target: "PresentationTests"))
                ],
                configuration: .debug
            )
        )
    ]
)
