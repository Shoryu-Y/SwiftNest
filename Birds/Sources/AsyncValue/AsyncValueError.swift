import Foundation


enum AsyncValueError<T>: Error {
    case stateError(AsyncValue<T>)

    var message: String {
        switch self {
        case let .stateError(asyncValue):
            return "Tried to call `requireValue` on an `AsyncValue` that has no value: \(asyncValue)"
        }
    }
}
