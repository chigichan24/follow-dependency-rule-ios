import Swinject

final class UiAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TopViewModelTypes.self) { _ in
            TopViewModel(
                repository: container.resolve(AppRepository.self)!
            )
        }

        container.register(TopViewController.self) { _ in
            TopViewController(
                viewModel: container.resolve(TopViewModelTypes.self)!
            )
        }

        container.register(WorkspaceViewController.self) { _ in
            WorkspaceViewController()
        }
    }
}
