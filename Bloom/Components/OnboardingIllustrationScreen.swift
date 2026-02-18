import SwiftUI

struct OnboardingIllustrationScreen<Illustration: View>: View {
    let title: String
    var subtitle: String? = nil
    let illustration: () -> Illustration
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            // Illustration area (~55% of screen)
            illustration()
                .frame(maxWidth: .infinity)
                .frame(maxHeight: UIScreen.main.bounds.height * illustrationHeightFraction)

            Spacer()

            // Title
            Text(title)
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, AppTheme.Spacing.xl)

            // Subtitle (optional)
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, AppTheme.Spacing.xl)
            }

            Spacer()

            // Next button
            PillButton(
                title: "Next",
                style: .primary,
                action: onNext
            )
            .padding(.horizontal, AppTheme.Spacing.xl)
            .padding(.bottom, AppTheme.Spacing.xxl)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.Colors.backgroundWarm.ignoresSafeArea())
    }

    // MARK: - Private Helpers

    private var illustrationHeightFraction: CGFloat { 0.55 }
}

#Preview {
    OnboardingIllustrationScreen(
        title: "Your cycle affects everything",
        subtitle: "From your mood to your energy levels, understanding your cycle helps you plan your life better.",
        illustration: {
            ZStack {
                Circle()
                    .fill(AppTheme.Colors.primaryPink.opacity(0.2))
                    .frame(width: 200, height: 200)

                Image(systemName: "heart.fill")
                    .font(.system(size: 80))
                    .foregroundColor(AppTheme.Colors.primaryPink)
            }
        },
        onNext: {}
    )
}
