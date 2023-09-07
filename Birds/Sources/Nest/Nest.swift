import SwiftUI
import AsyncValue

public struct Nest: View {
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
                error: { error, stackTrace in
                    return Text("error")
                }
            )

            Button("data") {
                asyncValue = AsyncData<Int>(10)
            }

            Button("isLoading") {
                asyncValue = AsyncLoading<Int>()
            }

            Button("error") {
                asyncValue = AsyncError<Int>(error: "error", stackTrace: "stackTrace")
            }
        }
    }
}
