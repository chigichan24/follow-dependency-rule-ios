import RxSwift

final class AppRepositoryImpl: AppRepository {
    private let client: ApiClient

    init(client: ApiClient) {
        self.client = client
    }

    func composeHello(name: String) -> Single<String> {
        return client.sendHelloMessage(message: name)
    }
}
