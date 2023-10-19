import ProjectDescription

///// Project helpers are functions that simplify the way you define your project.
///// Share code to create targets, settings, dependencies,
///// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
///// See https://docs.tuist.io/guides/helpers/
/////

public enum Constants {
    public static let platform: Platform = .iOS
    public static let reverseOrganizationName: String = "com.wooky"
    public static let minimumDeploymentTarget: DeploymentTarget = .iOS(targetVersion: "15.0", devices: .iphone)
}

public extension Project {
    static func feature(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        makeProject(
            name: name,
            packages: [
                .RxSwift,
                .Snapkit
            ],
            settings: .makeSettings(),
            targets: createTargets(
                name: name,
                product: .staticFramework,
                sources: ["Sources/**"],
//                resources: ["Resources/**"],
                testSources: ["Tests/**"],
//                uiTestSources: ["UITests/**"],
                scripts: [.swiftLint],
                dependencies: [Module.FeatureSupport.dependency] + dependencies,
                settings: .makeSettings()
            ),
            schemes: [],
            additionalFiles: []
        )
    }

    static func staticFramework(
        name: String,
        packages: [Package] = [],
        resources: ResourceFileElements? = nil,
        testSources: SourceFilesList? = nil,
        uiTestSources: SourceFilesList? = nil,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        resourcesSynthesizers: [ResourceSynthesizer] = []
    ) -> Project {
        makeProject(
            name: name,
            packages: packages,
            settings: .makeSettings(),
            targets: createTargets(
                name: name,
                product: .staticFramework,
                sources: ["Sources/**"],
                resources: resources,
                testSources: testSources ?? ["Tests/**"],
                uiTestSources: uiTestSources,
                scripts: scripts + [.swiftLint],
                dependencies: dependencies,
                settings: .makeSettings()
            ),
            schemes: [],
            additionalFiles: [],
            resourceSynthesizers: resourcesSynthesizers
        )
    }
}

public extension Project {
    static func makeProject(
        name: String,
        packages: [Package] = [],
        settings: Settings? = nil,
        targets: [Target] = [],
        schemes: [Scheme] = [],
        additionalFiles: [FileElement] = [],
        resourceSynthesizers: [ResourceSynthesizer] = []
    ) -> Project {
        Project(
            name: name,
            organizationName: Constants.reverseOrganizationName,
            options: .options(
                automaticSchemesOptions: .disabled
//                disableBundleAccessors: true,
//                disableShowEnvironmentVarsInScriptPhases: true,
//                disableSynthesizedResourceAccessors: true
            ),
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes,
            additionalFiles: additionalFiles,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}

public extension Project {
    static func createTargets(
        name: String,
        product: Product,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        testSources: SourceFilesList? = nil,
        uiTestSources: SourceFilesList? = nil,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        settings: Settings? = nil
    ) -> [Target] {
        var targets: [Target] = []

        let sourceTarget: Target = .target(
            name: name,
            product: product,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings
        )

        targets.append(sourceTarget)

        let testDependencies: [TargetDependency] = [
            //             TODO
            //            .Package.Quick,
            //            .Package.Nimble,
        ]

        if let testSources {
            let testTarget: Target = .target(
                name: "\(name)Test",
                product: .unitTests,
                sources: testSources,
                dependencies: [.target(name: name)] + testDependencies,
                settings: settings
            )

            targets.append(testTarget)
        }

        if let uiTestSources {
            let uiTestTarget: Target = .target(
                name: "\(name)UITest",
                product: .unitTests,
                sources: uiTestSources,
                dependencies: [.target(name: name)] + testDependencies
            )

            targets.append(uiTestTarget)
        }

        return targets
    }
}

public extension Target {
    static func target(
        name: String,
        product: Product,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        settings: Settings? = nil
    ) -> Target {
        var defaultBundleId = "com.wooky.\(name.lowercased())"

        switch product {
        case .app:
            defaultBundleId = "${PRODUCT_BUNDLE_IDENTIFIER}"
        default:
            break
        }

        return .init(
            name: name,
            platform: Constants.platform,
            product: product,
            productName: name,
            bundleId: defaultBundleId,
            deploymentTarget: Constants.minimumDeploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings
        )
    }
}
