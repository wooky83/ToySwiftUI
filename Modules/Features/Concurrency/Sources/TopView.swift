import SwiftUI

public struct TopView: View {
    @State private var concurrencis = ["Actor", "Queue", "Combine", "Async/Await"]

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
