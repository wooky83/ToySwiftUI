import ProjectDescription

public extension Package {
    static let SWUtil = Package.remote(
        url: "https://github.com/wooky83/IOSUtil.git",
        requirement: .branch("master")
    )

    static let NetworkModule = Package.remote(
        url: "https://github.com/wooky83/NetworkModule.git",
        requirement: .branch("master")
    )

}

public typealias Dependency = TargetDependency

public extension Dependency {
    enum MyPackage {}
}

public extension Dependency.MyPackage {
    static let SWUtil: Dependency = .package(product: "SWUtil")
    static let NetworkModule: Dependency = .package(product: "NetworkModule")
}

