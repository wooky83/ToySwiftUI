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
            ${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run
            """,
            name: "Firebase Crashlytics Run",
            basedOnDependencyAnalysis: false
        )

    }
}
