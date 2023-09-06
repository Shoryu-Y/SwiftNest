import Foundation

public enum AsyncValue<T> {
    case data(T)
    case isLoading
    case error(Any)
}

extension AsyncValue {
    public func when<R>(
        data: (T) -> R,
        loading: () -> R,
        error: (Any) -> R,
        skipLoadingOnReload: Bool = false,
        skipLoadingOnRefresh: Bool = true
    ) -> R? {
        switch self {
        case .isLoading:
            return loading()
        case let .data(value):
            return data(value)
        case let .error(e):
            return error(e)
        }
    }
}
