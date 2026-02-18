import SwiftUI

struct CalendarPreviewScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let fertileDays: Set<Int> = [6, 7, 8, 9, 10, 12]
    private let ovulationDay: Int = 11
    private let todayDay: Int = 22
    private let periodPredictionDays: Set<Int> = [27, 28, 29]
    private let nextPeriodDay: Int = 25
    private let totalDays: Int = 31
    private let startingWeekday: Int = 2 // January 2025 starts on Wednesday (offset 2 for Mon-start)

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    calendarCard

                    sampleDataNote

                    ctaSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(title: "Add period dates") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.backgroundPink)
    }

    // MARK: - Calendar Card

    private var calendarCard: some View {
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
            // Empty cells for offset
            ForEach(0..<startingWeekday, id: \.self) { _ in
                Text("")
                    .frame(height: AppTheme.Spacing.xxl)
            }

            // Day cells
            ForEach(1...totalDays, id: \.self) { day in
                dayCell(day: day)
            }
        }
    }

    @ViewBuilder
    private func dayCell(day: Int) -> some View {
        let isFertile = fertileDays.contains(day)
        let isOvulation = day == ovulationDay
        let isToday = day == todayDay
        let isPeriodPrediction = periodPredictionDays.contains(day)
        let isNextPeriod = day == nextPeriodDay

        ZStack {
            if isFertile {
                Circle()
                    .fill(AppTheme.Colors.fertilePhase.opacity(0.3))
            } else if isOvulation {
                Circle()
                    .fill(AppTheme.Colors.fertilePhase)
            } else if isNextPeriod {
                Circle()
                    .fill(AppTheme.Colors.primaryPink)
            } else if isPeriodPrediction {
                Circle()
                    .fill(AppTheme.Colors.primaryPink.opacity(0.4))
            } else if isToday {
                Circle()
                    .stroke(AppTheme.Colors.primaryPink, lineWidth: 2)
            }

            Text("\(day)")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(
                    (isOvulation || isNextPeriod)
                        ? AppTheme.Colors.textWhite
                        : AppTheme.Colors.textPrimary
                )
        }
        .frame(height: AppTheme.Spacing.xxl)
    }

    // MARK: - Sample Data Note

    private var sampleDataNote: some View {
        Text("NOTE: This is sample data")
            .font(AppTheme.Fonts.caption)
            .foregroundColor(AppTheme.Colors.primaryPink)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    // MARK: - CTA Section

    private var ctaSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Text("Log your periods to get accurate predictions")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("90% of users say Bloom accurately predicts the start of their period.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CalendarPreviewScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
