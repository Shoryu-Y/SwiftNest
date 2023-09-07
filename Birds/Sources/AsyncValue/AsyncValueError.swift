import Foundation


enum AsyncValueError: Error {
    case stateError(any AsyncValue)

    var message: String {
        switch self {
        case let .stateError(asyncValue):
            return "Tried to call `requireValue` on an `AsyncValue` that has no value: \(asyncValue)"
        }
    }
}
