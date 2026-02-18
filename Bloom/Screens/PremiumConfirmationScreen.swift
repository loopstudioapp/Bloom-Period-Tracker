import SwiftUI

struct PremiumConfirmationScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var appeared = false
    @State private var checkmarkScale: CGFloat = 0
    @State private var showConfetti = false

    var body: some View {
        ZStack {
            // Gradient background
            AppTheme.Colors.premiumConfirmationGradient.ignoresSafeArea()

            // Confetti overlay
            if showConfetti {
                ConfettiView()
            }

            VStack(spacing: AppTheme.Spacing.xxl) {
                Spacer()

                // Checkmark circle
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 120, height: 120)

                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 96, height: 96)

                    Image(systemName: "checkmark")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(AppTheme.Colors.textWhite)
                }
                .scaleEffect(checkmarkScale)

                // Text
                VStack(spacing: AppTheme.Spacing.md) {
                    Text("You're all set! 🎉")
                        .font(AppTheme.Fonts.largeTitle)
                        .foregroundColor(AppTheme.Colors.textWhite)
                        .opacity(appeared ? 1 : 0)

                    Text(viewModel.isPremiumUser
                         ? "Welcome to Bloom Premium!\nYour personalized health journey begins now."
                         : "Welcome to Bloom!\nYour personalized health journey begins now.")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textWhite.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppTheme.Spacing.xxl)
                        .opacity(appeared ? 1 : 0)
                }

                Spacer()

                // Features recap
                VStack(spacing: AppTheme.Spacing.sm) {
                    confirmationFeature(icon: "checkmark.circle.fill", text: "Profile personalized to you")
                    confirmationFeature(icon: "checkmark.circle.fill", text: "Cycle predictions ready")
                    confirmationFeature(icon: "checkmark.circle.fill", text: "Health insights activated")
                }
                .opacity(appeared ? 1 : 0)

                Spacer()

                // CTA
                Button(action: {
                    coordinator.advance()
                }) {
                    Text("Start Using Bloom")
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.primaryPink)
                        .frame(maxWidth: .infinity)
                        .frame(height: AppTheme.ButtonHeight.primary)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.bottom, AppTheme.Spacing.xl)
                .opacity(appeared ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.5).delay(0.2)) {
                checkmarkScale = 1.0
            }
            withAnimation(AppTheme.Animation.slow.delay(0.4)) {
                appeared = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showConfetti = true
            }
        }
    }

    private func confirmationFeature(icon: String, text: String) -> some View {
        HStack(spacing: AppTheme.Spacing.md) {
            Image(systemName: icon)
                .foregroundColor(Color.white.opacity(0.9))
                .font(.system(size: 18))

            Text(text)
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textWhite.opacity(0.9))

            Spacer()
        }
        .padding(.horizontal, AppTheme.Spacing.xxl)
    }
}

#Preview {
    PremiumConfirmationScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
