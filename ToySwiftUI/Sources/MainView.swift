import Architecture
import Concurrency
import Home
import Setting
import SwiftUI

public struct MainView: View {

    public var body: some View {
        TabView {
            Home.TopView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            Architecture.TopView()
                .tabItem {
                    Label("Architecture", systemImage: "tent.2.fill")
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
