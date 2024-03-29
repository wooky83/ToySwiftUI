import Combine
import Foundation
import SWUtil

class MyGridViewModel: ObservableObject {
    @Published var photoUrls: [URL] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchPhotos() {
        TopService.feedPhotos()
            .print()
            .ignoreFailure()
            .mainThread()
            .sink(receiveValue: { [weak self] photoModel in
                self?.photoUrls = photoModel.photoUrls.compactMap { URL(string: $0) }
            })
            .store(in: &cancellables)
    }

}
