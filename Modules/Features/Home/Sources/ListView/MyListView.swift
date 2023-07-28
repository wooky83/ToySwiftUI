import SwiftUI

struct MyListView: View {
    @ObservedObject var viewModel = MyListViewModel()
    @State private var searchText = ""

    var body: some View {
        List {
            ForEach(viewModel.items, id: \.title) { model in
                NavigationLink {
                    MyImageView(url: URL(string: model.media.m))
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: model.media.m)) { image in
                            image
                                .resizable()
                                .frame(width: 30, height: 30)
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.trailing, 10)
                        Text(model.title)
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            viewModel.fetchData(searchText)
        }
        .navigationTitle("🥱 List View")
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}
