import Foundation
import Lottie
import RxSwift
import UIKit

final class TopViewController: UIViewController {
    private let animationView = AnimationView()
    private let messageInputAreaView = UITextView()
    private let buttonView = UIButton()

    private let bag = DisposeBag()
    private let viewModel: TopViewModelTypes

    init(
        viewModel: TopViewModelTypes
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        let baseView = UIView()
        baseView.backgroundColor = UIColor(named: "Background")
        baseView.frame = view.frame
        baseView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(baseView)
        navigationController?.setNavigationBarHidden(true, animated: true)

        setupMessageInputView()
        setupAnimationView()
        setupButtonView()

        viewModel.outputs.receivedMessage.drive(onNext: { [unowned self] message in
            print("[debug] \(message)")
            let newVC = WorkspaceViewController.getVC(screenName: message)
            self.present(newVC, animated: true, completion: nil)
        }).disposed(by: bag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TopViewController.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TopViewController.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: view.window)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardDidHideNotification,
                                                  object: view.window)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        let rect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)! / 3)
            self.view.transform = transform

        })
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        let duration: TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
        })
    }

    private func setupMessageInputView() {
        messageInputAreaView.backgroundColor = .white
        messageInputAreaView.layer.cornerRadius = 5
        messageInputAreaView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageInputAreaView)
        [
            messageInputAreaView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageInputAreaView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageInputAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            messageInputAreaView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            messageInputAreaView.heightAnchor.constraint(equalToConstant: 80),
        ].forEach { $0.isActive = true }
    }

    private func setupAnimationView() {
        guard let animation = Animation.named("hello") else {
            return
        }
        animationView.animation = animation
        animationView.frame = CGRect(origin: .zero, size: view.bounds.size)
        view.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play()

        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        [
            animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            animationView.bottomAnchor.constraint(equalTo: messageInputAreaView.topAnchor, constant: 0),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ].forEach { $0.isActive = true }
    }

    private func setupButtonView() {
        buttonView.setTitle("Send Message📤", for: .normal)
        buttonView.backgroundColor = .black
        buttonView.layer.cornerRadius = 20
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonView)
        [
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: messageInputAreaView.bottomAnchor, constant: 30),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            buttonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            buttonView.heightAnchor.constraint(equalToConstant: 40),
        ].forEach { $0.isActive = true }

        buttonView.rx.tap.asSignal().emit(onNext: { [unowned self] _ in
            self.viewModel.inputs.sendingMessage.accept(self.messageInputAreaView.text)
        }).disposed(by: bag)
    }
}

extension TopViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
