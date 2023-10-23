import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "Util",
    packages: [
        .SWUtil,
        .Algorithms,
        .Collections
    ],
    dependencies: [
        Dependency.MyPackage.SWUtil,
        Dependency.MyPackage.Algorithms,
        Dependency.MyPackage.Collections
    ]
)
