import Observation
import SwiftUI

@Observable
final class ViewModel {
    var count: Int = 0

    init() { print("init ViewModel") }
    deinit { print("deinit ViewModel") }
}

public struct ParentView: View {
    @State var viewModel = ViewModel()

    public init() {}

    public var body: some View {
        Text(viewModel.count.description)

        Button("count up") {
            viewModel.count += 1
        }

        ChildView()
    }
}

struct ChildView: View {
    var body: some View {
        Text("Child")
    }
}

#Preview {
    ParentView()
}
