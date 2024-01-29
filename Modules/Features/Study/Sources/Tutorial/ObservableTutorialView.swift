import SwiftUI

struct ObservableTutorialView: View {

    @StateObject var timerData = TimerData()

    var body: some View {
        VStack {
            Text("Timer count = \(timerData.timeCount)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Button(action: resetCount) {
                Text("Reset Counter")
            }
            NavigationLink {
                ObsSecondView()
                    .environmentObject(timerData)
            } label: {
                Text("Next Screen")
            }
            .padding()
        }

    }

    func resetCount() {
        timerData.resetCount()
    }
}

#Preview {
    ObservableTutorialView()
}
