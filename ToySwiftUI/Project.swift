import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "ToySwiftUI",
    packages: [
        .Sentry
    ],
    settings: Settings.makeSettings(),
    targets: Project.createTargets(
        name: "ToySwiftUI",
        product: .app,
        infoPlist: .file(path: .relativeToManifest("Info.plist")),
        sources: [
            "Sources/**"
        ],
        resources: [
            "Resources/**"
        ],
        testSources: [
            "Tests/**"
        ],
        scripts: [
            .swiftLint,
            .sentryRun,
        ],
        dependencies: [
            Dependency.MyPackage.Sentry,
        ] + Module.features.map(\.dependency),
        settings: Settings.makeSettings()
    )

)
