import Foundation
import UIKit

protocol TopViewModelInputs {

}

protocol TopViewModelOutputs {

}

protocol TopViewModelTypes {
    var inputs: TopViewModelInputs { get }
    var outputs: TopViewModelOutputs { get }
}

final class TopViewModel: TopViewModelTypes, TopViewModelInputs, TopViewModelOutputs {
    var inputs: TopViewModelInputs { return self }
    var outputs: TopViewModelOutputs { return self }
}
