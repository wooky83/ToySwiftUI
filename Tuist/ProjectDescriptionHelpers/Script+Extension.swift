import ProjectDescription

//extension Path {
//    enum Tool {
//        static var swiftLint: Path {
//            .relativeToRoot("Scripts/run_swiftlint.sh")
//        }
//    }
//}

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
                cp -r -f "${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" "$SRCROOT/../Firebase/upload-symbols"
                ${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run
            fi
            """,
            name: "Firebase Crashlytics Run",
            basedOnDependencyAnalysis: false
        )

    }
}
