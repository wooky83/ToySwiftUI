import Foundation

struct PhotoModel: Codable {
    struct Item: Codable {
        struct Media: Codable {
            let m: String
        }
        let media: Media
        let title: String
        let description: String
    }
    let items: [Item]
}

extension PhotoModel {
    var photoUrls: [String] {
        items.map(\.media.m)
    }
}
