import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "Subsystem",
    packages: [
        .NetworkModule,
        .SWMacro
    ],
    dependencies: [
        Module.Util.dependency,
        Dependency.MyPackage.CombineNetworkKit,
        Dependency.MyPackage.SWMacro
    ]
)
