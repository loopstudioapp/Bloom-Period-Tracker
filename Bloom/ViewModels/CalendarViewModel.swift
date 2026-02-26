import SwiftUI

@MainActor
class CalendarViewModel: ObservableObject {
    @Published var displayedMonth: Date = Date()
    @Published var selectedDay: Date? = nil
    @Published var viewMode: CalendarViewMode = .month

    private let cycle = CycleService.shared

    /// The start date of the current cycle, or nil if user has no data.
    var periodStartDate: Date? {
        cycle.currentCycleStartDate
    }

    var periodLength: Int { cycle.periodLength }
    var cycleLength: Int { cycle.cycleLength }

    var predictedOvulationDate: Date? {
        guard let start = periodStartDate else { return nil }
        return cycle.predictedOvulation(from: start)
    }

    var fertileWindowStart: Date? {
        guard let start = periodStartDate else { return nil }
        return cycle.fertileWindow(from: start).start
    }

    var fertileWindowEnd: Date? {
        guard let start = periodStartDate else { return nil }
        return cycle.fertileWindow(from: start).end
    }

    func dayState(for date: Date) -> DayState {
        let cal = Calendar.current

        guard cycle.hasData, let start = periodStartDate else {
            return cal.isDateInToday(date) ? .today : .normal
        }

        if cal.isDateInToday(date) && !isPeriodDay(date) {
            return .today
        }

        let daysSincePeriodStart = cal.dateComponents([.day], from: start, to: date).day ?? 0

        // Current cycle period days
        if daysSincePeriodStart >= 0 && daysSincePeriodStart < periodLength {
            return .period(dayNumber: daysSincePeriodStart + 1)
        }

        // Predicted next cycle period
        let nextCycleStart = cycle.nextCycleStart(from: start)
        let daysSinceNextStart = cal.dateComponents([.day], from: nextCycleStart, to: date).day ?? 0
        if daysSinceNextStart >= 0 && daysSinceNextStart < periodLength {
            return .predictedPeriod
        }

        // Fertile window and ovulation
        if let fStart = fertileWindowStart, let fEnd = fertileWindowEnd,
           date >= fStart && date <= fEnd {
            if let ovDate = predictedOvulationDate, cal.isDate(date, inSameDayAs: ovDate) {
                return .ovulation
            }
            return .fertile
        }

        return .normal
    }

    func isPeriodDay(_ date: Date) -> Bool {
        guard let start = periodStartDate else { return false }
        let daysSince = Calendar.current.dateComponents([.day], from: start, to: date).day ?? -1
        return daysSince >= 0 && daysSince < periodLength
    }

    func dayLog(for date: Date) -> DayLog? {
        // No persistence layer yet — return nil for all days
        return nil
    }

    func daysInMonth(for date: Date) -> [Date] {
        let cal = Calendar.current
        let range = cal.range(of: .day, in: .month, for: date)!
        let firstDay = cal.date(from: cal.dateComponents([.year, .month], from: date))!
        return range.map { day in
            cal.date(byAdding: .day, value: day - 1, to: firstDay)!
        }
    }

    func firstWeekdayOfMonth(for date: Date) -> Int {
        let cal = Calendar.current
        let firstDay = cal.date(from: cal.dateComponents([.year, .month], from: date))!
        let weekday = cal.component(.weekday, from: firstDay)
        return (weekday + 5) % 7 // Monday = 0
    }

    func monthTitle(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

enum CalendarViewMode: String, CaseIterable {
    case month = "Month"
    case year = "Year"
}
