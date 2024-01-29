import SwiftUI

struct StructuredConcurrencyView: View {
    enum DurationError: Error {
        case tooLong
        case tooShort
    }

    var body: some View {
        Button(action: {
            Task {
                await doSomething()
            }
        }) {
            Text("Do Something")
        }
    }

    func doSomething() async {
        var timeStamp: [Int: Date] = [:]

        await withTaskGroup(of: (Int, Date).self) { group in
            for i in 1...5 {
                group.addTask {
                    return await (i, takesTooLong())
                }
            }

            for await (task, date) in group {
                timeStamp[task] = date
            }
        }

        for (task, date) in timeStamp {
            print("Task \(task), Date = \(date)")
        }
    }

    func takesTooLong() async -> Date {
        sleep(1)
        return Date()
    }

//    func doSomething() async {
//        print("Start \(Date())")
//        do {
//            try await takesTooLong(delay: 25)
//        } catch DurationError.tooShort {
//            print("Error: Duration too short")
//        } catch DurationError.tooLong {
//            print("Error: Duration too long")
//        } catch {
//            print("Unkown Error")
//        }
//
//        print("End \(Date())")
//    }
//
//    func takesTooLong(delay: UInt32) async throws {
//        if delay < 5 {
//            throw DurationError.tooShort
//        } else if delay > 20 {
//            throw DurationError.tooLong
//        }
//        sleep(delay)
//        print("Async task completed at \(Date())")
//    }
}

#Preview {
    StructuredConcurrencyView()
}
