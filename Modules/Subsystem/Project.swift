import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.make(name: "Subsystem",
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                        .NetworkModule
                      ],
                      targets: [
                        Project.target(
                            name: "Subsystem",
                            product: .staticFramework,
                            sources: "Sources/**",
                            resources: [],
                            dependencies: [
                                Dependency.MyPackage.NetworkModule,
                                .project(target: "Util", path: .relativeToRoot("Modules/Util")),
                            ],
                            scripts: [.swiftLint]
                        ),
                        Project.target(
                            name: "SubsystemTests",
                            product: .unitTests,
                            sources: [
                                "Tests/**"
                            ],
                            dependencies: [
                                .target(name: "Subsystem")
                            ]
                        ),
                      ],
                      schemes: []
                )
