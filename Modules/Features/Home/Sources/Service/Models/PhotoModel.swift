import Foundation
import SWMacro

@Codable
struct PhotoModel {
    @Codable
    struct Item {
        struct Media: Codable {
            let m: String
        }
        let media: Media
        @CodingKey(key: "title")
        let mainTitle: String
        let description: String
    }
    let items: [Item]
}

extension PhotoModel {
    var photoUrls: [String] {
        items.map(\.media.m)
    }
}
