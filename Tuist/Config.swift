import ProjectDescription

let config = Config(
    compatibleXcodeVersions: .upToNextMinor("15.0.0"),
    swiftVersion: "5.9.0",
    plugins: [
        .local(path: .relativeToManifest("../../Plugins/ToySwiftUI")),
    ]
)
