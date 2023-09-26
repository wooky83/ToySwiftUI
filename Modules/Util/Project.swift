import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "Util",
    packages: [
        .SWUtil
    ],
    dependencies: [
        Dependency.MyPackage.SWUtil
    ]
)
