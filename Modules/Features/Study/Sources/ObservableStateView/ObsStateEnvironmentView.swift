import SwiftUI

struct ObsStateEnvironmentView: View {
    @State private var wifiEnabled = true
    @State private var userName = ""

    var body: some View {
        VStack {
            Toggle(isOn: $wifiEnabled) {
                Text("Enable Wi-Fi")
            }
            TextField("Enter user name", text: $userName)
            Text(userName)
            WifiImageView(wifiEnabled: $wifiEnabled)
            NavigationLink {
                DemoView()
            } label: {
                Text("DemoView")
            }
        }
    }
}

struct WifiImageView: View {
    @Binding var wifiEnabled: Bool

    var body: some View {
        Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
    }
}

#Preview {
    ObsStateEnvironmentView()
}
