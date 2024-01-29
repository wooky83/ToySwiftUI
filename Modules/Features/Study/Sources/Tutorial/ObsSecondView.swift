import SwiftUI

struct ObsSecondView: View {

    @EnvironmentObject var timerData: TimerData

    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            Text("Timer Count = \(timerData.timeCount)")
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    ObsSecondView().environmentObject(TimerData())
}
