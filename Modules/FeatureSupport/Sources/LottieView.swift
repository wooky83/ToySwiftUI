import Lottie
import SwiftUI
import UIKit

public struct LottieView: UIViewRepresentable {
    var name: SWLottie
    var loopMode: LottieLoopMode = .loop

    public init(name: SWLottie, loopMode: LottieLoopMode) {
        self.name = name
        self.loopMode = loopMode
    }

    public func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView()
        let animation = name.animation
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}
