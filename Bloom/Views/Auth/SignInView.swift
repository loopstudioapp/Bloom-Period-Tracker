import SwiftUI

struct SignInView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = false
    @State private var loadingProvider: AuthProvider?

    private enum AuthProvider: String {
        case apple, google, email
    }

    var body: some View {
        ZStack {
            AppTheme.Colors.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // MARK: - Close Button
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .frame(width: 44, height: 44)
                    }
                    .accessibilityLabel("Close sign in")

                    Spacer()
                }
                .padding(.horizontal, AppTheme.Spacing.md)

                Spacer()

                // MARK: - Hero Illustration
                NumberOneHeroIllustration()
                    .accessibilityLabel("Number one women's health app")

                Spacer()
                    .frame(height: AppTheme.Spacing.xl)

                // MARK: - Title & Subtitle
                VStack(spacing: AppTheme.Spacing.sm) {
                    Text("Take control of your health")
                        .font(AppTheme.Fonts.title2)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)

                    Text("90% of users say Bloom accurately predicts the start of their period.")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 300)

                    Text("Based on a 2021 survey of 2k Bloom users")
                        .font(AppTheme.Fonts.footnote)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, AppTheme.Spacing.xxl)

                Spacer()

                // MARK: - Sign-In Buttons
                VStack(spacing: authButtonSpacing) {
                    // Continue with Apple
                    authButton(
                        provider: .apple,
                        title: "Continue with Apple",
                        icon: {
                            Image(systemName: "apple.logo")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(AppTheme.Colors.textWhite)
                        },
                        backgroundColor: Color.black,
                        textColor: AppTheme.Colors.textWhite
                    )
                    .accessibilityLabel("Continue with Apple account")

                    // Continue with Google
                    authButton(
                        provider: .google,
                        title: "Continue with Google",
                        icon: {
                            Text("G")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(hex: "#EA4335"))
                        },
                        backgroundColor: AppTheme.Colors.authGoogleBg,
                        textColor: AppTheme.Colors.textPrimary
                    )
                    .accessibilityLabel("Continue with Google account")

                    // Continue with email
                    authButton(
                        provider: .email,
                        title: "Continue with email",
                        icon: {
                            Image(systemName: "envelope.fill")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(AppTheme.Colors.textPrimary)
                        },
                        backgroundColor: AppTheme.Colors.authGoogleBg,
                        textColor: AppTheme.Colors.textPrimary
                    )
                    .accessibilityLabel("Continue with email address")
                }
                .padding(.horizontal, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxxl)
            }
        }
    }

    // MARK: - Auth Button Builder

    @ViewBuilder
    private func authButton<Icon: View>(
        provider: AuthProvider,
        title: String,
        @ViewBuilder icon: () -> Icon,
        backgroundColor: Color,
        textColor: Color
    ) -> some View {
        Button {
            guard !isLoading else { return }
            performAuth(provider: provider)
        } label: {
            HStack(spacing: AppTheme.Spacing.sm) {
                if loadingProvider == provider {
                    ProgressView()
                        .tint(textColor)
                } else {
                    icon()
                }

                Text(title)
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: AppTheme.ButtonHeight.primary)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.pill))
        }
        .disabled(isLoading)
        .opacity(isLoading && loadingProvider != provider ? 0.5 : 1.0)
        .accessibilityHint(isLoading ? "Loading" : "Double tap to sign in")
    }

    // MARK: - Mock Auth

    private func performAuth(provider: AuthProvider) {
        isLoading = true
        loadingProvider = provider

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            loadingProvider = nil
            dismiss()
        }
    }
}

// MARK: - Spacing Alias (for 12px gap)

private let authButtonSpacing: CGFloat = 12

#Preview {
    SignInView()
}
