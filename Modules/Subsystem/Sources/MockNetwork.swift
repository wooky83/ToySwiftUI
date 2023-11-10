import Foundation
import Swifter
import SWMacro

//@SingleTon
public class MockNetwork {
    public static let shared = MockNetwork()

    private var server = HttpServer()

    init() {
        startServer()
    }

    func startServer() {
        do {
            try server.start(1234)
            configureServer()
            print("Server Status : \(server.state)")
        } catch {
            print("Server Start Error : \(error)")
        }
    }

    private func configureServer() {
        server["/api/:path"] = { request in
            print("Whynot \(request.path), \(request.headers)")
            return HttpResponse.ok(.text(
                """
                { "text": "\(request.path.components(separatedBy: "/").last ?? "")" }
                """
            ))
        }
    }
}
