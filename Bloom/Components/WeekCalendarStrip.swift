import SwiftUI

struct WeekCalendarStrip: View {
    var today: Date = Date()
    var periodPredictionDays: Set<Int> = []

    var body: some View {
        let calendar = Calendar.current
        let weekDays = generateWeekDays(for: today, using: calendar)

        HStack(spacing: 0) {
            ForEach(weekDays, id: \.date) { day in
                VStack(spacing: AppTheme.Spacing.xs) {
                    // Day header (M, T, W, etc.)
                    Text(day.shortName)
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textTertiary)

                    // Date number
                    ZStack {
                        // Today highlight circle
                        if day.isToday {
                            Circle()
                                .fill(AppTheme.Colors.primaryPink)
                                .frame(width: dayCircleSize, height: dayCircleSize)
                        }

                        // Period prediction dotted circle
                        if periodPredictionDays.contains(day.dayNumber) && !day.isToday {
                            Circle()
                                .strokeBorder(
                                    AppTheme.Colors.primaryPink,
                                    style: StrokeStyle(lineWidth: dottedLineWidth, dash: [dottedDashLength])
                                )
                                .frame(width: dayCircleSize, height: dayCircleSize)
                        }

                        Text("\(day.dayNumber)")
                            .font(day.isToday ? AppTheme.Fonts.bodyBold : AppTheme.Fonts.body)
                            .foregroundColor(
                                day.isToday
                                    ? AppTheme.Colors.textWhite
                                    : AppTheme.Colors.textPrimary
                            )
                    }
                    .frame(width: dayCircleSize, height: dayCircleSize)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, AppTheme.Spacing.sm)
        .padding(.horizontal, AppTheme.Spacing.xs)
    }

    // MARK: - Data Generation

    private func generateWeekDays(for date: Date, using calendar: Calendar) -> [WeekCalendarDay] {
        let weekday = calendar.component(.weekday, from: date)
        // Calculate the Monday of the current week (weekday: 1 = Sunday, 2 = Monday, ...)
        let daysFromMonday = (weekday + 5) % 7
        guard let monday = calendar.date(byAdding: .day, value: -daysFromMonday, to: date) else {
            return []
        }

        let todayDay = calendar.component(.day, from: date)
        let todayMonth = calendar.component(.month, from: date)
        let todayYear = calendar.component(.year, from: date)

        return (0..<7).compactMap { offset in
            guard let dayDate = calendar.date(byAdding: .day, value: offset, to: monday) else {
                return nil
            }

            let dayComponent = calendar.component(.day, from: dayDate)
            let monthComponent = calendar.component(.month, from: dayDate)
            let yearComponent = calendar.component(.year, from: dayDate)
            let isToday = dayComponent == todayDay && monthComponent == todayMonth && yearComponent == todayYear

            let formatter = DateFormatter()
            formatter.dateFormat = "EEEEE"
            let shortName = formatter.string(from: dayDate)

            return WeekCalendarDay(
                date: dayDate,
                shortName: shortName,
                dayNumber: dayComponent,
                isToday: isToday
            )
        }
    }

    // MARK: - Constants

    private var dayCircleSize: CGFloat { AppTheme.Spacing.xxl + AppTheme.Spacing.xs }
    private var dottedLineWidth: CGFloat { AppTheme.Spacing.xxs }
    private var dottedDashLength: CGFloat { AppTheme.Spacing.xs }
}

// MARK: - WeekDay Model

private struct WeekCalendarDay {
    let date: Date
    let shortName: String
    let dayNumber: Int
    let isToday: Bool
}

#Preview {
    VStack(spacing: AppTheme.Spacing.xl) {
        WeekCalendarStrip()

        WeekCalendarStrip(periodPredictionDays: [11, 12, 13])
    }
    .padding(AppTheme.Spacing.xl)
    .background(AppTheme.Colors.background)
}
