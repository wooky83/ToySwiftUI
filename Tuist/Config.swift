import ProjectDescription

let config = Config(
    compatibleXcodeVersions: .upToNextMinor("14.3.1"),
    swiftVersion: "5.8.0",
    plugins: [
        .local(path: .relativeToManifest("../../Plugins/ToySwiftUI")),
    ]
)
