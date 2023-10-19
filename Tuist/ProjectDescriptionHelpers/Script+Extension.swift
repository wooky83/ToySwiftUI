import Foundation
import ProjectDescription

extension Path {
    static func relativeToScript(_ pathString: String) -> Path {
        .relativeToRoot("Scripts/\(pathString)")
    }
}

public extension TargetScript {
    static var swiftLint: Self {
        .pre(
            path: .relativeToScript("run_swiftlint.sh"),
            arguments: ["$PWD"],
            name: "Run SwiftLint",
            basedOnDependencyAnalysis: false
        )
    }

//    static var swiftGen: Self {
//        .pre(
//            path: .relativeToScript("run_swiftgen.sh"),
//            name: "Run SwiftGen",
//            basedOnDependencyAnalysis: false
//        )
//    }

    static var crashlyticsRun: Self {
        .post(
            script: """
            #!/bin/sh
            googleServiceInfo = ""
            if [ "${CONFIGURATION}" = "Alpha" ]; then
                googleServiceInfo="Alpha"
            elif [ "${CONFIGURATION}" = "Release" ]; then
                googleServiceInfo="Release"
            fi

            if [ "${CONFIGURATION}" = "Alpha" ] || [ "${CONFIGURATION}" = "Release" ]; then
                cp -r "$SRCROOT/../Firebase/GoogleService-Info-${googleServiceInfo}.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
                cp -r "$SRCROOT/../Firebase/GoogleService-Info-${googleServiceInfo}.plist" "$SRCROOT/../Firebase/GoogleService-Info.plist"
                ${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run
            fi
            """,
            name: "Firebase Crashlytics Run",
            basedOnDependencyAnalysis: false
        )

    }
}
