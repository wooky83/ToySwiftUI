// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import UIKit

// MARK: - UIColor

public extension Style {
    enum Color {
        case uniqueOrange
        case uniquePink
        case uniquePurple
    }
}

public extension Style.Color {
    var value: UIColor {
        switch self {
        case .uniqueOrange: return AssetColor(named: "uniqueOrange")
        case .uniquePink: return AssetColor(named: "uniquePink")
        case .uniquePurple: return AssetColor(named: "uniquePurple")
        }
    }
}

extension Style.Color {
    func AssetColor(named: String) -> UIColor {
        guard let assetColor = UIColor(named: named, in: Bundle.module, compatibleWith: nil) else {
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }
        return assetColor
    }
}
// swiftlint:enable all