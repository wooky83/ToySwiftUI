import SwiftUI

struct MyImageView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url)
    }
}

struct MyImageView_Previews: PreviewProvider {
    static var previews: some View {
        MyImageView(url: nil)
    }
}
