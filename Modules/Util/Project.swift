import ProjectDescription
import ProjectDescriptionHelpers


let project = Project(name: "Util",
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                        .SWUtil
                      ],
                      settings: .none,
                      targets: [
                        Project.target(
                            name: "Util",
                            product: .staticFramework,
                            sources: "Sources/**",
                            resources: [],
                            dependencies: [
                                Dependency.MyPackage.SWUtil
                            ]
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
