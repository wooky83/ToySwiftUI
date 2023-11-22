import Foundation

class ActorViewModel: ObservableObject {
    private let gasStation = GasStation()

    init() {
        self.fullLevel = 10000
        Task {
            await gasStation.setFuelLevel(self.fullLevel)
        }
    }

    @Published var isCharging = false
    @Published var fullLevel: Int

    func setCharging(_ value: Bool) {
        Task { @MainActor in
            self.isCharging = value
        }
    }

    func requestCharge() async -> Int {
        setCharging(true)
        let value = await gasStation.requestCharge()
        let level = await gasStation.fuelLevel
        setCharging(false)
        await MainActor.run {
            fullLevel = level
        }
        return value
    }
}

private actor GasStation {
    var fuelLevel = 0

    func setFuelLevel(_ value: Int) {
        fuelLevel = value
    }

    func requestCharge() async -> Int {
        do {
            try await Task.sleep(nanoseconds: 10_000_000_000)
        } catch {
            print(error)
        }
        fuelLevel -= 100
        return 100
    }
}
