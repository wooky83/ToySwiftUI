import ProjectDescription
import ProjectDescriptionHelpers


let project = Project(name: "Subsystem",
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                        .NetworkModule
                      ],
                      settings: .none,
                      targets: [
                        Project.target(
                            name: "Subsystem",
                            product: .staticFramework,
                            sources: "Sources/**",
                            resources: [],
                            dependencies: [
                                .project(target: "Util", path: .relativeToRoot("Modules/Util")),
                                Dependency.MyPackage.NetworkModule,
                            ]
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
