import Concurrency
import Home
import Setting
import SwiftUI
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
            Concurrency.TopView()
                .tabItem {
                    Label("Concurrency", systemImage: "arrow.clockwise.icloud.fill")
                }
            Setting.TopView()
                .tabItem {
                    Label("Setting", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
