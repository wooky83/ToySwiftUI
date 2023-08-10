import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.make(name: "FeatureSupport",
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                        .SWUtil
                      ],
                      targets: [
                        Project.target(
                            name: "FeatureSupport",
                            product: .staticFramework,
                            sources: "Sources/**",
                            resources: ["Resources/**"],
                            dependencies: [
                                .project(target: "Subsystem", path: .relativeToRoot("Modules/Subsystem")),
                                Dependency.MyPackage.SWUtil,
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
