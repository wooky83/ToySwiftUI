import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "FeatureSupport",
    packages: [
        .Lottie
    ],
    resources: [
        "Resources/**",
    ],
    dependencies: [
        Module.Subsystem.dependency,
        Dependency.MyPackage.Lottie,
    ],
    resourcesSynthesizers: [
        .custom(name: "colors", parser: .assets, extensions: ["xcassets"]),
        .custom(name: "images", parser: .assets, extensions: ["xcassets"]),
        .custom(name: "lottie", parser: .json, extensions: ["json"])
    ]
)
