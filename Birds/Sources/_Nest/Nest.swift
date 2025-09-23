import SwiftUI
import Observe
import Env

public struct Nest: View {
    public init() {}

    public var body: some View {
        RootViewRepresentable(EnvRootViewController())
    }
}
