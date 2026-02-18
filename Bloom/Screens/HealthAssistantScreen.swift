import SwiftUI

struct HealthAssistantScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: .zero) {
                    cardArea

                    textSection
                        .padding(.top, AppTheme.Spacing.xl)
                }
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

    // MARK: - Card Area

    private var cardArea: some View {
        ZStack {
            AppTheme.Colors.backgroundPink
                .ignoresSafeArea(edges: .top)

            HealthAssistantCard(rows: OnboardingData.healthAssistantRows)
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.vertical, AppTheme.Spacing.xl)
        }
    }

    // MARK: - Text Section

    private var textSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Text("A virtual health assistant in your pocket")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("You can chat with Bloom's Health Assistant to assess how you're feeling and get in the moment, proactive support for your symptoms.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }
}

#Preview {
    HealthAssistantScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
