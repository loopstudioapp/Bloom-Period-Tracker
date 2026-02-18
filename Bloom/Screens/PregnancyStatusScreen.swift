import SwiftUI

struct PregnancyStatusScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            Text("Are you pregnant?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            VStack(spacing: AppTheme.Spacing.md) {
                ForEach(PregnancyStatus.allCases) { status in
                    PillButton(title: status.rawValue) {
                        viewModel.pregnancyStatusRaw = status.rawValue
                        coordinator.advance()
                    }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.lg)

            Spacer()

            Text("Log in")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.primaryPink)
                .padding(.bottom, AppTheme.Spacing.xl)
        }
    }
}

#Preview {
    PregnancyStatusScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
