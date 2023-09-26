import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "FeatureSupport",
    resources: [
        "Resources/**",
    ],
    scripts: [
        .swiftGen
    ],
    dependencies: [
        Module.Subsystem.dependency,
    ]
)
