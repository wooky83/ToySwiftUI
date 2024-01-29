import SwiftUI

struct HStackVStackView: View {

    @State var myLayout = AnyLayout(VStackLayout())

    var body: some View {
        VStack {
            myLayout {
                Image(systemName: "goforward.10")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image(systemName: "goforward.15")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            HStack {
                Button(action: {
                    myLayout = AnyLayout(HStackLayout())
                }) {
                    Text("HStack")
                }
                Button(action: {
                    myLayout = AnyLayout(VStackLayout())
                }) {
                    Text("VStack")
                }
            }
            HStack {
                Image(systemName: "airplane")
                Text("Flight times:")
                Text("London")
                    .layoutPriority(1)
            }
            .font(.largeTitle)
            .lineLimit(1)

            Text("Hello world")
                .font(.largeTitle)
                .border(.black)
                .frame(width: 100, height: 100, alignment: .center)
        }
    }
}

#Preview {
    HStackVStackView()
}
