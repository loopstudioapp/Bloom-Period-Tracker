import SwiftUI

struct PeriodPredictionScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    predictionCard

                    expertSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Prediction Card

    private var predictionCard: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            WeekCalendarStrip()

            Text("Period in 3 days")
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("Low chance of getting pregnant")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .padding(AppTheme.Spacing.lg)
        .frame(maxWidth: .infinity)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.large)
        .cardShadow()
    }

    // MARK: - Expert Section

    private var expertSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("Become an expert on you")
                .font(AppTheme.Fonts.title3)
                .foregroundColor(AppTheme.Colors.textPrimary)

            VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                bulletPoint("Get accurate period predictions that learn your unique patterns")
                bulletPoint("Track symptoms, moods, and flow to understand your body")
                bulletPoint("Plan ahead with confidence for every phase of your cycle")
            }
        }
    }

    // MARK: - Bullet Point

    private func bulletPoint(_ text: String) -> some View {
        HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(AppTheme.Colors.primaryPink)
                .font(AppTheme.Fonts.body)

            Text(text)
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    PeriodPredictionScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
