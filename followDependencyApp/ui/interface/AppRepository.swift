import RxSwift

protocol AppRepository {
    func composeHello(name: String) -> Single<String>
}
