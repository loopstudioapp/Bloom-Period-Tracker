import SwiftUI

struct MonthCalendarGrid: View {
    let month: Int
    let year: Int
    var fertileDays: Set<Int> = []
    var ovulationDay: Int? = nil
    var todayDay: Int? = nil
    var periodPredictionDays: Set<Int> = []
    var nextPeriodDay: Int? = nil

    private let dayHeaders = ["M", "T", "W", "T", "F", "S", "S"]
    private let columns = Array(repeating: GridItem(.flexible(), spacing: .zero), count: 7)

    var body: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            // Day-of-week headers
            HStack(spacing: .zero) {
                ForEach(dayHeaders.indices, id: \.self) { index in
                    Text(dayHeaders[index])
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .frame(maxWidth: .infinity)
                }
            }

            // Calendar grid
            LazyVGrid(columns: columns, spacing: AppTheme.Spacing.sm) {
                // Leading empty cells for weekday offset
                ForEach(0..<startingWeekday, id: \.self) { _ in
                    Color.clear
                        .frame(height: cellSize)
                }

                // Day cells
                ForEach(1...daysInMonth, id: \.self) { day in
                    dayCell(for: day)
                        .frame(height: cellSize)
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            // "NEXT PERIOD" badge overlay
            if let nextDay = nextPeriodDay {
                nextPeriodBadge
                    .offset(x: AppTheme.Spacing.sm, y: AppTheme.Spacing.sm)
            }
        }
    }

    // MARK: - Day Cell

    @ViewBuilder
    private func dayCell(for day: Int) -> some View {
        ZStack {
            // Today background
            if day == todayDay {
                Circle()
                    .fill(AppTheme.Colors.textSecondary.opacity(0.2))
                    .frame(width: circleSize, height: circleSize)
            }

            // Ovulation dashed circle
            if day == ovulationDay {
                Circle()
                    .strokeBorder(AppTheme.Colors.tealAccent, style: StrokeStyle(lineWidth: 1.5, dash: [3, 2]))
                    .frame(width: circleSize, height: circleSize)
            }

            // Next period badge circle
            if day == nextPeriodDay {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [AppTheme.Colors.primaryPink, AppTheme.Colors.primaryPinkDark],
                            center: .center,
                            startRadius: .zero,
                            endRadius: circleSize / 2
                        )
                    )
                    .frame(width: circleSize, height: circleSize)
            }

            Text("\(day)")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(dayTextColor(for: day))
        }
    }

    // MARK: - Next Period Badge

    private var nextPeriodBadge: some View {
        Group {
            if nextPeriodDay != nil {
                Text("NEXT\nPERIOD")
                    .font(AppTheme.Fonts.captionBold)
                    .foregroundColor(AppTheme.Colors.textWhite)
                    .multilineTextAlignment(.center)
                    .padding(AppTheme.Spacing.xs)
                    .background(
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [AppTheme.Colors.primaryPink, AppTheme.Colors.primaryPinkDark],
                                    center: .center,
                                    startRadius: .zero,
                                    endRadius: badgeSize / 2
                                )
                            )
                            .frame(width: badgeSize, height: badgeSize)
                    )
            }
        }
    }

    // MARK: - Color Logic

    private func dayTextColor(for day: Int) -> Color {
        if day == nextPeriodDay {
            return AppTheme.Colors.textWhite
        } else if periodPredictionDays.contains(day) {
            return AppTheme.Colors.primaryPink
        } else if fertileDays.contains(day) {
            return AppTheme.Colors.tealAccent
        } else {
            return AppTheme.Colors.textPrimary
        }
    }

    // MARK: - Date Calculations

    private var startingWeekday: Int {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Monday
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        guard let date = calendar.date(from: components) else { return 0 }
        let weekday = calendar.component(.weekday, from: date)
        // Convert: Sunday=1..Saturday=7 -> Monday=0..Sunday=6
        return (weekday + 5) % 7
    }

    private var daysInMonth: Int {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        guard let date = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: date) else {
            return 30
        }
        return range.count
    }

    // MARK: - Sizes

    private var cellSize: CGFloat { AppTheme.Spacing.xxl + AppTheme.Spacing.sm }
    private var circleSize: CGFloat { AppTheme.ResponsiveLayout.scaled(AppTheme.Spacing.xxl) }
    private var badgeSize: CGFloat { AppTheme.ResponsiveLayout.scaled(AppTheme.Spacing.xxxl + AppTheme.Spacing.md) }
}

#Preview {
    MonthCalendarGrid(
        month: 2,
        year: 2026,
        fertileDays: [12, 13, 14, 15, 16],
        ovulationDay: 14,
        todayDay: 8,
        periodPredictionDays: [26, 27, 28],
        nextPeriodDay: 26
    )
    .padding(AppTheme.Spacing.xl)
}
