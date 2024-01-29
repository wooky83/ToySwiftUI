import SwiftUI

struct DemoView: View {

    @StateObject var demoData = DemoData()
    let speedSetting = SpeedSetting()

    var body: some View {
        VStack {
            Text("\(demoData.currentUser), you are user Number \(demoData.userCount)")
            SpeedControlView()
            SpeedDisplayView()
        }
        .environmentObject(speedSetting)
    }
}

#Preview {
    DemoView()
}
