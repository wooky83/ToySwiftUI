import SwiftUI

public struct TopView: View {
    public init() { }
    public var body: some View {
        ZStack {
            MyCollectionView()
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
