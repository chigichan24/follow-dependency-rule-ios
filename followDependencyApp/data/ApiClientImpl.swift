import RxSwift

final class ApiClientImpl: ApiClient {
    private let client: Parrot_ParrotServiceClientProtocol

    init(client: Parrot_ParrotServiceClientProtocol) {
        self.client = client
    }

    func sendHelloMessage(message: String) -> Single<String> {
        return Single.create { evemt in
            let request = Parrot_HelloRequest.with {
                $0.hello = message
            }
            do {
                let call = self.client.hello(request, callOptions: nil)
                let response = try call.response.wait()
                evemt(.success(response.hello))
            } catch {
                evemt(.error(error))
            }
            return Disposables.create()
        }
    }
}
