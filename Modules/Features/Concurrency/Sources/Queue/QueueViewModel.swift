import Foundation
import SWUtil

class QueueViewModel: ObservableObject {
    @Published var count = 0
    @Published var number: Int = 0

    @Published var nCount = 0
    @Published var nNumber: Int = 0

    let queue = DispatchQueue(label: "com.queue")
    let nQueue = OperationQueue().then {
        $0.maxConcurrentOperationCount = 1
    }

    func inCreaseQueue() {
        queue.async {
            print("Start DispatchQueue!!")
            self.calculate()
            Task { @MainActor in
                self.count -= 1
            }
        }
        count += 1
    }

    func inCreaseOp() {
        nQueue.addOperation {
            print("Start OperationQueue!!")
            self.calculateOp()
            Task { @MainActor in
                self.nCount -= 1
            }
        }
        nCount += 1
    }

    func calculate(_ cc: Int = 10) {
        guard cc != 0 else { return }
        Task { @MainActor in
            number += 1
        }
        sleep(1)
        calculate(cc - 1)
    }

    func calculateOp(_ cc: Int = 10) {
        guard cc != 0 else { return }
        Task { @MainActor in
            nNumber += 1
        }
        sleep(1)
        calculateOp(cc - 1)
    }

}
