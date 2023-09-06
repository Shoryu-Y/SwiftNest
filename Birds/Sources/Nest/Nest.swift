import SwiftUI
import AsyncValue

public struct Nest: View {
    @State var asyncValue = AsyncValue<Int>.isLoading
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
                asyncValue = AsyncValue.isLoading
            }

            Button("error") {
                asyncValue = AsyncValue.error(0)
            }
        }
    }
}
