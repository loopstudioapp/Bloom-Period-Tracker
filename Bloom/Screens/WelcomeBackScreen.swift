import SwiftUI

struct WelcomeBackScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: AppTheme.Spacing.xxl)

            // Illustration
            WomanWithPhoneIllustration()
                .scaleEffect(appeared ? 1.0 : 0.95)
                .opacity(appeared ? 1.0 : 0.0)

            Spacer()
                .frame(height: AppTheme.Spacing.xxl)

            // Title
            Text("Welcome back!")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .opacity(appeared ? 1.0 : 0.0)

            Spacer()
                .frame(height: AppTheme.Spacing.md)

            // Subtitle
            Text("We\u{2019}ve saved your progress so you can jump back into your health journey where you left off.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xxl)
                .opacity(appeared ? 1.0 : 0.0)

            Spacer()

            // Continue button
            Button(action: {
                coordinator.continueFromSavedStep()
            }) {
                Text("Continue")
                    .font(AppTheme.Fonts.headline)
                    .foregroundColor(AppTheme.Colors.textWhite)
                    .frame(maxWidth: .infinity)
                    .frame(height: AppTheme.ButtonHeight.primary)
                    .background(
                        Capsule()
                            .fill(AppTheme.Colors.primaryPink)
                    )
            }
            .padding(.horizontal, AppTheme.Spacing.xxl)
            .padding(.bottom, AppTheme.Spacing.xxl)
            .opacity(appeared ? 1.0 : 0.0)
        }
        .background(AppTheme.Colors.backgroundPink.ignoresSafeArea())
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                appeared = true
            }
        }
    }
}

// MARK: - Woman With Phone Illustration
// A friendly illustration of a woman with curly hair holding a pink phone

struct WomanWithPhoneIllustration: View {
    private let size: CGFloat = 300

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .fill(AppTheme.Colors.backgroundPink)
                .frame(width: size * 0.95, height: size * 0.95)

            // Body and figure
            VStack(spacing: 0) {
                // Hair (curly, behind head)
                ZStack {
                    // Hair mass - left side
                    Ellipse()
                        .fill(AppTheme.Colors.hairDark)
                        .frame(width: size * 0.38, height: size * 0.42)
                        .offset(x: -size * 0.05, y: size * 0.02)

                    // Hair mass - right side (flows down)
                    Ellipse()
                        .fill(AppTheme.Colors.hairDark)
                        .frame(width: size * 0.35, height: size * 0.55)
                        .offset(x: size * 0.12, y: size * 0.08)

                    // Hair top volume
                    Ellipse()
                        .fill(AppTheme.Colors.hairDark)
                        .frame(width: size * 0.4, height: size * 0.3)
                        .offset(y: -size * 0.08)

                    // Wavy hair curls (right side)
                    ForEach(0..<3, id: \.self) { i in
                        Circle()
                            .fill(AppTheme.Colors.hairDark)
                            .frame(width: size * 0.1, height: size * 0.1)
                            .offset(
                                x: size * 0.22,
                                y: size * (0.12 + CGFloat(i) * 0.09)
                            )
                    }

                    // Face
                    Ellipse()
                        .fill(AppTheme.Colors.skinTone)
                        .frame(width: size * 0.28, height: size * 0.32)

                    // Glasses - left lens
                    Circle()
                        .stroke(Color.white.opacity(0.9), lineWidth: 2.5)
                        .frame(width: size * 0.1, height: size * 0.1)
                        .offset(x: -size * 0.055, y: -size * 0.01)

                    // Glasses - right lens
                    Circle()
                        .stroke(Color.white.opacity(0.9), lineWidth: 2.5)
                        .frame(width: size * 0.1, height: size * 0.1)
                        .offset(x: size * 0.055, y: -size * 0.01)

                    // Glasses bridge
                    Rectangle()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: size * 0.02, height: size * 0.012)
                        .offset(y: -size * 0.01)

                    // Eyes
                    Circle()
                        .fill(AppTheme.Colors.hairDark)
                        .frame(width: size * 0.03, height: size * 0.03)
                        .offset(x: -size * 0.055, y: -size * 0.005)

                    Circle()
                        .fill(AppTheme.Colors.hairDark)
                        .frame(width: size * 0.03, height: size * 0.03)
                        .offset(x: size * 0.055, y: -size * 0.005)

                    // Smile
                    Circle()
                        .trim(from: 0.05, to: 0.45)
                        .stroke(AppTheme.Colors.hairDark.opacity(0.6), lineWidth: 2)
                        .frame(width: size * 0.08, height: size * 0.06)
                        .offset(y: size * 0.05)

                    // Blush
                    Ellipse()
                        .fill(AppTheme.Colors.primaryPink.opacity(0.25))
                        .frame(width: size * 0.06, height: size * 0.035)
                        .offset(x: -size * 0.08, y: size * 0.04)

                    Ellipse()
                        .fill(AppTheme.Colors.primaryPink.opacity(0.25))
                        .frame(width: size * 0.06, height: size * 0.035)
                        .offset(x: size * 0.08, y: size * 0.04)
                }

                // Neck
                Rectangle()
                    .fill(AppTheme.Colors.skinTone)
                    .frame(width: size * 0.08, height: size * 0.04)
                    .offset(y: -size * 0.01)

                // T-shirt / body
                ZStack {
                    // Shirt body
                    RoundedRectangle(cornerRadius: size * 0.06)
                        .fill(AppTheme.Colors.tealShirt.opacity(0.5))
                        .frame(width: size * 0.45, height: size * 0.28)

                    // Left arm
                    Capsule()
                        .fill(AppTheme.Colors.skinTone)
                        .frame(width: size * 0.08, height: size * 0.2)
                        .rotationEffect(.degrees(30))
                        .offset(x: -size * 0.2, y: -size * 0.02)

                    // Right arm (holding phone, raised)
                    Capsule()
                        .fill(AppTheme.Colors.skinTone)
                        .frame(width: size * 0.08, height: size * 0.18)
                        .rotationEffect(.degrees(-20))
                        .offset(x: size * 0.15, y: -size * 0.08)

                    // Phone in hand
                    RoundedRectangle(cornerRadius: size * 0.02)
                        .fill(AppTheme.Colors.primaryPink)
                        .frame(width: size * 0.08, height: size * 0.12)
                        .offset(x: size * 0.12, y: -size * 0.13)

                    // Phone screen shine
                    RoundedRectangle(cornerRadius: size * 0.01)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: size * 0.05, height: size * 0.08)
                        .offset(x: size * 0.115, y: -size * 0.13)

                    // Left hand wave fingers
                    ForEach(0..<3, id: \.self) { i in
                        Capsule()
                            .fill(AppTheme.Colors.skinTone)
                            .frame(width: size * 0.02, height: size * 0.05)
                            .rotationEffect(.degrees(Double(15 + i * 10)))
                            .offset(
                                x: -size * (0.24 - CGFloat(i) * 0.015),
                                y: -size * (0.1 + CGFloat(i) * 0.01)
                            )
                    }

                    // Sleeve edges
                    Capsule()
                        .fill(AppTheme.Colors.tealShirt.opacity(0.6))
                        .frame(width: size * 0.1, height: size * 0.04)
                        .rotationEffect(.degrees(30))
                        .offset(x: -size * 0.17, y: size * 0.02)

                    Capsule()
                        .fill(AppTheme.Colors.tealShirt.opacity(0.6))
                        .frame(width: size * 0.1, height: size * 0.04)
                        .rotationEffect(.degrees(-20))
                        .offset(x: size * 0.17, y: 0)

                    // Shirt neckline detail
                    Ellipse()
                        .trim(from: 0.0, to: 0.5)
                        .stroke(AppTheme.Colors.tealShirt.opacity(0.3), lineWidth: 1.5)
                        .frame(width: size * 0.15, height: size * 0.06)
                        .offset(y: -size * 0.13)
                }
                .offset(y: -size * 0.02)
            }
        }
        .frame(width: size, height: size * 1.1)
    }
}

#Preview {
    WelcomeBackScreen()
        .environmentObject(OnboardingCoordinator())
}
