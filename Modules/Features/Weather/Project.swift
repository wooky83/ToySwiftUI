import ProjectDescription
import ProjectDescriptionHelpers

let name = "Weather"

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
                            product: .framework,
                            sources: "Sources/**",
                            resources: [],
                            dependencies: [
                                .project(target: "Subsystem", path: .relativeToRoot("Modules/Subsystem")),
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
