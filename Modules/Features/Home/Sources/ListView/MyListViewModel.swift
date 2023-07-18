import Foundation
import Combine
import SWUtil

class MyListViewModel: ObservableObject {
    @Published var items: [PhotoModel.Item] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchData(_ search: String) {
        guard !search.isEmpty else { return }
        TopService
            .feedPhotos(search)
            .ignoreFailure()
            .sink { [weak self] in
                self?.items = $0.items
            }
            .store(in: &cancellables)
    }
}
