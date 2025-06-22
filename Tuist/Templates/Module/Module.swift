import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Creates a new module",
    attributes: [
        nameAttribute
    ],
    items: [
        .file(
            path: "\(nameAttribute)/Sources/\(nameAttribute).swift",
            templatePath: "Sources.stencil"
        ),
        .file(
            path: "\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
            templatePath: "Tests.stencil"
        ),
        .file(
            path: "\(nameAttribute)/Project.swift",
            templatePath: "Project.stencil"
        ),
    ]
)
