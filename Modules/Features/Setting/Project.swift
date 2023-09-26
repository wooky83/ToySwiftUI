import ProjectDescription
import ProjectDescriptionHelpers

let name = "Setting"

let project = Project.feature(
    name: name,
    dependencies: [
        Dependency.MyPackage.RxSwift,
        Dependency.MyPackage.RxCocoa,
        Dependency.MyPackage.SanpKit
    ]
)
