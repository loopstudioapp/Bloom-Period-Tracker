import SwiftUI

@MainActor
class AnalyticsViewModel: ObservableObject {
    @Published var averageCycleLength: Int = 30
    @Published var averagePeriodLength: Int = 5

    struct CycleBar: Identifiable {
        let id = UUID()
        let label: String
        let dateRange: String
        let periodDays: Int
        let totalDays: Int
        let isCurrent: Bool
    }

    var cycleBars: [CycleBar] {
        [
            CycleBar(label: "CURRENT CYCLE", dateRange: "Jan 25 - Feb 22", periodDays: 4, totalDays: 29, isCurrent: true),
            CycleBar(label: "", dateRange: "Dec 26, 2023 - Jan 24, 2024", periodDays: 5, totalDays: 30, isCurrent: false)
        ]
    }

    var periodBars: [CycleBar] {
        [
            CycleBar(label: "CURRENT PERIOD", dateRange: "Jan 25 – Jan 29", periodDays: 4, totalDays: 5, isCurrent: true),
            CycleBar(label: "", dateRange: "Dec 26, 2023 – Dec 30, 2023", periodDays: 5, totalDays: 5, isCurrent: false)
        ]
    }

    let eventCategories = ["Symptoms", "Steps", "Weight", "Vaginal Discharge", "Mood", "Water"]

    struct WeightDataPoint: Identifiable {
        let id = UUID()
        let date: Date
        let weight: Double
    }

    var weightData: [WeightDataPoint] {
        [WeightDataPoint(date: Date(), weight: 132.1)]
    }
}
