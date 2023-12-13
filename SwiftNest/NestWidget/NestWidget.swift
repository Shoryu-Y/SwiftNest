import AppIntents
import WidgetKit
import SwiftUI

struct NestWidget: Widget {
    let kind: String = "NestWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: NestWidgetConfigurationIntent.self,
            provider: NestProvider()) { entry in
                NestWidgetView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            }
    }
}

struct NestWidgetAppIntent: AppIntent {
    static let title: LocalizedStringResource = "Button Perform"
    static let description: IntentDescription = "Button Perform"

    @Parameter(title: "Count") var count: Int

    func perform() async throws -> some IntentResult {
        count += 1
        print(count)
        return .result()
    }
}

struct NestWidgetView : View {
    var entry: NestProvider.Entry

    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        ZStack {
            Image(.myCharactor2)
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack {
//                Text(entry.date, style: .time)
//                    .font(.title)
//                    .foregroundStyle(.white)
//                    .frame(width: entry.displaySize.width, height: 60)
//                    .background(Color(hue: 1.0, saturation: 1.0, brightness: 0, opacity: 0.3))
//                    .clipShape(.rect(cornerRadius: 10))

                Spacer()

//                Button(intent: NestWidgetAppIntent(count: )) {
//                    Image(systemName: "heart")
//                }
            }
            .frame(width: .infinity, height: .infinity)
        }
        .frame(width: .infinity, height: .infinity)
    }
}

extension NestWidgetConfigurationIntent {
    fileprivate static var smiley: NestWidgetConfigurationIntent {
        let intent = NestWidgetConfigurationIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: NestWidgetConfigurationIntent {
        let intent = NestWidgetConfigurationIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

struct CustomText: UIViewRepresentable {
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.text = "CustomText"
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {}
}

#Preview(as: .systemExtraLarge) {
    NestWidget()
} timeline: {
    NestTimelineEntry(
        date: .now,
        configuration: .smiley,
        displaySize: CGSize(width: 300, height: 300)
    )
}
