import SwiftUI

@MainActor
class CalendarViewModel: ObservableObject {
    @Published var displayedMonth: Date = Date()
    @Published var selectedDay: Date? = nil
    @Published var viewMode: CalendarViewMode = .month

    private let cycle = CycleService.shared

    var periodStartDate: Date {
        cycle.currentCycleStartDate ?? Date()
    }

    var periodLength: Int { cycle.periodLength }
    var cycleLength: Int { cycle.cycleLength }

    var predictedOvulationDate: Date {
        cycle.predictedOvulation(from: periodStartDate)
    }

    var fertileWindowStart: Date {
        cycle.fertileWindow(from: periodStartDate).start
    }

    var fertileWindowEnd: Date {
        cycle.fertileWindow(from: periodStartDate).end
    }

    func dayState(for date: Date) -> DayState {
        let cal = Calendar.current

        guard cycle.hasData else { return cal.isDateInToday(date) ? .today : .normal }

        if cal.isDateInToday(date) && !isPeriodDay(date) {
            return .today
        }

        let daysSincePeriodStart = cal.dateComponents([.day], from: periodStartDate, to: date).day ?? 0

        // Current cycle period days
        if daysSincePeriodStart >= 0 && daysSincePeriodStart < periodLength {
            return .period(dayNumber: daysSincePeriodStart + 1)
        }

        // Predicted next cycle period
        let nextCycleStart = cycle.nextCycleStart(from: periodStartDate)
        let daysSinceNextStart = cal.dateComponents([.day], from: nextCycleStart, to: date).day ?? 0
        if daysSinceNextStart >= 0 && daysSinceNextStart < periodLength {
            return .predictedPeriod
        }

        // Fertile window and ovulation
        if date >= fertileWindowStart && date <= fertileWindowEnd {
            if cal.isDate(date, inSameDayAs: predictedOvulationDate) {
                return .ovulation
            }
            return .fertile
        }

        return .normal
    }

    func isPeriodDay(_ date: Date) -> Bool {
        let daysSince = Calendar.current.dateComponents([.day], from: periodStartDate, to: date).day ?? -1
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
