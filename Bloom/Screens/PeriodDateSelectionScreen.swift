import SwiftUI

struct PeriodDateSelectionScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    @State private var startDate: Date?
    @State private var endDate: Date?
    @State private var displayedMonth: Date = Date()

    private let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let calendar = Calendar.current

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.lg) {
                    headerText

                    calendarSection

                    legendRow
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(title: "Next", style: .teal, isEnabled: hasSelection) {
                viewModel.recentPeriodStartDate = startDate
                viewModel.recentPeriodEndDate = endDate
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
    }

    private var hasSelection: Bool {
        startDate != nil && endDate != nil
    }

    // MARK: - Header

    private var headerText: some View {
        Text("Tap the start and end dates of your most recent period.")
            .font(AppTheme.Fonts.body)
            .foregroundColor(AppTheme.Colors.textSecondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }

    // MARK: - Calendar

    private var calendarSection: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            monthHeader

            weekdayHeader

            calendarGrid
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.large)
        .cardShadow()
    }

    private var monthHeader: some View {
        HStack {
            Button {
                withAnimation(AppTheme.Animation.quick) {
                    displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textTertiary)
            }

            Spacer()

            Text(monthYearString)
                .font(AppTheme.Fonts.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            Button {
                withAnimation(AppTheme.Animation.quick) {
                    displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textTertiary)
            }
        }
    }

    private var weekdayHeader: some View {
        HStack(spacing: .zero) {
            ForEach(weekdays, id: \.self) { day in
                Text(day)
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textTertiary)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private var calendarGrid: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: .zero), count: 7)
        let info = daysInMonth()
        return LazyVGrid(columns: columns, spacing: AppTheme.Spacing.sm) {
            ForEach(0..<info.offset, id: \.self) { _ in
                Text("")
                    .frame(height: AppTheme.Spacing.xxl)
            }

            ForEach(1...info.totalDays, id: \.self) { day in
                dayCell(day: day)
            }
        }
    }

    @ViewBuilder
    private func dayCell(day: Int) -> some View {
        let date = makeDate(day: day)
        let isInRange = isDateInRange(date)
        let isStart = isSameDay(date, startDate)
        let isEnd = isSameDay(date, endDate)
        let isToday = calendar.isDateInToday(date)
        let isFuture = date > Date()

        ZStack {
            if isStart || isEnd {
                Circle()
                    .fill(AppTheme.Colors.primaryPink)
            } else if isInRange {
                Circle()
                    .fill(AppTheme.Colors.primaryPink.opacity(0.3))
            } else if isToday {
                Circle()
                    .stroke(AppTheme.Colors.primaryPink, lineWidth: 2)
            }

            Text("\(day)")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(
                    (isStart || isEnd)
                        ? AppTheme.Colors.textWhite
                        : isFuture
                            ? AppTheme.Colors.textTertiary
                            : AppTheme.Colors.textPrimary
                )
        }
        .frame(height: AppTheme.Spacing.xxl)
        .contentShape(Rectangle())
        .onTapGesture {
            guard !isFuture else { return }
            handleTap(date)
        }
    }

    // MARK: - Legend

    private var legendRow: some View {
        HStack(spacing: AppTheme.Spacing.lg) {
            legendItem(color: AppTheme.Colors.primaryPink, label: "Period")
            legendItem(color: AppTheme.Colors.primaryPink.opacity(0.3), label: "Range")
        }
    }

    private func legendItem(color: Color, label: String) -> some View {
        HStack(spacing: AppTheme.Spacing.xs) {
            Circle()
                .fill(color)
                .frame(width: AppTheme.Spacing.sm, height: AppTheme.Spacing.sm)

            Text(label)
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }

    // MARK: - Helpers

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: displayedMonth)
    }

    private func daysInMonth() -> (totalDays: Int, offset: Int) {
        let range = calendar.range(of: .day, in: .month, for: firstOfMonth())!
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth())
        let offset = (firstWeekday + 5) % 7
        return (range.count, offset)
    }

    private func firstOfMonth() -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))!
    }

    private func makeDate(day: Int) -> Date {
        var components = calendar.dateComponents([.year, .month], from: displayedMonth)
        components.day = day
        return calendar.date(from: components)!
    }

    private func isSameDay(_ a: Date?, _ b: Date?) -> Bool {
        guard let a, let b else { return false }
        return calendar.isDate(a, inSameDayAs: b)
    }

    private func isDateInRange(_ date: Date) -> Bool {
        guard let start = startDate, let end = endDate else { return false }
        return date >= start && date <= end
    }

    private func handleTap(_ date: Date) {
        if startDate == nil {
            startDate = date
            endDate = nil
        } else if endDate == nil {
            if let start = startDate, date >= start {
                endDate = date
            } else {
                startDate = date
                endDate = nil
            }
        } else {
            startDate = date
            endDate = nil
        }
    }
}

#Preview {
    PeriodDateSelectionScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
