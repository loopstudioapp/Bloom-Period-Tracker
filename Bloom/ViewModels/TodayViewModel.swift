import SwiftUI

@MainActor
class TodayViewModel: ObservableObject {
    @Published var currentCycleDay: Int = 4
    @Published var periodDay: Int = 4
    @Published var currentMonth: String = "January"
    @Published var dailyInsights: [DailyInsight] = MainInsightData.todayInsights
    @Published var isUpdatingPredictions: Bool = false
    @Published var showHealthAssistantPopup: Bool = true
    @Published var healthAssistantMessage: String = "Hi! I noticed that you logged mood swings. Do you want to talk about it?"
    @Published var notificationCount: Int = 1
    @Published var showDailyLogging: Bool = false
    @Published var showCalendar: Bool = false
    @Published var showSettings: Bool = false
    @Published var showHealthChat: Bool = false

    var periodText: String { "Day \(periodDay)" }

    let currentCycle = CycleEntry(
        startDate: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
        endDate: nil,
        periodLength: 4,
        cycleLength: nil,
        isCurrentCycle: true
    )

    let previousCycles: [CycleEntry] = [
        CycleEntry(
            startDate: Calendar.current.date(byAdding: .day, value: -33, to: Date())!,
            endDate: Calendar.current.date(byAdding: .day, value: -4, to: Date()),
            periodLength: 5,
            cycleLength: 30,
            isCurrentCycle: false
        )
    ]

    var weekDays: [WeekDay] {
        let cal = Calendar.current
        let today = Date()
        let weekday = cal.component(.weekday, from: today)
        let startOfWeek = cal.date(byAdding: .day, value: -(weekday - 2), to: today)!

        return (0..<7).map { offset in
            let date = cal.date(byAdding: .day, value: offset, to: startOfWeek)!
            let day = cal.component(.day, from: date)
            let letters = ["M", "T", "W", "T", "F", "S", "S"]
            let periodStartDay = cal.component(.day, from: currentCycle.startDate)
            let isPeriod = day >= periodStartDay && day < periodStartDay + 4
            return WeekDay(
                date: date,
                dayNumber: day,
                dayLetter: letters[offset],
                isPeriod: isPeriod,
                isToday: cal.isDateInToday(date),
                isFertile: false
            )
        }
    }

    let cycleSummaryMetrics: [CycleMetric] = [
        CycleMetric(label: "Previous cycle length", value: "30 days", status: .abnormal, statusLabel: "ABNORMAL"),
        CycleMetric(label: "Previous period length", value: "5 days", status: .normal, statusLabel: "NORMAL"),
        CycleMetric(label: "Cycle length variation", value: "26–37 days", status: .irregular, statusLabel: "IRREGULAR")
    ]

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

    func dismissHealthAssistantPopup() {
        withAnimation(AppTheme.Animation.standard) {
            showHealthAssistantPopup = false
        }
    }
}
