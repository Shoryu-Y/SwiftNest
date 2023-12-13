import AppIntents
import WidgetSource
import SwiftUI
import WidgetKit

struct SampleWidget: Widget {
    let kind: String = "com.example.sample-widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SampleProvider()) { entry in
            SampleWidgetView(entry: entry)
                .containerBackground(.fill, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct SampleProvider: TimelineProvider {
    func placeholder(in context: Context) -> SampleEntry {
        SampleEntry(date: Date.now)
    }

    func getSnapshot(in context: Context, completion: @escaping (SampleEntry) -> Void) {
        completion(SampleEntry(date: Date.now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SampleEntry>) -> Void) {
        let timeline = Timeline(
            entries: [SampleEntry(date: Date.now)],
            policy: .never
        )
        completion(timeline)
    }
}

struct SampleEntry: TimelineEntry {
    var date: Date
}

struct SampleWidgetView: View {
    var entry: SampleEntry

    @State var isOn: Bool = false

    var body: some View {
        VStack {
            Text(entry.date.timeIntervalSince1970.formatted())
            Text(entry.date, style: .timer)
            Text(isOn.description)
            Button(intent: SampleAppIntent()) {
                Image(systemName: "heart")
            }
            Toggle(isOn: isOn, intent: SampleAppIntent(), label: { Image(systemName: "heart") })
        }
    }
}

struct SampleAppIntent: AppIntent {
    static var title: LocalizedStringResource = "Sample"

    func perform() async throws -> some IntentResult {
        return .result()
    }
}

#Preview(as: .systemLarge) {
    SampleWidget()
} timeline: {
    SampleEntry(date: .now)
}
