import SwiftUI

public struct TopView: View {
    public init() { }
    public var body: some View {
        ZStack {
            MyCollectionView()
        }
    }
}

#Preview {
    TopView()
}
