import RxSwift

protocol ApiClient {
    func sendHelloMessage(message: String) -> Single<String>
}
