import SwiftUI

public struct TopView: View {
    @State private var concurrencis = ["DispatchQueue", "OperationQueue", "Combine", "Async/Await"]

    public init() { }
    public var body: some View {
        NavigationView {
            List {
                ForEach(concurrencis, id: \.self) {
                    Text($0)
                }
            }
            .navigationTitle("🥱 Concurrency")
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
