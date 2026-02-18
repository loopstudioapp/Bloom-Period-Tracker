import SwiftUI
import UserNotifications

struct NotificationPermissionScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        ZStack {
            // Dimmed background
            AppTheme.Colors.textPrimary.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: AppTheme.Spacing.lg) {
                Spacer()

                mockDialogCard

                chooseItHint

                Spacer()
            }
            .padding(.horizontal, AppTheme.Spacing.xxl)
        }
        .onAppear {
            requestNotificationPermission()
        }
    }

    // MARK: - Mock Dialog

    private var mockDialogCard: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Text("\u{201C}Bloom\u{201D} Would Like to Send You Notifications")
                .font(AppTheme.Fonts.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)

            Divider()
                .background(AppTheme.Colors.divider)

            HStack(spacing: .zero) {
                Text("Don't Allow")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.blueAccent)
                    .frame(maxWidth: .infinity)

                Divider()
                    .background(AppTheme.Colors.divider)
                    .frame(height: AppTheme.Spacing.xl)

                Text("Allow")
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.blueAccent)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, AppTheme.Spacing.xl)
        .padding(.bottom, AppTheme.Spacing.md)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.large)
        .cardShadow()
    }

    // MARK: - Choose It Hint

    private var chooseItHint: some View {
        VStack(spacing: AppTheme.Spacing.xs) {
            Image(systemName: "chevron.up")
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textWhite)

            Text("Choose it!")
                .font(AppTheme.Fonts.captionBold)
                .foregroundColor(AppTheme.Colors.textWhite)
        }
    }

    // MARK: - Permission Request

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, _ in
            DispatchQueue.main.async {
                viewModel.notificationPermissionGranted = granted
                coordinator.advance()
            }
        }
    }
}

#Preview {
    NotificationPermissionScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
