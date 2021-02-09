import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppRepository.self) { _ in
            AppRepositoryImpl(
                client: container.resolve(ApiClient.self)!
            )
        }.inObjectScope(.container)
    }
}
