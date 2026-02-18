import SwiftUI

struct PeriodLengthView: View {
    @StateObject private var viewModel = AnalyticsViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.xl) {
                // Average period length header
                VStack(spacing: AppTheme.Spacing.xs) {
                    Text("Your average period length:")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    Text("\(viewModel.averagePeriodLength) days")
                        .font(AppTheme.Fonts.title2)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, AppTheme.Spacing.md)

                // Period bars (no average line)
                VStack(spacing: AppTheme.Spacing.lg) {
                    ForEach(viewModel.periodBars) { bar in
                        CycleLengthBar(
                            label: bar.label,
                            dateRange: bar.dateRange,
                            periodDays: bar.periodDays,
                            totalDays: bar.totalDays,
                            isCurrent: bar.isCurrent
                        )
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.md)

                // Add previous periods link
                Button {
                    // Action for adding previous periods
                } label: {
                    Text("Add previous periods")
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.addLogFAB)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, AppTheme.Spacing.sm)

                Spacer()
            }
        }
        .navigationTitle("Period length & intensity")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PeriodLengthView()
    }
}
