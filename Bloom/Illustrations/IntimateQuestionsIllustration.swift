import SwiftUI

struct IntimateQuestionsIllustration: View {
    private let width: CGFloat = 240
    private let height: CGFloat = 320

    var body: some View {
        ZStack {
            // Hand reaching from right
            handReaching

            // Phone frame
            phoneFrame
        }
        .frame(width: width, height: height)
    }

    // MARK: - Phone Frame

    private var phoneFrame: some View {
        ZStack {
            // Phone border
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge)
                .stroke(AppTheme.Colors.textPrimary, lineWidth: 3)
                .frame(width: phoneWidth, height: phoneHeight)
                .background(
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge)
                        .fill(AppTheme.Colors.tealAccent.opacity(0.8))
                )
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge))

            // Screen content
            screenContent
        }
        .offset(x: -width * 0.05)
    }

    // MARK: - Screen Content

    private var screenContent: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Spacer()
                .frame(height: AppTheme.Spacing.xxl)

            // Title
            Text("Am I pregnant?")
                .font(AppTheme.Fonts.headline)
                .foregroundColor(AppTheme.Colors.textWhite)
                .padding(.horizontal, AppTheme.Spacing.md)

            // Subtitle
            Text("Learn about early signs\nand what to do next")
                .font(.system(size: 10, weight: .regular, design: .rounded))
                .foregroundColor(AppTheme.Colors.textWhite.opacity(0.7))
                .padding(.horizontal, AppTheme.Spacing.md)

            // Search bar
            HStack(spacing: AppTheme.Spacing.sm) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 10))
                    .foregroundColor(AppTheme.Colors.textSecondary)

                Text("Search topics...")
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textSecondary)

                Spacer()
            }
            .padding(.horizontal, AppTheme.Spacing.sm)
            .padding(.vertical, AppTheme.Spacing.sm)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.pill)
                    .fill(AppTheme.Colors.cardBackground)
            )
            .padding(.horizontal, AppTheme.Spacing.md)

            // Category chips
            HStack(spacing: AppTheme.Spacing.sm) {
                chipView(text: "Fertility")
                chipView(text: "Symptoms")
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            Spacer()
        }
        .frame(width: phoneWidth, height: phoneHeight)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge))
    }

    // MARK: - Chip View

    private func chipView(text: String) -> some View {
        Text(text)
            .font(.system(size: 9, weight: .medium, design: .rounded))
            .foregroundColor(AppTheme.Colors.textPrimary)
            .padding(.horizontal, AppTheme.Spacing.sm)
            .padding(.vertical, AppTheme.Spacing.xs)
            .background(
                Capsule()
                    .fill(AppTheme.Colors.cardBackground)
            )
    }

    // MARK: - Hand Reaching

    private var handReaching: some View {
        Group {
            // Palm
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: width * 0.18, height: height * 0.12)
                .rotationEffect(.degrees(-20))
                .offset(x: width * 0.35, y: height * 0.15)

            // Fingers
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: width * 0.06, height: height * 0.08)
                .rotationEffect(.degrees(-35))
                .offset(x: width * 0.28, y: height * 0.1)

            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: width * 0.05, height: height * 0.07)
                .rotationEffect(.degrees(-25))
                .offset(x: width * 0.26, y: height * 0.15)

            // Wrist / forearm
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: width * 0.14, height: height * 0.16)
                .rotationEffect(.degrees(-15))
                .offset(x: width * 0.42, y: height * 0.22)
        }
    }

    // MARK: - Sizes

    private var phoneWidth: CGFloat { width * 0.55 }
    private var phoneHeight: CGFloat { height * 0.75 }
}

#Preview {
    IntimateQuestionsIllustration()
        .padding(AppTheme.Spacing.xxl)
        .background(AppTheme.Colors.backgroundPink)
}
