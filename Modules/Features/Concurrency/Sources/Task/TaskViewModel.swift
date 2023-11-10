import Combine
import Foundation

class TaskViewModel: ObservableObject {
    @Published var count = 0
    @Published var number: Int = 0

    private var cancellables = Set<AnyCancellable>()

    func test() {
        Task {
            TopService
                .api("1")
                .print()
                .ignoreFailure()
                .mainThread()
                .sink(receiveValue: { model in
                    print("Good Luck \(model)")
                })
                .store(in: &cancellables)
        }
    }
}
