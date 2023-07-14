import ProjectDescription
import ProjectDescriptionHelpers

let name = "Home"

let project = Project(name: name,
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                        .NetworkModule
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
