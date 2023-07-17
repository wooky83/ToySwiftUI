import SwiftUI

struct MyGridView: View {

    @StateObject private var viewModel = MyGridViewModel()
    private static var threeDividedWidth: CGFloat {
        (UIScreen.main.bounds.width - 20) / 3
    }
    private let gridItems: [GridItem] = [
        GridItem(.fixed(threeDividedWidth)),
        GridItem(.fixed(threeDividedWidth)),
        GridItem(.fixed(threeDividedWidth))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(viewModel.photoUrls, id: \.self) { photo in
                    AsyncImage(url: photo) { image in
                        image
                            .resizable()
                            .frame(width: Self.threeDividedWidth, height: 100)
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
        .navigationTitle("🥱 Grid View")
        .task {
            viewModel.fetchPhotos()
        }
    }
}

struct MyGridView_Previews: PreviewProvider {
    static var previews: some View {
        MyGridView()
    }
}
