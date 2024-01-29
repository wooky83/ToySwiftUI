import SwiftUI

struct SpeedControlView: View {
    @EnvironmentObject var speedsetting: SpeedSetting

    var body: some View {
        Slider(value: $speedsetting.speed, in: 0...100)
    }
}

struct SpeedDisplayView: View {
    @EnvironmentObject var speedsetting: SpeedSetting

    var body: some View {
        Text("Speed = \(speedsetting.speed)")
    }
}

#Preview {
    SpeedControlView()
}
