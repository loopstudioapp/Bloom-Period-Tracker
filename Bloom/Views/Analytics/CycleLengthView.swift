import SwiftUI

struct CycleLengthView: View {
    @StateObject private var viewModel = AnalyticsViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.xl) {
                // Average cycle length header
                VStack(spacing: AppTheme.Spacing.xs) {
                    Text("Your average cycle length:")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    Text("\(viewModel.averageCycleLength) days")
                        .font(AppTheme.Fonts.title2)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, AppTheme.Spacing.md)

                // Cycle bars
                VStack(spacing: AppTheme.Spacing.lg) {
                    ForEach(viewModel.cycleBars) { bar in
                        CycleLengthBar(
                            label: bar.label,
                            dateRange: bar.dateRange,
                            periodDays: bar.periodDays,
                            totalDays: bar.totalDays,
                            isCurrent: bar.isCurrent,
                            averageDay: viewModel.averageCycleLength
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
        .navigationTitle("Cycle length")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CycleLengthView()
    }
}
