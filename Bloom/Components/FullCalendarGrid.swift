import SwiftUI

struct FullCalendarGrid: View {
    @ObservedObject var viewModel: CalendarViewModel
    var onDayTap: ((Date) -> Void)? = nil

    private let dayHeaders = ["M", "T", "W", "T", "F", "S", "S"]
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)

    var body: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            // Month title
            Text(viewModel.monthTitle(for: viewModel.displayedMonth))
                .font(AppTheme.Fonts.title3)
                .foregroundColor(AppTheme.Colors.textPrimary)

            // Day headers
            HStack(spacing: 0) {
                ForEach(dayHeaders, id: \.self) { header in
                    Text(header)
                        .font(AppTheme.Fonts.captionBold)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .frame(maxWidth: .infinity)
                }
            }

            // Calendar grid
            let days = viewModel.daysInMonth(for: viewModel.displayedMonth)
            let leadingBlanks = viewModel.firstWeekdayOfMonth(for: viewModel.displayedMonth)

            LazyVGrid(columns: columns, spacing: AppTheme.Spacing.sm) {
                // Leading blank cells
                ForEach(0..<leadingBlanks, id: \.self) { _ in
                    Color.clear
                        .frame(height: 40)
                }

                // Day cells
                ForEach(days, id: \.self) { date in
                    FullCalendarDayCell(
                        date: date,
                        state: viewModel.dayState(for: date),
                        isSelected: viewModel.selectedDay.map { Calendar.current.isDate($0, inSameDayAs: date) } ?? false,
                        onTap: {
                            viewModel.selectedDay = date
                            onDayTap?(date)
                        }
                    )
                }
            }
        }
    }
}

// MARK: - Day Cell

private struct FullCalendarDayCell: View {
    let date: Date
    let state: DayState
    let isSelected: Bool
    let onTap: () -> Void

    @State private var animationScale: CGFloat = 1.0

    private var dayNumber: String {
        let cal = Calendar.current
        return "\(cal.component(.day, from: date))"
    }

    var body: some View {
        Button(action: {
            withAnimation(AppTheme.Animation.quick) {
                animationScale = 1.1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(AppTheme.Animation.quick) {
                    animationScale = 1.0
                }
            }
            onTap()
        }) {
            ZStack {
                // Background based on state
                backgroundForState()

                Text(dayNumber)
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(textColorForState())
            }
            .frame(width: 36, height: 36)
            .scaleEffect(animationScale)
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private func backgroundForState() -> some View {
        switch state {
        case .period:
            Circle()
                .fill(AppTheme.Colors.calendarPeriodCircle)

        case .today:
            Circle()
                .fill(AppTheme.Colors.calendarTodayCircle)

        case .predictedPeriod:
            Circle()
                .strokeBorder(AppTheme.Colors.calendarPeriodCircle, style: StrokeStyle(lineWidth: 1.5, dash: [4, 3]))

        case .ovulation, .predictedOvulation:
            Circle()
                .strokeBorder(AppTheme.Colors.calendarFertileText, style: StrokeStyle(lineWidth: 1.5, dash: [2, 2]))

        case .fertile:
            Color.clear

        case .normal:
            Color.clear
        }
    }

    private func textColorForState() -> Color {
        switch state {
        case .period:
            return AppTheme.Colors.textWhite
        case .today:
            return AppTheme.Colors.textWhite
        case .predictedPeriod:
            return AppTheme.Colors.calendarPeriodCircle
        case .fertile:
            return AppTheme.Colors.calendarFertileText
        case .ovulation, .predictedOvulation:
            return AppTheme.Colors.calendarFertileText
        case .normal:
            return AppTheme.Colors.textPrimary
        }
    }
}

#Preview {
    FullCalendarGrid(viewModel: CalendarViewModel())
        .padding()
}
