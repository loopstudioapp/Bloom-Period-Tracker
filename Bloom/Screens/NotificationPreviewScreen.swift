import SwiftUI

struct NotificationPreviewScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            Spacer()

            notificationCard

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

    // MARK: - Notification Card

    private var notificationCard: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                .fill(AppTheme.Colors.primaryPink)
                .frame(width: AppTheme.Spacing.xxl + AppTheme.Spacing.sm, height: AppTheme.Spacing.xxl + AppTheme.Spacing.sm)
                .overlay(
                    Image(systemName: "drop.fill")
                        .font(AppTheme.Fonts.title3)
                        .foregroundColor(AppTheme.Colors.textWhite)
                )

            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text("BLOOM")
                    .font(AppTheme.Fonts.captionBold)
                    .foregroundColor(AppTheme.Colors.textTertiary)

                Text("Your period is predicted to start tomorrow. Tap to log it!")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .lineLimit(2)
            }

            Spacer()
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.large)
        .cardShadow()
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    // MARK: - Text

    private var textSection: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Text("Your next period will start around \(viewModel.predictedNextPeriodDateString)")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("Want a heads up before your period starts? Tap 'Allow' on the next screen to get reminders.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }
}

#Preview {
    NotificationPreviewScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
