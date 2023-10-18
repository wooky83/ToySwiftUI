// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tools-package",
    dependencies: [
        .package(url: "https://github.com/tuist/xcbeautify", exact: "1.0.0"),
    ],
    targets: [
        .plugin(
            name: "ArtifactBundleRunner",
            capability: .command(
                intent: .custom(
                    verb: "run-tools",
                    description: "Run external tools imported by Swift Package"
                ),
                permissions: [
                    .writeToPackageDirectory(
                        reason: "This tool was built by us. So it's never abused. Trust us!"
                    ),
                ]
            ),
            dependencies: [
                "swiftlint",
            ]
        ),
        .binaryTarget(
            name: "swiftlint",
            url: "https://github.com/realm/SwiftLint/releases/download/0.50.1/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "487c57b5a39b80d64a20a2d052312c3f5ff1a4ea28e3cf5556e43c5b9a184c0c"
        ),
    ]
)

//  swift package --package-path ${PROJECT_DIR}/tools-package \
//            plugin --allow-writing-to-package-directory run-tools \
//            swiftlint \

