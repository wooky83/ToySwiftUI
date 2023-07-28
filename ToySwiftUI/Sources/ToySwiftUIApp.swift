import SwiftUI
import FeatureSupport
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("Welcome to ToyProject!")
    return true
  }
}

@main
struct ToySwiftUIApp: App {

    // register app delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let myEnvironment = MyEnvironmnet()

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(myEnvironment)
        }
    }
}
