import Foundation
import SWUtil

public actor MyUserInfoActor {
    public var publicKey: String

    public init() {
        self.publicKey = Self.getPublicKeyWithBundle()
    }

    private static func getPublicKeyWithBundle() -> String {
        guard let bundlePath = Bundle.module.path(forResource: "MyInfo", ofType: "geojson") else { return "" }
        let url = URL(fileURLWithPath: bundlePath)
        guard let data = try? Data(contentsOf: url) else { return "" }
        guard let myInfoModel = try? JSONDecoder().decode(MyInfoModel.self, from: data) else { return "" }
        return myInfoModel.publicKey.sw.base64Decoded
    }
}

private struct MyInfoModel: Codable {
    let publicKey: String
}
