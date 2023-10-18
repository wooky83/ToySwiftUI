import Foundation
import PackagePlugin

@main
struct ArtifactBundleRunner: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        guard let toolName = arguments.first else {
            print("Tool name is required")
            print("Usage: swift package plugin run-tools <tool-name> (<arguments>...)")
            exit(EXIT_FAILURE)
        }

        guard let tools = try? context.tool(named: toolName) else {
            print("Tool \"\(toolName)\" not found")
            let availableTools = context.package.targets(ofType: BinaryArtifactTarget.self)
                .map(\.name)
            print("Available: \(availableTools.joined(separator: ", "))")
            exit(EXIT_FAILURE)
        }
        let commandArguments: [String] = arguments[1...]
            .map(String.init(_:))

        let process = Process()
        process.executableURL = URL(fileURLWithPath: tools.path.string)
        process.arguments = commandArguments

        try process.run()
        process.waitUntilExit()
    }
}
