import GRPC
import NIO
import Swinject

final class DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Parrot_ParrotServiceClientProtocol.self) { _ in
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            #if MOCK
                let testClient = Parrot_ParrotServiceTestClient()
                testClient.enqueueHelloResponse(Parrot_HelloResponse.with {
                    $0.hello = "mock message"
                })
                testClient.enqueueHelloResponse(Parrot_HelloResponse.with {
                    $0.hello = "mock message twice"
                })
                testClient.enqueueHelloResponse(Parrot_HelloResponse.with {
                    $0.hello = "mock message yeah!"
                })
                return testClient
            #else
                let channel = ClientConnection
                    .insecure(group: group)
                    .connect(host: "localhost", port: 5300)
                return Parrot_ParrotServiceClient(
                    channel: channel
                )
            #endif
        }.inObjectScope(.container)

        container.register(ApiClient.self) { _ in
            ApiClientImpl(
                client: container.resolve(Parrot_ParrotServiceClientProtocol.self)!
            )
        }.inObjectScope(.container)
    }
}
