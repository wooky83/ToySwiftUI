import Foundation
import Swifter
import SWMacro
import SWUtil

@SingleTon
public class MockNetwork {

    private var server = HttpServer()

    init() {
        Log.network("MockNetwork init !!")
        startServer()
    }

    private func startServer() {
        do {
            try server.start(1234)
            configureServer()
            Log.network("Server Status : \(server.state)")
        } catch {
            Log.network("Server Start Error : \(error)")
        }
    }

    private func configureServer() {
        server["/api/:path"] = { request in
            HttpResponse.ok(.text(request.path.components(separatedBy: "/").last ?? ""))
        }
        server["/hello"] = { _ in
            HttpResponse.ok(.text("world"))
        }
        server["/json/:path"] = { request in
            .ok(.json(
                ["text": request.path.components(separatedBy: "/").last ?? ""]
            ))
        }
    }

    public func stopServer() {
        server.stop()
    }
}
