import SwiftUI
import Combine

public struct MainView: View {
    @State
    var cancellables: Set<AnyCancellable> = .init()

    public init() {}

    public var body: some View {
        VStack {
            Spacer()
            Text("Hello, Network Sample App!")
                .padding()
            Spacer()
            Button("Use Alamofire With PromiseKit") {

            }
            Spacer()
            Button("Use URLSession With Combine") {
                

            }
            Spacer()
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
