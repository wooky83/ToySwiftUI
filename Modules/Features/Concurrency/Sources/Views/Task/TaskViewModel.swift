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

    func taskAsyncLet() async throws -> String {
        async let task1 = try await URLSession.shared
            .data(for: URLRequest(url: URL(string: "http://localhost:1234/api/1")!))
        async let task2 = try await URLSession.shared
            .data(for: URLRequest(url: URL(string: "http://localhost:1234/api/2")!))
        async let task3 = try await URLSession.shared
            .data(for: URLRequest(url: URL(string: "http://localhost:1234/api/3")!))
        async let task4 = try await URLSession.shared
            .data(for: URLRequest(url: URL(string: "http://localhost:1234/api/4")!))
        async let task5 = try await URLSession.shared
            .data(for: URLRequest(url: URL(string: "http://localhost:1234/api/5")!))
        let (r1, r2, r3, r4, r5) = try await (task1, task2, task3, task4, task5)
        let array = [r1, r2, r3, r4, r5]
        return array.map { String(data: $0.0, encoding: .utf8)! }.joined(separator: ",")
    }
}
