import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "Subsystem",
    packages: [
        .NetworkModule
    ],
    dependencies: [
        Module.Util.dependency,
        Dependency.MyPackage.NetworkModule
    ]
)
