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

    static let RxSwift = Package.remote(
        url: "https://github.com/ReactiveX/RxSwift.git",
        requirement: .upToNextMajor(from: "6.6.0")
    )

    static let Snapkit = Package.remote(
        url: "https://github.com/SnapKit/SnapKit.git",
        requirement: .upToNextMajor(from: "5.6.0")
    )

    static let Lottie = Package.remote(
        url: "https://github.com/airbnb/lottie-spm.git",
        requirement: .upToNextMajor(from: "4.3.3")
    )

    static let Algorithms = Package.remote(
        url: "https://github.com/apple/swift-algorithms",
        requirement: .upToNextMajor(from: "1.1.0")
    )

    static let Collections = Package.remote(
        url: "https://github.com/apple/swift-collections.git",
        requirement: .upToNextMajor(from: "1.0.5")
    )

    static let SWMacro = Package.remote(
        url: "https://github.com/wooky83/SWMacro",
        requirement: .branch("main")
    )

}

public typealias Dependency = TargetDependency

public extension Dependency {
    enum MyPackage {}
}


public extension Dependency.MyPackage {
    static let SWUtil: Dependency = .package(product: "SWUtil")
    static let CombineNetworkKit: Dependency = .package(product: "CombineNetworkKit")
    static let FirebaseCrashlytics: Dependency = .package(product: "FirebaseCrashlytics")
    static let RxSwift: Dependency = .package(product: "RxSwift")
    static let RxCocoa: Dependency = .package(product: "RxCocoa")
    static let SanpKit: Dependency = .package(product: "SnapKit")
    static let Lottie: Dependency = .package(product: "Lottie")
    static let Algorithms: Dependency = .package(product: "Algorithms")
    static let Collections: Dependency = .package(product: "Collections")
    static let SWMacro: Dependency = .package(product: "SWMacro")
}

