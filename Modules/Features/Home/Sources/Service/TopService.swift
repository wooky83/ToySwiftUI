import Combine
import Foundation
import URLSessionNetwork

struct TopService {
    public static func feedPhotos(_ tag: String? = nil) -> AnyPublisher<PhotoModel, Error> {
        Remote<PhotoModel>(
            url: "https://api.flickr.com/services/feeds/photos_public.gne",
            parameter: ["tags": tag ?? "texas", "tagmode": "any", "format": "json", "nojsoncallback": "1"]
        )
        .asPublisher()
    }
}
