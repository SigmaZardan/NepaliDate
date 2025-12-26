//
//  NepaliDateWidget.swift
//  NepaliDateWidget
//
//  Created by Bibek Bhujel on 24/12/2025.
//

import WidgetKit
import SwiftUI


extension Color {
    // Light mode colors (unchanged)
    static let nepaliRed = Color(red: 0.863, green: 0.078, blue: 0.235)
    static let nepaliBlue = Color(red: 0.0, green: 0.2, blue: 0.4)
    static let nepaliOrange = Color(red: 0.957, green: 0.435, blue: 0.196)
    static let himalayanBlue = Color(red: 0.4, green: 0.6, blue: 0.8)
    static let templeGold = Color(red: 0.847, green: 0.686, blue: 0.259)

    // Dark mode colors
    static let nepaliRedDark = Color(red: 0.95, green: 0.3, blue: 0.4)
    static let nepaliBlueDark = Color(red: 0.4, green: 0.6, blue: 0.85)
    static let nepaliOrangeDark = Color(red: 1.0, green: 0.6, blue: 0.35)
    static let himalayanBlueDark = Color(red: 0.5, green: 0.7, blue: 0.9)
    static let templeGoldDark = Color(red: 0.95, green: 0.8, blue: 0.4)
}



// MARK: - Timeline Provider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> NepaliDateEntry {
        NepaliDateEntry.sampleDate
    }

    func getSnapshot(in context: Context, completion: @escaping (NepaliDateEntry) -> ()) {
        completion(NepaliDateEntry.sampleDate)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let converter = NepaliDateConverter()
        let now = Date()


            // Create entry with converted values
            let entry = NepaliDateEntry(
                date: now,
                nepaliYear: converter.currentNepaliYear,
                nepaliMonth: converter.currentNepaliMonth,
                nepaliDay: converter.currentNepaliDay,
                weekday: converter.currentWeekDay
            )
        // Update at midnight
        let nextMidnight = Calendar.current.nextDate(
            after: now,
            matching: DateComponents(hour: 0, minute: 0),
            matchingPolicy: .nextTime
        )!

        let timeline = Timeline(entries: [entry], policy: .after(nextMidnight))
        completion(timeline)
    }
}

// MARK: - Timeline Entry
struct NepaliDateEntry: TimelineEntry {
    let date: Date
    let nepaliYear: Int
    let nepaliMonth: String
    let nepaliDay: Int
    let weekday: String

    static let converter = NepaliDateConverter()
    static let now = Date()


    static let sampleDate = NepaliDateEntry(
        date: now,
        nepaliYear: converter.currentNepaliYear,
        nepaliMonth: converter.currentNepaliMonth,
        nepaliDay: converter.currentNepaliDay,
        weekday: converter.currentWeekDay
    )
}

struct NepaliDateSmallWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    let entry: NepaliDateEntry

    private var accent: Color {
        colorScheme == .dark ? .nepaliRedDark : .nepaliRed
    }

    var body: some View {
        ZStack {
            // Minimal background
            LinearGradient(
                colors: colorScheme == .dark
                    ? [Color(red: 0.12, green: 0.12, blue: 0.14),
                       Color(red: 0.10, green: 0.10, blue: 0.12)]
                    : [Color(red: 0.98, green: 0.98, blue: 0.97),
                       Color(red: 0.95, green: 0.96, blue: 0.97)],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(spacing: 6) {

                // Month
                Text(entry.nepaliMonth.uppercased())
                    .font(.system(size: 15, weight: .semibold))
                    .tracking(1)
                    .foregroundColor(.black)

                // Day (main focus)
                Text(String(entry.nepaliDay))
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.primary)

                // Weekday
                Text(entry.weekday)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))

                // Year
                Text(String(entry.nepaliYear))
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.black.opacity(0.7))
            }
            .padding()
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}


// MARK: - Medium Widget (Home Screen)
struct NepaliDateMediumWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    let entry: NepaliDateEntry

    private var primaryRed: Color {
        colorScheme == .dark ? .nepaliRedDark : .nepaliRed
    }

    private var primaryBlue: Color {
        colorScheme == .dark ? .nepaliBlueDark : .nepaliBlue
    }

    private var primaryOrange: Color {
        colorScheme == .dark ? .nepaliOrangeDark : .nepaliOrange
    }

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: colorScheme == .dark ? [
                    Color(red: 0.12, green: 0.12, blue: 0.15),
                    Color(red: 0.15, green: 0.13, blue: 0.16)
                ] : [
                    Color(red: 0.98, green: 0.95, blue: 0.93),
                    Color(red: 0.96, green: 0.94, blue: 0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            HStack(spacing: 16) {
                // Left side - Large day number
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [primaryRed.opacity(0.15), primaryOrange.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)

                    Text("\(entry.nepaliDay)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [primaryRed, primaryOrange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }

                // Right side - Date info
                VStack(alignment: .leading, spacing: 6) {
                    Text(String(entry.nepaliYear))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)

                    Text(entry.nepaliMonth)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(
                            .black
                        )

                    Text(entry.weekday)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [primaryRed, primaryOrange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }

                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Lock Screen Widgets

struct NepaliDateInlineView: View {
    let entry: NepaliDateEntry

    var body: some View {
        Text("\(entry.weekday)")
            .font(.system(size: 14, weight: .medium))
    }
}


struct NepaliDateRectangularView: View {
    let entry: NepaliDateEntry

    var body: some View {
        HStack(spacing: 8) {
                Text("\(entry.weekday), \(entry.nepaliDay) \(entry.nepaliMonth)")
                    .font(.system(size: 24, weight: .medium))
        }
    }
}

// MARK: - Main Widget View
struct NepaliDateWidgetView: View {
    @Environment(\.widgetFamily) var family
    let entry: NepaliDateEntry

    var body: some View {
        switch family {
        case .systemSmall:
            NepaliDateSmallWidgetView(entry: entry)

        case .systemMedium:
            NepaliDateMediumWidgetView(entry: entry)

        case .accessoryRectangular:
            NepaliDateRectangularView(entry: entry)

        default:
            EmptyView()
        }
    }
}

// MARK: - Widget Configuration
struct NepaliDateWidget: Widget {
    let kind: String = "NepaliDateWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                NepaliDateWidgetView(entry: entry)
                    .containerBackground(.clear, for: .widget)
            } else {
                NepaliDateWidgetView(entry: entry)
            }
        }
        .configurationDisplayName("नेपाली मिति")
        .description("आजको नेपाली मिति हेर्नुहोस्")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .accessoryInline,
            .accessoryCircular,
            .accessoryRectangular
        ])
    }
}

// MARK: - Previews
#Preview("Small Widget", as: .systemSmall) {
    NepaliDateWidget()
} timeline: {
    NepaliDateEntry.sampleDate
}

#Preview("Medium Widget", as: .systemMedium) {
    NepaliDateWidget()
} timeline: {
    NepaliDateEntry.sampleDate
}

#Preview("Lock Screen - Rectangular", as: .accessoryRectangular) {
    NepaliDateWidget()
} timeline: {
    NepaliDateEntry.sampleDate
}

