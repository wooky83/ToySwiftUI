import Combine
import CombineNetworkKit
import Foundation

struct TopService {
    public static func api(_ tag: String) -> AnyPublisher<TextModel, Error> {
        Remote<TextModel>(
            url: "http://localhost:1234/api/\(tag)"
        )
        .asPublisher()
    }
}
