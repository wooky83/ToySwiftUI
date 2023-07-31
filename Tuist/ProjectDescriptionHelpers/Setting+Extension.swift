import ProjectDescription

public extension Settings {
    static func makeSettings() -> Settings {
        let base: SettingsDictionary = .init()
            .bitcodeEnabled(false)
            .merging(["ONLY_ACTIVE_ARCH": true])


        let configurations = SettingsDictionary.Phase.allCases.map { $0.configuration }

        return Settings.settings(
            base: base,
            configurations: configurations,
            defaultSettings: .recommended(excluding: [
                "TARGETED_DEVICE_FAMILY",
                "SWIFT_ACTIVE_COMPILATION_CONDITIONS",
            ])
        )

    }
}

extension SettingsDictionary {

    enum Phase: String, CaseIterable {
        case debug
        case release

        var name: ConfigurationName {
            switch self {
            case .debug:
                return "Debug"
            case .release:
                return "Release"
            }
        }

        var configuration: Configuration {
            switch self {
            case .debug:
                return .debug(
                    name: name,
                    settings: .init()
                        .otherSwiftFlags("$(inherited) -DDEBUG")
                        .debugInformationFormat(DebugInformationFormat.dwarf)
                    )
            case .release:
                return .debug(
                    name: name,
                    settings: .init()
                        .otherSwiftFlags("$(inherited) -DRELEASE")
                        .debugInformationFormat(DebugInformationFormat.dwarfWithDsym)
                    )
            }
        }

    }

}
