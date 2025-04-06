import SwiftUI

public struct AsyncValueView: View {
    @State var asyncValue: AsyncValue = AsyncValue<Int>.loading()
    public init() {}

    public var body: some View {
        VStack(spacing: 10) {
            asyncValue.when(
                data: { value in
                    return Text("value: \(value)")
                },
                loading: {
                    return Text("loading")
                },
                error: { error in
                    return Text("error")
                }
            )

            Button("data") {
                asyncValue = AsyncValue.data(10)
            }

            Button("isLoading") {
                asyncValue = AsyncValue<Int>.loading()
            }

            Button("error") {
                asyncValue = AsyncValue<Int>.error(error: NSError())
            }
        }
    }
}
