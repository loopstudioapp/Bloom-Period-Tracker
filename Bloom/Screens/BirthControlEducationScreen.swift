import SwiftUI

struct BirthControlEducationScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            Spacer()

            illustrationSection

            Spacer()

            textSection

            Spacer()

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Illustration

    private var illustrationSection: some View {
        ZStack {
            Circle()
                .fill(AppTheme.Colors.featurePink)
                .frame(width: 160, height: 160)

            VStack(spacing: AppTheme.Spacing.xs) {
                Image(systemName: "pills.fill")
                    .font(.system(size: 44))
                    .foregroundColor(AppTheme.Colors.primaryPink)

                Image(systemName: "shield.checkered")
                    .font(.system(size: 28))
                    .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.6))
            }
        }
    }

    // MARK: - Text

    private var textSection: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Text("Get to know your birth control")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("Get daily birth control reminders, know what to do if you're worried something's wrong and find out how birth control impacts your hormones.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }
}

#Preview {
    BirthControlEducationScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
