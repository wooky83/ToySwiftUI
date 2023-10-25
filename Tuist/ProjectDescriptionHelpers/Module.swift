import ProjectDescription

public enum ModuleType {
    case app
    case feature
    case staticFramework
}

public struct Module {
    public let name: String
    public let type: ModuleType

    public var path: Path {
        switch type {
        case .app:
            return .relativeToRoot("ToySwiftUI")
        case .feature:
            return .relativeToRoot("Modules/Features/\(name)")
        case .staticFramework:
            return .relativeToRoot("Modules/\(name)")
        }
    }

    public var dependency: Dependency {
        return .project(target: name, path: path)
    }

    public var reference: TargetReference {
        return .project(path: path, target: name)
    }

    public var testableTarget: TestableTarget {
        .init(target: .project(path: path, target: "\(name)Test"))
    }

    public var uiTestableTarget: TestableTarget {
        .init(target: .project(path: path, target: "\(name)UITest"))
    }
}

public extension Module {
    static let MainApp: Module = .init(
        name: "ToySwiftUI",
        type: .app
    )
    static let Home: Module = .init(
        name: "Home",
        type: .feature
    )
    static let Concurrency: Module = .init(
        name: "Concurrency",
        type: .feature
    )
    static let Setting: Module = .init(
        name: "Setting",
        type: .feature
    )
    static let Architecture: Module = .init(
        name: "Architecture",
        type: .feature
    )
    static let FeatureSupport: Module = .init(
        name: "FeatureSupport",
        type: .staticFramework
    )
    static let Subsystem: Module = .init(
        name: "Subsystem",
        type: .staticFramework
    )
    static let Util: Module = .init(
        name: "Util",
        type: .staticFramework
    )

    static var features: [Module] {
        [
            .Home,
            .Concurrency,
            .Architecture,
            .Setting,
        ]
    }

}
