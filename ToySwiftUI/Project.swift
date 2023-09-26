import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "ToySwiftUI",
    packages: [
        .FirebaseCrashlytics
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
            .crashlyticsRun,
        ],
        dependencies: [
            Dependency.MyPackage.FirebaseCrashlytics,
        ] + Module.features.map(\.dependency),
        settings: Settings.makeSettings()
    )

)
