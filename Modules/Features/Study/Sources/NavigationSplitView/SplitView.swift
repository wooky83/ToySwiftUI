import SwiftUI

struct SplitView: View {

    @State private var colors = ["Red", "Green", "Blue"]
    @State private var selectedColor: String?

    var body: some View {
        NavigationSplitView {
            List(colors, id: \.self, selection: $selectedColor) {
                Text($0).tag($0)
            }
            .navigationSplitViewColumnWidth(100)
        } detail: {
            Text( selectedColor ?? "No Color Selected")
        }
        .navigationSplitViewStyle(.automatic)
    }
}

#Preview {
    SplitView()
}
