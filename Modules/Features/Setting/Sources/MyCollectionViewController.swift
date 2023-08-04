import UIKit

class MyCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green

        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .red
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }

    @objc func buttonAction(_ sender: UIButton!) {
        let myNameViewController = MyNameViewController()
        self.navigationController?.pushViewController(myNameViewController, animated: true)
    }

}
