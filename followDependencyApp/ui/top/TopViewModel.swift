import RxCocoa
import RxSwift

protocol TopViewModelInputs {
    var sendingMessage: PublishRelay<String> { get }
}

protocol TopViewModelOutputs {
    var receivedMessage: Driver<String> { get }
}

protocol TopViewModelTypes {
    var inputs: TopViewModelInputs { get }
    var outputs: TopViewModelOutputs { get }
}

final class TopViewModel: TopViewModelTypes, TopViewModelInputs, TopViewModelOutputs {
    private let bag = DisposeBag()

    // inputs properties
    var inputs: TopViewModelInputs { return self }
    var sendingMessage = PublishRelay<String>()
    private var sendingMessageDriver: Driver<String>

    // outputs properties
    var outputs: TopViewModelOutputs { return self }
    var receivedMessage: Driver<String> {
        receivedMessageRelay.asDriver(onErrorJustReturn: "error")
    }

    private let receivedMessageRelay = PublishRelay<String>()

    private let repository: AppRepository

    init(
        repository: AppRepository
    ) {
        self.repository = repository
        sendingMessageDriver = sendingMessage.asDriver(onErrorJustReturn: "error")
        initOutputs()
    }

    func initOutputs() {
        sendingMessageDriver.asObservable()
            .subscribe(onNext: { [unowned self] name in
                repository.composeHello(name: name)
                    .subscribe(onSuccess: { [unowned self] replay in
                        self.receivedMessageRelay.accept(replay)
                    }).disposed(by: self.bag)
            }).disposed(by: bag)
    }
}
