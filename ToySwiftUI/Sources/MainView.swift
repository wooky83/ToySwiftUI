import SwiftUI
import Home
import Setting
import Vision
import Weather

public struct MainView: View {

    public var body: some View {
        TabView {
            Home.TopView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            Weather.TopView()
                .tabItem {
                    Label("Weather", systemImage: "sun.max.fill")
                }
            Vision.TopView()
                .tabItem {
                    Label("Vision", systemImage: "arrow.clockwise.icloud.fill")
                }
            Setting.TopView()
                .tabItem {
                    Label("Setting", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
