import Swinject
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        let viewController = DefaultContainer.shared.resolve(TopViewController.self)!
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = viewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
