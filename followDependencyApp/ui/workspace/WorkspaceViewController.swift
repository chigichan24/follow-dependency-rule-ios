import Foundation
import Lottie
import RxCocoa
import RxSwift
import UIKit

final class WorkspaceViewController: UIViewController {
    private var message: String?

    private let serverLabel = UITextView()
    private let serverMessage = UITextView()
    private let bag = DisposeBag()

    static func getVC(
        screenName: String
    ) -> UIViewController {
        let nextVC = DefaultContainer.shared.resolve(WorkspaceViewController.self)!
        nextVC.message = screenName
        return nextVC
    }

    override func viewDidLoad() {
        let baseView = UIView()
        baseView.backgroundColor = UIColor(named: "WorkspaceBackground")
        baseView.frame = view.frame
        baseView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(baseView)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupFromServerLabel()
        setupFromServerText()
    }

    private func setupFromServerLabel() {
        serverLabel.text = "From Server Message"
        serverLabel.textAlignment = .center
        serverLabel.backgroundColor = UIColor(named: "WorkspaceBackground")
        serverLabel.font = UIFont(name: "Academy Engraved LET", size: 20.0)
        serverLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(serverLabel)

        [
            serverLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            serverLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            serverLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            serverLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            serverLabel.heightAnchor.constraint(equalToConstant: 30),
        ].forEach { $0.isActive = true }
    }

    private func setupFromServerText() {
        serverMessage.text = message
        serverMessage.textAlignment = .center
        serverMessage.backgroundColor = UIColor(named: "WorkspaceBackground")
        serverMessage.font = UIFont(name: "Times New Roman", size: 16.0)
        serverMessage.layer.borderColor = UIColor.black.cgColor
        serverMessage.layer.borderWidth = 0.5
        serverMessage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(serverMessage)

        [
            serverMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            serverMessage.topAnchor.constraint(equalTo: serverLabel.topAnchor, constant: 60),
            serverMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            serverMessage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            serverMessage.heightAnchor.constraint(equalToConstant: 120),
        ].forEach { $0.isActive = true }
    }
}
