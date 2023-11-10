import SwiftUI

public struct TopView: View {
    @State private var concurrencis = ["Actor", "Queue", "Task", "Combine", "Async/Await"]

    public init() { }
    public var body: some View {
        NavigationView {
            List {
                ForEach(concurrencis, id: \.self) { item in
                    NavigationLink {
                        switch item {
                        case concurrencis[0]:
                            ActorView()
                        case concurrencis[1]:
                            QueueView()
                        case concurrencis[2]:
                            TaskView()
                        default:
                            ActorView()
                        }
                    } label: {
                        Text(item)
                    }
                }
            }
            .navigationTitle("🥱 Concurrency")
        }
    }
}

#Preview {
    TopView()
}
