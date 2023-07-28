import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "ToySwiftUI",
                      organizationName: "com.wooky",
                      options: .options(automaticSchemesOptions: .disabled),
                      packages: [
                        .FirebaseCrashlytics
                      ],
                      settings: .none,
                      targets: [
                        Project.target(
                            name: "ToySwiftUI",
                            product: .app,
                            infoPlist: .file(path: .relativeToManifest("Info.plist")),
                            sources: "Sources/**",
                            resources: "Resources/**",
                            dependencies: [
                                .project(target: "Home", path: .relativeToRoot("Modules/Features/Home")),
                                .project(target: "Setting", path: .relativeToRoot("Modules/Features/Setting")),
                                .project(target: "Vision", path: .relativeToRoot("Modules/Features/Vision")),
                                .project(target: "Weather", path: .relativeToRoot("Modules/Features/Weather")),
                                Dependency.MyPackage.FirebaseCrashlytics,
                            ],
                            scripts: [
                                .swiftLint,
                                .crashlyticsRun,
                            ]
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
