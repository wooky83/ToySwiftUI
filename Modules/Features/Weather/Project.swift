import ProjectDescription
import ProjectDescriptionHelpers

let name = "Weather"

let project = Project.make(name: name,
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                      ],
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
