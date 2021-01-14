import Swinject

final class UiAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TopViewController.self) { _ in
            TopViewController()
        }
    }
}
