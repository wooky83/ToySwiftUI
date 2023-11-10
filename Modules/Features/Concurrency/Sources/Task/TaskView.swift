import SwiftUI

struct TaskView: View {

    @StateObject private var viewModel = TaskViewModel()

    var body: some View {
        LazyVStack {
            Image(systemName: "cloud.sun.rain.fill")
                .renderingMode(.original)
                .font(.largeTitle)
                .padding()
                .background(.black)
                .clipShape(Circle())

            Circle()
                .strokeBorder(.red, lineWidth: 20)
                .background(Circle().fill(.orange))
                .frame(width: 150, height: 150)

            Button("Test") {
                viewModel.test()
            }
        }
    }
}

#Preview {
    QueueView()
}
