import SwiftUI

struct ContentView: View {
    @State var count: Int = 0

    var body: some View {
        let _ = print("ContentView")

        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text("Hello World")

                ConstantText()

                StateFullText()

                Text("ContentView: \(count)")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Button {
                count += 1
            } label: {
                Image(systemName: "plus")
                    .renderingMode(.template)
                    .foregroundStyle(.white)
            }
            .padding()
            .background(Color.blue)
            .clipShape(.rect(cornerRadius: 8))
            .padding()
        }
    }
}

struct ConstantText: View {
    var body: some View {
        let _ = print("ContentView")

        Text("ConstantText")
    }
}

struct StateFullText: View {
    @State var count: Int = 0

    var body: some View {
        let _ = print("StateFullText")

        Text("StateFullText: \(count)")
            .onTapGesture {
                count += 1
            }
    }
}

#Preview {
    ContentView()
}
