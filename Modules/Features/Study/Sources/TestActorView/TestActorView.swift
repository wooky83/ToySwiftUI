import SwiftUI

actor BuildMessage {
    var message: String = ""
    let greeting = "Hello"

    func setName(name: String) {
        self.message = "\(greeting) \(name)"
    }

    nonisolated func getGreeting() -> String {
        greeting
    }
}

actor TimeStore {
    var timeStamp: [Int: Date] = [:]

    func addStamp(task: Int, date: Date) {
        timeStamp[task] = date
    }
}

struct TestActorView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button(action: {
                Task {
                    await someFunction()
                    syncfunction()
                    await doSomething()
                }
            }) {
                Text("Do Something")
            }
        }
    }

    func doSomething() async {
        let store = TimeStore()

        await withTaskGroup(of: Void.self) { group in
            for i in 1...5 {
                group.addTask {
                    await store.addStamp(task: i, date: takesTooLong())
                }
            }
        }

        for (task, date) in await store.timeStamp {
            print("Task \(task), Date = \(date)")
        }
    }

    func takesTooLong() async -> Date {
        sleep(1)
        return Date()
    }

    func syncfunction() {
        let builder = BuildMessage()
        let message = builder.getGreeting()
        print(message)
    }

    func someFunction() async {
        let builder = BuildMessage()
        await builder.setName(name: "Jane Smith")
        let message = await builder.message
        print(message)
    }
}

#Preview {
    TestActorView()
}
