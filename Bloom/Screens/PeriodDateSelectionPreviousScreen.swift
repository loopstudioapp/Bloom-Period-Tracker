import SwiftUI

struct PeriodDateSelectionPreviousScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let selectedDays: Set<Int> = [25, 26, 27, 28]
    private let predictedDays: Set<Int> = [29]
    private let predictedEndDays: Set<Int> = [30]
    private let todayDay: Int = 28
    private let totalDays: Int = 31
    private let startingWeekday: Int = 2

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.lg) {
                    headerText

                    calendarSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(title: "Next", style: .teal) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Header

    private var headerText: some View {
        Text("Tap on the dates of previous periods for even better predictions.")
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

            legendRow
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.large)
        .cardShadow()
    }

    private var monthHeader: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textTertiary)

            Spacer()

            Text("January")
                .font(AppTheme.Fonts.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textTertiary)
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
        return LazyVGrid(columns: columns, spacing: AppTheme.Spacing.sm) {
            ForEach(0..<startingWeekday, id: \.self) { _ in
                Text("")
                    .frame(height: AppTheme.Spacing.xxl)
            }

            ForEach(1...totalDays, id: \.self) { day in
                dayCell(day: day)
            }
        }
    }

    @ViewBuilder
    private func dayCell(day: Int) -> some View {
        let isSelected = selectedDays.contains(day)
        let isPredicted = predictedDays.contains(day)
        let isPredictedEnd = predictedEndDays.contains(day)
        let isToday = day == todayDay

        ZStack {
            if isSelected {
                Circle()
                    .fill(AppTheme.Colors.primaryPink)
            } else if isPredicted || isPredictedEnd {
                Circle()
                    .fill(AppTheme.Colors.primaryPink.opacity(0.3))
            } else if isToday {
                Circle()
                    .stroke(AppTheme.Colors.primaryPink, lineWidth: 2)
            }

            Text("\(day)")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(
                    isSelected
                        ? AppTheme.Colors.textWhite
                        : AppTheme.Colors.textPrimary
                )
        }
        .frame(height: AppTheme.Spacing.xxl)
    }

    // MARK: - Legend

    private var legendRow: some View {
        HStack(spacing: AppTheme.Spacing.lg) {
            legendItem(color: AppTheme.Colors.primaryPink, label: "Period")
            legendItem(color: AppTheme.Colors.primaryPink.opacity(0.3), label: "Predicted")
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
}

#Preview {
    PeriodDateSelectionPreviousScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
