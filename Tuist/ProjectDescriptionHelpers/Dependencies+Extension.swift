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

    static let FirebaseCrashlytics = Package.remote(
        url: "https://github.com/firebase/firebase-ios-sdk.git",
        requirement: .upToNextMajor(from: "10.12.0")
    )

}

public typealias Dependency = TargetDependency

public extension Dependency {
    enum MyPackage {}
}

public extension Dependency.MyPackage {
    static let SWUtil: Dependency = .package(product: "SWUtil")
    static let NetworkModule: Dependency = .package(product: "NetworkModule")
    static let FirebaseCrashlytics: Dependency = .package(product: "FirebaseCrashlytics")
}

