import SwiftUI

struct TaskView: View {

    @StateObject private var viewModel = TaskViewModel()
    @State private var result = ""
    @State private var asynResult = ""

    var body: some View {
        LazyVStack {
            Group {
                Image(systemName: "cloud.sun.rain.fill")
                    .renderingMode(.original)
                    .font(.largeTitle)
                    .padding()
                    .background(.black)
                    .clipShape(Circle())

                Circle()
                    .strokeBorder(.red, lineWidth: 20)
                    .background(Circle().fill(.orange))
                    .frame(width: 50, height: 50)

                Button("Test TaskGroup") {
                    Task {
                        if let taskResult = try? await viewModel.taskGroup() {
                            result = taskResult
                        }
                    }
                }

                Text("Task Group Result is : \(result)")
            }
            Divider()
                .background(.red)
            Group {
                Image(systemName: "cloud.sun.rain.fill")
                    .renderingMode(.original)
                    .font(.largeTitle)
                    .padding()
                    .background(.black)
                    .clipShape(Circle())

                Circle()
                    .strokeBorder(.blue, lineWidth: 20)
                    .background(Circle().fill(.yellow))
                    .frame(width: 50, height: 50)

                Button("Test Task Async let") {
                    Task {
                        if let taskResult = try? await viewModel.taskAsyncLet() {
                            asynResult = taskResult
                        }
                    }
                }

                Text("Task Async let Result is : \(asynResult)")
            }
        }
    }
}

#Preview {
    QueueView()
}
