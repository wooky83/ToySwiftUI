import SwiftUI
import UIKit

struct MyCollectionView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = MyCollectionViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }

}
