@MainActor
public final class Singleton {
    private init() { print("Singleton was initialized") }

    public static let shared = Singleton()

    public func hoge() { print("hoge") }
}
