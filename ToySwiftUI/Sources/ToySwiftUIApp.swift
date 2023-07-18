import SwiftUI
import FeatureSupport

@main
struct ToySwiftUIApp: App {

    let myEnvironment = MyEnvironmnet()

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(myEnvironment)
        }
    }
}
