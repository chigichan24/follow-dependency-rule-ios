import Swinject

final class DefaultContainer {
    static let shared = Assembler([
        UiAssembly(),
        RepositoryAssembly(),
        DataAssembly(),
    ]).resolver
}
