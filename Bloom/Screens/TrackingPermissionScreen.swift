import SwiftUI
import AppTrackingTransparency

struct TrackingPermissionScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            // Partially visible background content for visual context
            Text("Are you pregnant?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .opacity(0.3)

            Spacer()

            Text("Log in")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.primaryPink)
                .padding(.bottom, AppTheme.Spacing.xl)
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
        .onAppear {
            requestTrackingPermission()
        }
    }

    // MARK: - Tracking Authorization

    private func requestTrackingPermission() {
        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    DispatchQueue.main.async {
                        viewModel.trackingPermissionGranted = (status == .authorized)
                        coordinator.advance()
                    }
                }
            }
        } else {
            viewModel.trackingPermissionGranted = (ATTrackingManager.trackingAuthorizationStatus == .authorized)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                coordinator.advance()
            }
        }
    }
}

#Preview {
    TrackingPermissionScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
