import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "ToySwiftUI",
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [],
                      settings: .none,
                      targets: [
                        Project.target(
                            name: "ToySwiftUI",
                            product: .app,
                            infoPlist: .file(path: .relativeToManifest("Info.plist")),
                            sources: "Sources/**",
                            resources: "Resources/**",
                            dependencies: [
                                .project(target: "Subsystem", path: .relativeToRoot("Modules/Subsystem")),
                            ],
                            scripts: [.swiftLint]
                        ),
                        Project.target(
                            name: "ToySwiftUITests",
                            product: .unitTests,
                            infoPlist: .default,
                            sources: "Tests/**",
                            dependencies: [.target(name: "ToySwiftUI")]
                        ),
                      ],
                      schemes: [
                      ],
                      additionalFiles: []
)
