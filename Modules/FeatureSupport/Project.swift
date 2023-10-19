import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "FeatureSupport",
    resources: [
        "Resources/**",
    ],
    dependencies: [
        Module.Subsystem.dependency,
    ],
    resourcesSynthesizers: [
        .custom(name: "colors", parser: .assets, extensions: ["xcassets"])
    ]
)
