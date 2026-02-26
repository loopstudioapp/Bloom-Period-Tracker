import SwiftUI

@MainActor
class AnalyticsViewModel: ObservableObject {
    private let cycle = CycleService.shared

    var averageCycleLength: Int { cycle.cycleLength }
    var averagePeriodLength: Int { cycle.periodLength }

    struct CycleBar: Identifiable {
        let id = UUID()
        let label: String
        let dateRange: String
        let periodDays: Int
        let totalDays: Int
        let isCurrent: Bool
    }

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMM d, yyyy"
        return f
    }()

    private static let shortDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMM d"
        return f
    }()

    var cycleBars: [CycleBar] {
        var bars: [CycleBar] = []

        if let current = cycle.currentCycle {
            let startStr = Self.shortDateFormatter.string(from: current.startDate)
            let endDate = cycle.nextCycleStart(from: current.startDate)
            let endStr = Self.shortDateFormatter.string(from: endDate)
            bars.append(CycleBar(
                label: "CURRENT CYCLE",
                dateRange: "\(startStr) – \(endStr)",
                periodDays: current.periodLength,
                totalDays: cycle.cycleLength,
                isCurrent: true
            ))
        }

        for prev in cycle.previousCycles {
            let startStr = Self.dateFormatter.string(from: prev.startDate)
            let endStr = Self.dateFormatter.string(from: prev.endDate ?? prev.startDate)
            bars.append(CycleBar(
                label: "",
                dateRange: "\(startStr) – \(endStr)",
                periodDays: prev.periodLength,
                totalDays: prev.cycleLength ?? cycle.cycleLength,
                isCurrent: false
            ))
        }

        return bars
    }

    var periodBars: [CycleBar] {
        var bars: [CycleBar] = []

        if let current = cycle.currentCycle {
            let startStr = Self.shortDateFormatter.string(from: current.startDate)
            let periodEnd = cycle.predictedPeriodEnd(from: current.startDate)
            let endStr = Self.shortDateFormatter.string(from: periodEnd)
            bars.append(CycleBar(
                label: "CURRENT PERIOD",
                dateRange: "\(startStr) – \(endStr)",
                periodDays: current.periodLength,
                totalDays: cycle.periodLength,
                isCurrent: true
            ))
        }

        for prev in cycle.previousCycles {
            let startStr = Self.dateFormatter.string(from: prev.startDate)
            let periodEnd = prev.endDate ?? cycle.predictedPeriodEnd(from: prev.startDate)
            let endStr = Self.dateFormatter.string(from: periodEnd)
            bars.append(CycleBar(
                label: "",
                dateRange: "\(startStr) – \(endStr)",
                periodDays: prev.periodLength,
                totalDays: prev.periodLength,
                isCurrent: false
            ))
        }

        return bars
    }

    let eventCategories = ["Symptoms", "Steps", "Weight", "Vaginal Discharge", "Mood", "Water"]

    struct WeightDataPoint: Identifiable {
        let id = UUID()
        let date: Date
        let weight: Double
    }

    var weightData: [WeightDataPoint] {
        // No weight persistence layer yet
        []
    }
}
