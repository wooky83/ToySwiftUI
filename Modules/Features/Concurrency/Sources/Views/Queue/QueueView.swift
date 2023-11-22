import SwiftUI

struct QueueView: View {

    @StateObject private var viewModel = QueueViewModel()

    var body: some View {
        VStack {
            Text("DispatchQueue")
                .font(.title)
            Text("remain : \(viewModel.count), increase \(viewModel.number)")
            Image(systemName: "airtag")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(viewModel.count == 0 ? .blue : .red)
            Button("Increase") {
                viewModel.inCreaseQueue()
            }
            Divider()
                .background(.red)
            Text("OperationQueue")
                .font(.title)
            Text("remain : \(viewModel.nCount), increase \(viewModel.nNumber)")
            Image(systemName: "airtag")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(viewModel.nCount == 0 ? .blue : .green)
            Button("Increase") {
                viewModel.inCreaseOp()
            }
        }
    }
}

#Preview {
    QueueView()
}
