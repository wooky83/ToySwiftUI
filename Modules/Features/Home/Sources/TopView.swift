import SwiftUI

public struct TopView: View {
    struct MainModel: Identifiable {
        var id = UUID()
        let title: String
        let image: String
        let color: Color
    }
    private static var randomColor: Color {
        Color(red: .random(in: 0..<1), green: .random(in: 0..<1), blue: .random(in: 0..<1))
    }
    private let items: [MainModel] = [
        MainModel(title: "Grid", image: "swift", color: randomColor),
        MainModel(title: "List1", image: "list.number", color: randomColor),
        MainModel(title: "List2", image: "list.number", color: randomColor),
        MainModel(title: "Foreach", image: "figure.run.square.stack", color: randomColor)
    ]
    @State private var searchText = ""
    private var gridItems: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }
    private var filterdMessage: [MainModel] {
        guard !searchText.isEmpty else { return items }
        return items.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    public init() { }
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems) {
                    ForEach(filterdMessage) { item in
                        VStack {
                            Image(systemName: item.image)
                            Text(item.title)
                        }
                        .frame(width: 160, height: 160)
                        .background(item.color)
                        .cornerRadius(20)
                        .padding()
                    }
                }
                .searchable(text: $searchText)
            }
            .navigationTitle("👍 SwiftUI ToyProject")
        }
    }

}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
