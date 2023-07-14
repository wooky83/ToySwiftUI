import ProjectDescription
import ProjectDescriptionHelpers


let project = Project(name: "FeatureSupport",
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                        .SWUtil
                      ],
                      settings: .none,
                      targets: [
                        Project.target(
                            name: "FeatureSupport",
                            product: .staticFramework,
                            sources: "Sources/**",
                            resources: [],
                            dependencies: [
                                .project(target: "Subsystem", path: .relativeToRoot("Modules/Subsystem")),
                            ],
                            scripts: [.swiftLint]
                        ),
                        Project.target(
                            name: "FeatureSupportTests",
                            product: .unitTests,
                            sources: [
                                "Tests/**"
                            ],
                            dependencies: [
                                .target(name: "FeatureSupport")
                            ]
                        ),
                      ],
                      schemes: []
                )
