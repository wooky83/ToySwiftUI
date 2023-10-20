import SwiftUI

public struct TopView: View {
    @State private var concurrencis = ["Actor", "Combine", "Async/Await", "DispatchQueue"]

    public init() { }
    public var body: some View {
        NavigationView {
            List {
                ForEach(concurrencis, id: \.self) { item in
                    NavigationLink {
                        switch item {
                        case "Actor":
                            ActorView()
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
