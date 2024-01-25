import Foundation
@testable import Subsystem
import XCTest

final class SubsystemTests: XCTestCase {

    struct TextModel: Codable {
        let text: String
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        _ = MockNetwork.shared
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testMockNetworkApi() async throws {
        let (data, _) = try await URLSession.shared
            .data(for: URLRequest(url: URL(string: "http://localhost:1234/api/1")!))
        let result = String(data: data, encoding: .utf8)!
        XCTAssertTrue(result.contains("1"))
    }

    func testMockNetworkJson() async throws {
        let (data, _) = try await URLSession.shared
            .data(for: URLRequest(url: URL(string: "http://localhost:1234/json/1")!))
        let model = try JSONDecoder().decode(TextModel.self, from: data)
        XCTAssertEqual(model.text, "1")
    }

    func testMockNetworkHello() async throws {
        let (data, _) = try await URLSession.shared
            .data(for: URLRequest(url: URL(string: "http://localhost:1234/hello")!))
        let result = String(data: data, encoding: .utf8)!
        XCTAssertEqual(result, "world")
    }
}
