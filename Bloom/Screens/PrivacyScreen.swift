import SwiftUI

struct PrivacyScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            ShieldIllustration(size: 160)

            Text("Privacy first")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .padding(.top, AppTheme.Spacing.md)

            VStack(spacing: AppTheme.Spacing.md) {
                consentRow(
                    text: "I consent to the processing of my health data as described in the Privacy Policy",
                    isOn: $viewModel.healthDataConsent
                )

                consentRow(
                    text: "I accept the Privacy Policy and Terms of Use",
                    isOn: $viewModel.privacyPolicyConsent
                )

                consentRow(
                    text: "I consent to receiving marketing communications",
                    isOn: $viewModel.marketingConsent
                )
            }
            .padding(.horizontal, AppTheme.Spacing.lg)

            Text("You can withdraw your consent at any time in the app settings.")
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xxl)

            Spacer()

            PillButton(title: "Next", isEnabled: viewModel.privacyPolicyConsent && viewModel.healthDataConsent) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
    }

    // MARK: - Consent Row

    private func consentRow(text: String, isOn: Binding<Bool>) -> some View {
        Button {
            isOn.wrappedValue.toggle()
        } label: {
            HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
                Image(systemName: isOn.wrappedValue ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundColor(isOn.wrappedValue ? AppTheme.Colors.checkmark : AppTheme.Colors.textTertiary)

                Text(text)
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PrivacyScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
