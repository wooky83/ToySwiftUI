import FeatureSupport
import SwiftUI

struct SplashScreenView: View {

    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            MainView()
        } else {
            VStack {
                VStack {
                    LottieView(
                        name: SWLottie.halloween1,
                        loopMode: .loop
                    )
                    .frame(width: 200, height: 200)
                    Text("SwiftUI Toy Project!!")
                        .font(.system(size: 26))
                        .foregroundColor(.black.opacity(0.8))
                    Spacer()
                        .frame(height: 200)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
