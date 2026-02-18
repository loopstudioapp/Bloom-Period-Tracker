import SwiftUI

struct PeriodDateCalendar: View {
    let headerText: String
    @Binding var selectedDates: Set<Int>
    var predictedDates: Set<Int> = []
    var predictedEndDates: Set<Int> = []
    var todayDay: Int = 1
    var displayMonth: Int = 1
    var displayYear: Int = 2026

    private let dayHeaders = ["M", "T", "W", "T", "F", "S", "S"]
    private let columns = Array(repeating: GridItem(.flexible(), spacing: .zero), count: 7)

    var body: some View {
        VStack(spacing: .zero) {
            // Coral gradient header
            headerBar

            // Sticky day-of-week header
            dayOfWeekHeader
                .padding(.top, AppTheme.Spacing.sm)

            // Scrollable month grids
            ScrollView {
                VStack(spacing: AppTheme.Spacing.xxl) {
                    monthSection(month: displayMonth, year: displayYear)

                    let nextMonth = displayMonth == 12 ? 1 : displayMonth + 1
                    let nextYear = displayMonth == 12 ? displayYear + 1 : displayYear
                    monthSection(month: nextMonth, year: nextYear)
                }
                .padding(.top, AppTheme.Spacing.sm)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Header Bar

    private var headerBar: some View {
        Text(headerText)
            .font(AppTheme.Fonts.subheadlineBold)
            .foregroundColor(AppTheme.Colors.textWhite)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppTheme.Spacing.md)
            .padding(.horizontal, AppTheme.Spacing.xl)
            .background(AppTheme.Colors.coralHeaderGradient)
    }

    // MARK: - Day-of-Week Header

    private var dayOfWeekHeader: some View {
        HStack(spacing: .zero) {
            ForEach(dayHeaders.indices, id: \.self) { index in
                Text(dayHeaders[index])
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.md)
    }

    // MARK: - Month Section

    private func monthSection(month: Int, year: Int) -> some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            // Month title
            Text(monthName(month: month, year: year))
                .font(AppTheme.Fonts.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, AppTheme.Spacing.xl)

            // Calendar grid
            LazyVGrid(columns: columns, spacing: AppTheme.Spacing.md) {
                // Leading empty cells
                ForEach(0..<startingWeekday(month: month, year: year), id: \.self) { _ in
                    Color.clear
                        .frame(height: cellHeight)
                }

                // Day cells
                ForEach(1...daysInMonth(month: month, year: year), id: \.self) { day in
                    dateCell(day: day, isCurrentMonth: month == displayMonth)
                        .frame(height: cellHeight)
                        .onTapGesture {
                            if month == displayMonth {
                                toggleDate(day)
                            }
                        }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)
        }
    }

    // MARK: - Date Cell

    @ViewBuilder
    private func dateCell(day: Int, isCurrentMonth: Bool) -> some View {
        let isSelected = isCurrentMonth && selectedDates.contains(day)
        let isPredicted = isCurrentMonth && predictedDates.contains(day)
        let isPredictedEnd = isCurrentMonth && predictedEndDates.contains(day)
        let isToday = isCurrentMonth && day == todayDay

        VStack(spacing: AppTheme.Spacing.xxs) {
            // "TODAY" label
            if isToday {
                Text("TODAY")
                    .font(.system(size: 8, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textSecondary)
            } else {
                Text("")
                    .font(.system(size: 8, weight: .bold, design: .rounded))
            }

            // Day number
            Text("\(day)")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(isSelected ? AppTheme.Colors.primaryPink : AppTheme.Colors.textPrimary)

            // Circle indicator below
            ZStack {
                if isSelected {
                    Circle()
                        .fill(AppTheme.Colors.primaryPink)
                        .frame(width: indicatorSize, height: indicatorSize)
                    Image(systemName: "checkmark")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(AppTheme.Colors.textWhite)
                } else if isPredicted {
                    Circle()
                        .strokeBorder(AppTheme.Colors.primaryPink, style: StrokeStyle(lineWidth: 1.5, dash: [3, 2]))
                        .frame(width: indicatorSize, height: indicatorSize)
                } else if isPredictedEnd {
                    Circle()
                        .strokeBorder(AppTheme.Colors.textSecondary, style: StrokeStyle(lineWidth: 1.5, dash: [3, 2]))
                        .frame(width: indicatorSize, height: indicatorSize)
                } else {
                    Circle()
                        .strokeBorder(AppTheme.Colors.divider, lineWidth: 1)
                        .frame(width: indicatorSize, height: indicatorSize)
                }
            }
        }
    }

    // MARK: - Actions

    private func toggleDate(_ day: Int) {
        if selectedDates.contains(day) {
            selectedDates.remove(day)
        } else {
            selectedDates.insert(day)
        }
    }

    // MARK: - Date Calculations

    private func startingWeekday(month: Int, year: Int) -> Int {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        guard let date = calendar.date(from: components) else { return 0 }
        let weekday = calendar.component(.weekday, from: date)
        return (weekday + 5) % 7
    }

    private func daysInMonth(month: Int, year: Int) -> Int {
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

    private func monthName(month: Int, year: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        guard let date = Calendar.current.date(from: components) else { return "" }
        return formatter.string(from: date)
    }

    // MARK: - Sizes

    private var cellHeight: CGFloat { AppTheme.Spacing.xxxl + AppTheme.Spacing.sm }
    private var indicatorSize: CGFloat { AppTheme.Spacing.lg }
}

#Preview {
    PeriodDateCalendar(
        headerText: "When did your last period start?",
        selectedDates: .constant([5, 6, 7, 8]),
        predictedDates: [3, 4],
        predictedEndDates: [9, 10],
        todayDay: 15,
        displayMonth: 2,
        displayYear: 2026
    )
}
