import ProjectDescription

let name: Template.Attribute = .required("name")

let template = Template(
    description: "UIKit application target",
    attributes: [
        name,
    ],
    items: [
        .directory(
            path: "Targets/\(name)",
            sourcePath: "Resources"
        ),
        .directory(
            path: "Targets/\(name)",
            sourcePath: "Sources"
        ),
    ]
)
