import FeatureSupport
import SwiftUI
#if Alpha || Release
import Firebase
#endif

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
    -> Bool {
        #if Alpha || Release
        FirebaseApp.configure()
        #endif
        print("Welcome to ToyProject!")
        return true
    }
}

@main
struct ToySwiftUIApp: App {

    // Register app delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let myEnvironment = MyEnvironmnet()

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(myEnvironment)
        }
    }
}
