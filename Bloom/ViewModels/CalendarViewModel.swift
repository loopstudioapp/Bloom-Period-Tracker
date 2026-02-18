import SwiftUI

@MainActor
class CalendarViewModel: ObservableObject {
    @Published var displayedMonth: Date = Date()
    @Published var selectedDay: Date? = nil
    @Published var viewMode: CalendarViewMode = .month

    let periodStartDate: Date = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
    let periodLength: Int = 5
    let cycleLength: Int = 29

    var predictedOvulationDate: Date {
        Calendar.current.date(byAdding: .day, value: 14, to: periodStartDate)!
    }

    var fertileWindowStart: Date {
        Calendar.current.date(byAdding: .day, value: -3, to: predictedOvulationDate)!
    }

    var fertileWindowEnd: Date {
        Calendar.current.date(byAdding: .day, value: 2, to: predictedOvulationDate)!
    }

    func dayState(for date: Date) -> DayState {
        let cal = Calendar.current

        if cal.isDateInToday(date) && !isPeriodDay(date) {
            return .today
        }

        let daysSincePeriodStart = cal.dateComponents([.day], from: periodStartDate, to: date).day ?? 0

        if daysSincePeriodStart >= 0 && daysSincePeriodStart < periodLength {
            if daysSincePeriodStart < 4 {
                return .period(dayNumber: daysSincePeriodStart + 1)
            } else {
                return .predictedPeriod
            }
        }

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
        guard Calendar.current.isDateInToday(date) else { return nil }
        return DayLog(
            date: date,
            symptoms: ["Fatigue", "Cramps"],
            menstrualFlow: .medium,
            sexActivity: [],
            waterOz: 16,
            weightLbs: 132.1,
            steps: 157,
            basalTemp: nil,
            mood: nil
        )
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
