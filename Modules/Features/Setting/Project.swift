import ProjectDescription
import ProjectDescriptionHelpers

let name = "Setting"

let project = Project(name: name,
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                        .NetworkModule,
                        .RxSwift,
                        .Snapkit,
                      ],
                      settings: .none,
                      targets: [
                        Project.target(
                            name: name,
                            product: .staticFramework,
                            sources: "Sources/**",
                            resources: [],
                            dependencies: [
                                .project(target: "FeatureSupport", path: .relativeToRoot("Modules/FeatureSupport")),
                                Dependency.MyPackage.RxSwift,
                                Dependency.MyPackage.RxCocoa,
                                Dependency.MyPackage.SanpKit,
                            ],
                            scripts: [.swiftLint]
                        ),
                        Project.target(
                            name: "\(name)Tests",
                            product: .unitTests,
                            sources: [
                                "Tests/**"
                            ],
                            dependencies: [
                                .target(name: name)
                            ]
                        ),
                      ],
                      schemes: []
                )
