import FeatureSupport
import Sentry
import Subsystem
import SwiftUI

#if Alpha || Release
#endif

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
    -> Bool {
        SentrySDK.start { options in
            options
                .dsn = "https://0c5a2e16e20d2e08ac360d5bd24b7901@o4506625259208704.ingest.sentry.io/4506625261174784"
            options.debug = true // Enabled debug when first installing is always helpful
            // Enable tracing to capture 100% of transactions for performance monitoring.
            // Use 'options.tracesSampleRate' to set the sampling rate.
            // We recommend setting a sample rate in production.
            options.enableTracing = true
        }
        print("Welcome to ToyProject!")
        _ = MockNetwork.shared
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
