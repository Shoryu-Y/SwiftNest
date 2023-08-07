import WidgetKit
import AppIntents

struct NestWidgetConfigurationIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}

struct NestTimelineEntry: TimelineEntry {
    let date: Date
    let configuration: NestWidgetConfigurationIntent
    let displaySize: CGSize
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> NestTimelineEntry {
        NestTimelineEntry(
            date: Date(),
            configuration: NestWidgetConfigurationIntent(),
            displaySize: context.displaySize
        )
    }

    func snapshot(for configuration: NestWidgetConfigurationIntent, in context: Context) async -> NestTimelineEntry {
        NestTimelineEntry(
            date: Date(),
            configuration: configuration,
            displaySize: context.displaySize
        )
    }

    func timeline(for configuration: NestWidgetConfigurationIntent, in context: Context) async -> Timeline<NestTimelineEntry> {
        var entries: [NestTimelineEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = NestTimelineEntry(
                date: entryDate,
                configuration: configuration,
                displaySize: context.displaySize
            )
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}
