import Combine
import Foundation

class DemoData: ObservableObject {
    @Published var userCount = 0
    @Published var currentUser = ""

    init() {
        updateData()
    }

    func updateData() {

    }
}

class SpeedSetting: ObservableObject {
    @Published var speed = 0.0
}
