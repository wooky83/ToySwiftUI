import Concurrency
import Home
import Setting
import Study
import SwiftUI

public struct MainView: View {

    public var body: some View {
        TabView {
            Home.TopView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            Study.TopView()
                .tabItem {
                    Label("Study", systemImage: "tent.2.fill")
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
