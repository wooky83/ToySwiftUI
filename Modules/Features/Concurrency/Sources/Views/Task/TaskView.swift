import SwiftUI

struct TaskView: View {

    @StateObject private var viewModel = TaskViewModel()
    @State private var result = ""

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

            Button("Test TaskGroup") {
                Task {
                    if let taskResult = try? await viewModel.taskGroup() {
                        result = taskResult
                    }
                }
            }

            Text("Task Group Result is : \(result)")
        }
    }
}

#Preview {
    QueueView()
}
