import ProjectDescription

extension Path {
    static func relativeToScript(_ pathString: String) -> Path {
        .relativeToRoot("Scripts/\(pathString)")
    }
}

public extension TargetScript {
    static var swiftLint: Self {
        .pre(
            script: """
            if [ -x "$SRCROOT/../../Scripts/run_swiftlint.sh" ]; then
                $SRCROOT/../../Scripts/run_swiftlint.sh $PWD;
            elif [ -x "$SRCROOT/../../../Scripts/run_swiftlint.sh" ]; then
                $SRCROOT/../../../Scripts/run_swiftlint.sh $PWD;
            elif [ -x "$SRCROOT/../Scripts/run_swiftlint.sh" ]; then
                $SRCROOT/../Scripts/run_swiftlint.sh $PWD;
            else
                echo "run_swiftlint.sh file not found"
            fi
            """
            , name: "Run SwiftLint",
            basedOnDependencyAnalysis: false
        )
    }

    static var swiftGen: Self {
        .pre(
            path: .relativeToScript("run_swiftgen.sh"),
            name: "Run SwiftGen",
            basedOnDependencyAnalysis: false
        )
    }

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
