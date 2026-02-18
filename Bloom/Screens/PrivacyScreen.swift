import SwiftUI

struct PrivacyScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.lg) {
                    Spacer()
                        .frame(height: AppTheme.Spacing.md)

                    // Shield with gears illustration
                    PrivacyShieldIllustration(size: 240)

                    // Title
                    Text("Your body. Your data")
                        .font(AppTheme.Fonts.title1)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    // Subtitle
                    Text("Your health data will never be shared with any company but Bloom, and you can delete it at any time.")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppTheme.Spacing.xl)

                    Spacer()
                        .frame(height: AppTheme.Spacing.sm)

                    // Consent checkboxes
                    VStack(spacing: AppTheme.Spacing.lg) {
                        consentRow(
                            isOn: $viewModel.healthDataConsent
                        ) {
                            Text("I agree to processing of my personal health data for providing me Bloom app functions. See more in ") +
                            Text("Privacy Policy").foregroundColor(AppTheme.Colors.primaryPink) +
                            Text(".")
                        }

                        consentRow(
                            isOn: $viewModel.privacyPolicyConsent
                        ) {
                            Text("I agree to the ") +
                            Text("Privacy Policy").foregroundColor(AppTheme.Colors.primaryPink) +
                            Text(" and ") +
                            Text("Terms of Use").foregroundColor(AppTheme.Colors.primaryPink) +
                            Text(".")
                        }

                        consentRow(
                            isOn: $viewModel.marketingConsent
                        ) {
                            Text("I agree to allow Bloom to track my app activity. I understand that AppsFlyer, Firebase and their integrated partners may receive this data.")
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)

                    Spacer()
                        .frame(height: AppTheme.Spacing.md)
                }
            }

            // Next button pinned at bottom
            PillButton(title: "Next", isEnabled: viewModel.privacyPolicyConsent && viewModel.healthDataConsent) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
            .padding(.top, AppTheme.Spacing.sm)
        }
        .background(AppTheme.Colors.backgroundPink.ignoresSafeArea())
    }

    // MARK: - Consent Row

    private func consentRow(isOn: Binding<Bool>, @ViewBuilder label: () -> Text) -> some View {
        Button {
            isOn.wrappedValue.toggle()
        } label: {
            HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
                Image(systemName: isOn.wrappedValue ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(isOn.wrappedValue ? AppTheme.Colors.primaryPink : AppTheme.Colors.textTertiary)

                label()
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Privacy Shield Illustration with Gears

struct PrivacyShieldIllustration: View {
    var size: CGFloat = 240

    var body: some View {
        ZStack {
            // Background gears scattered around the shield
            gearIcon(gearSize: size * 0.14, color: AppTheme.Colors.orangeAccent.opacity(0.7))
                .offset(x: -size * 0.38, y: -size * 0.28)

            gearIcon(gearSize: size * 0.1, color: AppTheme.Colors.orangeAccent.opacity(0.5))
                .offset(x: -size * 0.2, y: -size * 0.38)

            gearIcon(gearSize: size * 0.08, color: AppTheme.Colors.primaryPink.opacity(0.4))
                .offset(x: -size * 0.05, y: -size * 0.42)

            gearIcon(gearSize: size * 0.12, color: AppTheme.Colors.textTertiary.opacity(0.5))
                .offset(x: size * 0.18, y: -size * 0.35)

            gearIcon(gearSize: size * 0.16, color: AppTheme.Colors.textTertiary.opacity(0.4))
                .offset(x: size * 0.38, y: -size * 0.2)

            gearIcon(gearSize: size * 0.09, color: AppTheme.Colors.orangeAccent.opacity(0.6))
                .offset(x: size * 0.42, y: -size * 0.05)

            gearIcon(gearSize: size * 0.11, color: AppTheme.Colors.textTertiary.opacity(0.35))
                .offset(x: -size * 0.42, y: size * 0.05)

            gearIcon(gearSize: size * 0.07, color: AppTheme.Colors.textTertiary.opacity(0.3))
                .offset(x: -size * 0.32, y: -size * 0.08)

            gearIcon(gearSize: size * 0.13, color: AppTheme.Colors.primaryPink.opacity(0.25))
                .offset(x: size * 0.35, y: size * 0.15)

            gearIcon(gearSize: size * 0.08, color: AppTheme.Colors.orangeAccent.opacity(0.5))
                .offset(x: size * 0.25, y: size * 0.25)

            gearIcon(gearSize: size * 0.1, color: AppTheme.Colors.textTertiary.opacity(0.3))
                .offset(x: -size * 0.3, y: size * 0.2)

            // Main shield
            ZStack {
                // Shield body — filled pink gradient
                ShieldShape()
                    .fill(
                        LinearGradient(
                            colors: [
                                AppTheme.Colors.primaryPink,
                                AppTheme.Colors.primaryPinkDark
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: size * 0.52, height: size * 0.62)

                // Shield outline
                ShieldShape()
                    .stroke(AppTheme.Colors.primaryPinkDark.opacity(0.3), lineWidth: 2)
                    .frame(width: size * 0.52, height: size * 0.62)

                // Inner shield outline
                ShieldShape()
                    .stroke(Color.white.opacity(0.3), lineWidth: 1.5)
                    .frame(width: size * 0.42, height: size * 0.5)

                // Leaf icon inside shield
                Image(systemName: "leaf.fill")
                    .font(.system(size: size * 0.14))
                    .foregroundColor(Color.white)
                    .rotationEffect(.degrees(-30))
                    .offset(y: -size * 0.02)
            }
        }
        .frame(width: size, height: size * 0.85)
    }

    private func gearIcon(gearSize: CGFloat, color: Color) -> some View {
        Image(systemName: "gearshape.fill")
            .font(.system(size: gearSize))
            .foregroundColor(color)
    }
}

#Preview {
    PrivacyScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
