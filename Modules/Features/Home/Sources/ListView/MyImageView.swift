import SwiftUI

struct MyImageView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url)
    }
}

#Preview {
    MyImageView(url: nil)
}
