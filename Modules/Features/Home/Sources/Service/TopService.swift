import Foundation
import NetworkModule
import Combine

struct TopService {
    public static func feedPhotos(_ param: [String: String]? = nil) -> AnyPublisher<PhotoModel, Error> {
        Remote<PhotoModel>(url: "https://api.flickr.com/services/feeds/photos_public.gne", parameter: ["tags": "texas", "tagmode": "any", "format": "json", "nojsoncallback": "1"])
            .asUnwrapPublisher()
    }
}
