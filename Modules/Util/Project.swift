import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.make(name: "Util",
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                        .SWUtil
                      ],
                      targets: [
                        Project.target(
                            name: "Util",
                            product: .staticFramework,
                            sources: "Sources/**",
                            resources: [],
                            dependencies: [
                                Dependency.MyPackage.SWUtil
                            ],
                            scripts: [.swiftLint]
                        ),
                        Project.target(
                            name: "UtilTests",
                            product: .unitTests,
                            sources: [
                                "Tests/**"
                            ],
                            dependencies: [
                                .target(name: "Util")
                            ]
                        ),
                      ],
                      schemes: []
                )
