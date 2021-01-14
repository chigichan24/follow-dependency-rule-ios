import Foundation
import UIKit

final class TopViewController: UIViewController {
    override func viewDidLoad() {
        let baseView = UIView()
        baseView.backgroundColor = .white
        baseView.frame = view.frame
        baseView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(baseView)
        self.navigationItem.title = "Top Page"
    }
}
