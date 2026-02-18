import SwiftUI

struct CyclePatternsScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    cardSection

                    textSection
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

    // MARK: - Card Section

    private var cardSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            CycleStatsCard(rows: OnboardingData.cycleStatsRows)

            Text("NOTE: This is sample data")
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.primaryPink)
        }
    }

    // MARK: - Text Section

    private var textSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Text("Get to know your cycle patterns and what's normal for you")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("83% of users say Bloom taught them what is, and isn't a normal cycle.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CyclePatternsScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
