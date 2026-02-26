import SwiftUI

struct SelfCareItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
}

@MainActor
class TodayViewModel: ObservableObject {
    private let cycle = CycleService.shared

    @Published var dailyInsights: [DailyInsight] = MainInsightData.todayInsights
    @Published var isUpdatingPredictions: Bool = false
    @Published var notificationCount: Int = 1
    @Published var showDailyLogging: Bool = false
    @Published var showCalendar: Bool = false
    @Published var showSettings: Bool = false

    // MARK: - Computed from CycleService

    var currentCycleDay: Int { cycle.currentCycleDay }
    var periodDay: Int { cycle.periodDay }
    var fertileDaysAway: Int { cycle.fertileDaysAway }
    var hasData: Bool { cycle.hasData }
    var isOnPeriod: Bool { cycle.isOnPeriod }

    var currentMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: Date())
    }

    var periodText: String { "Day \(periodDay)" }

    var currentCycle: CycleEntry? { cycle.currentCycle }
    var previousCycles: [CycleEntry] { cycle.previousCycles }

    var weekDays: [WeekDay] {
        let cal = Calendar.current
        let today = Date()
        let weekday = cal.component(.weekday, from: today)
        let startOfWeek = cal.date(byAdding: .day, value: -(weekday - 2), to: today)!

        let cycleStart = cycle.currentCycleStartDate ?? today
        let periodLen = cycle.periodLength
        let ovDay = cycle.ovulationDay

        return (0..<7).map { offset in
            let date = cal.date(byAdding: .day, value: offset, to: startOfWeek)!
            let day = cal.component(.day, from: date)
            let letters = ["M", "T", "W", "T", "F", "S", "S"]
            let isToday = cal.isDateInToday(date)

            let daysSinceCycleStart = cal.dateComponents([.day], from: cycleStart, to: date).day ?? -1
            let isPeriod = daysSinceCycleStart >= 0 && daysSinceCycleStart < periodLen
            let isFertile = daysSinceCycleStart >= (ovDay - 3) && daysSinceCycleStart <= (ovDay + 2)

            return WeekDay(
                date: date,
                dayNumber: day,
                dayLetter: letters[offset],
                isPeriod: isPeriod,
                isToday: isToday,
                isFertile: isFertile && !isPeriod
            )
        }
    }

    let selfCareItems: [SelfCareItem] = [
        SelfCareItem(icon: "heart.text.clipboard", title: "Sex for\nperiod relief"),
        SelfCareItem(icon: "figure.mind.and.body", title: "How to get\npregnant"),
        SelfCareItem(icon: "hand.raised.fingers.spread", title: "Trying, but no\npregnancy")
    ]

    var cycleSummaryMetrics: [CycleMetric] { cycle.cycleSummaryMetrics }

    let symptomPatterns: [SymptomPattern] = [
        SymptomPattern(
            symptomName: "Fatigue",
            icon: "battery.50percent",
            iconColor: AppTheme.Colors.primaryPink,
            description: "You logged fatigue during your period, just like 67% of Bloom users. Log more symptoms to see your patterns and medical comments.",
            percentage: 67,
            cycleData: [
                [.period, .period, .period, .symptom, .normal, .normal, .normal, .normal, .fertile, .fertile, .ovulation, .normal],
                [.period, .period, .period, .period, .period, .normal, .normal, .normal, .fertile, .fertile, .ovulation, .normal]
            ]
        )
    ]

}
