import SwiftUI

struct StackFrameView: View {
    var body: some View {
        LazyVStack {
            HStack {
                Image(systemName: "goforward.10")
                Image(systemName: "goforward.15")
                Image(systemName: "goforward.30")
            }
            VStack {
                Image(systemName: "goforward.10")
                Image(systemName: "goforward.15")
                Image(systemName: "goforward.30")
            }

            VStack(alignment: .center, spacing: 15) {
                Text("Financial Results")
                    .font(.title)

                HStack(alignment: .top) {
                    Text("Q1 Sales")
                        .font(.headline)
                    Spacer()
                    VStack {
                        Text("January")
                        Text("February")
                        Text("March")
                    }
                    Spacer()
                    VStack {
                        Text("$1000")
                        Text("$200")
                        Text("$3000")
                    }
                    .padding(5)
                }

                Group {
                    Text("Sample Text")
                    Text("Sample Text")
                    Text("Sample Text")
                    Text("Sample Text")
                    Text("Sample Text")
                    Text("Sample Text")
                }

                NavigationLink {
                    HStackVStackView()
                } label: {
                    Text("HStack VStack")
                }
            }
        }

    }
}

#Preview {
    StackFrameView()
}
