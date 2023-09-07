import Foundation

public class AsyncValue<T> {
    var value: T?
    var isLoading: Bool
    var error: Any?
    var stackTrace: Any?
    var hasValue: Bool

    init(value: T?, isLoading: Bool, error: Any?, stackTrace: Any?, hasValue: Bool) {
        self.value = value
        self.isLoading = isLoading
        self.error = error
        self.stackTrace = stackTrace
        self.hasValue = hasValue
    }

    public static func data(_ value: T) -> AsyncData<T> { AsyncData(value) }
    public static func loading() -> AsyncLoading<T> { AsyncLoading() }
    public static func error(error: Any, stackTrace: Any) -> AsyncError<T> {
        AsyncError(error: error, stackTrace: stackTrace)
    }

    public static func wrap<W>(with future: (Any...) async throws -> W) async throws -> AsyncValue<W> {
        do {
            let result = try await future()
            return AsyncData<W>(result)
        } catch let error {
            return AsyncError<W>(error: error, stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
    }
}

extension AsyncValue {
    private var requireValue: T {
        if hasValue, let value {
            return value
        }
        assert(false, AsyncValueError.stateError(self).message)
    }

    private var hasError: Bool {
        return error != nil
    }

    private var isRefreshing: Bool {
        return isLoading && (hasValue || hasError) && !(self is AsyncLoading<T>)
    }

    private var isReloading: Bool {
        return (hasValue || hasError) && self is AsyncLoading<T>
    }

    public func when<R>(
        data: (_ data: T) -> R,
        loading: () -> R,
        error: (_ error: Any, _ stackTrace: Any) -> R,
        skipLoadingOnReload: Bool = false,
        skipLoadingOnRefresh: Bool = true,
        skipError: Bool = false
    ) -> R {
        if isLoading {
            let skip: Bool
            if isRefreshing {
                skip = skipLoadingOnRefresh
            } else if isReloading {
                skip = skipLoadingOnReload
            } else {
                skip = false
            }
            if !skip {
                return loading()
            }
        }

        if hasError && (!hasValue || !skipError) {
            return error(self.error!, stackTrace!)
        }

        return data(requireValue)
    }
}

public final class AsyncData<T>: AsyncValue<T> {
    init(_ value: T) {
        super.init(
            value: value,
            isLoading: false,
            error: nil,
            stackTrace: nil,
            hasValue: true
        )
    }

}

public final class AsyncLoading<T>: AsyncValue<T> {
    init() {
        super.init(
            value: nil,
            isLoading: true,
            error: nil,
            stackTrace: nil,
            hasValue: false
        )
    }

}

public final class AsyncError<T>: AsyncValue<T> {
    init(error: Any, stackTrace: Any) {
        super.init(
            value: nil,
            isLoading: false,
            error: error,
            stackTrace: stackTrace,
            hasValue: false
        )
    }

}

//public protocol AsyncValue {
//    associatedtype T
//
//    var value: T? { get }
//    var isLoading: Bool { get }
//    var error: Any? { get }
//    var stackTrace: Any? { get }
//    var hasValue: Bool { get }
//}
//
//extension AsyncValue {
//    private var requireValue: T {
//        if hasValue, let value {
//            return value
//        }
//        assert(false, AsyncValueError.stateError(self).message)
//    }
//
//    private var hasError: Bool {
//        return error != nil
//    }
//
//    private var isRefreshing: Bool {
//        return isLoading && (hasValue || hasError) && !(self is AsyncLoading<T>)
//    }
//
//    private var isReloading: Bool {
//        return (hasValue || hasError) && self is AsyncLoading<T>
//    }
//
//    public func when<R>(
//        data: (_ data: T) -> R,
//        loading: () -> R,
//        error: (_ error: Any, _ stackTrace: Any) -> R,
//        skipLoadingOnReload: Bool = false,
//        skipLoadingOnRefresh: Bool = true,
//        skipError: Bool = false
//    ) -> R {
//        if isLoading {
//            let skip: Bool
//            if isRefreshing {
//                skip = skipLoadingOnRefresh
//            } else if isReloading {
//                skip = skipLoadingOnReload
//            } else {
//                skip = false
//            }
//            if !skip {
//                return loading()
//            }
//        }
//
//        if hasError && (!hasValue || !skipError) {
//            return error(self.error!, stackTrace!)
//        }
//
//        return data(requireValue)
//    }
//}
//
//public struct AsyncData<T>: AsyncValue {
//    public var value: T?
//    public var isLoading: Bool
//    public var error: Any?
//    public var stackTrace: Any?
//    public var hasValue: Bool
//
//    public init(_ value: T) {
//        self.value = value
//        self.isLoading = false
//        self.error = nil
//        self.stackTrace = nil
//        self.hasValue = true
//    }
//}
//
//public struct AsyncLoading<T>: AsyncValue {
//    public var value: T?
//    public var isLoading: Bool
//    public var error: Any?
//    public var stackTrace: Any?
//    public var hasValue: Bool
//
//    public init() {
//        self.value = nil
//        self.isLoading = true
//        self.error = nil
//        self.stackTrace = nil
//        self.hasValue = false
//    }
//}
//
//public struct AsyncError<T>: AsyncValue {
//    public var value: T?
//    public var isLoading: Bool
//    public var error: Any?
//    public var stackTrace: Any?
//    public var hasValue: Bool
//
//    public init(error: Any, stackTrace: Any) {
//        self.value = nil
//        self.isLoading = false
//        self.error = error
//        self.stackTrace = stackTrace
//        self.hasValue = false
//    }
//}
