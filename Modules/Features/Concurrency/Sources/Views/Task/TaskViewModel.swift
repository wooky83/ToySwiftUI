import Combine
import Foundation

class TaskViewModel: ObservableObject {
    @Published var count = 0
    @Published var number: Int = 0

    private var cancellables = Set<AnyCancellable>()

    func taskGroup() async throws -> String {
        try await withThrowingTaskGroup(of: Data.self, returning: String.self) { group in
            for i in 1...9 {
                group.addTask {
                    let (data, _) = try await URLSession.shared
                        .data(for: URLRequest(url: URL(string: "http://localhost:1234/api/\(i)")!))
                    return data
                }
            }
            return try await group.reduce("") { result, data in
                result + String(data: data, encoding: .utf8)!
            }
        }
    }
}
