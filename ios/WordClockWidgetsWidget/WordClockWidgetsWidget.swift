//
//  WordClockWidgetsWidget.swift
//  WordClockWidgetsWidget
//
//  Created by GitHub Copilot on 2026-04-04.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WordClockWidgetsWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: entry.date)
            let minute = calendar.component(.minute, from: entry.date)
            let day = calendar.component(.day, from: entry.date)
            let month = calendar.component(.month, from: entry.date)
            let year = calendar.component(.year, from: entry.date)
            let weekday = calendar.component(.weekday, from: entry.date)

            Text(NumberToWords.convertHour(hour))
                .font(.title)
            Text(NumberToWords.convertMinute(minute))
                .font(.title2)
            Text(NumberToWords.getDayNight(hour))
                .font(.body)
            Text(NumberToWords.convertDate(day, month, year))
                .font(.body)
            Text(NumberToWords.getDayOfWeek(weekday - 1))
                .font(.body)
        }
        .padding()
    }
}

@main
struct WordClockWidgetsWidget: Widget {
    let kind: String = "WordClockWidgetsWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WordClockWidgetsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Word Clock Widget")
        .description("Displays time in words.")
    }
}

struct WordClockWidgetsWidget_Previews: PreviewProvider {
    static var previews: some View {
        WordClockWidgetsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}