import SwiftUI

struct FeatureCard: View {
    let title: String
    var backgroundColor: Color = AppTheme.Colors.featureBlueGray
    var iconType: FeatureIconType = .alarmWithHearts

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            backgroundColor

            // Programmatic illustration
            illustrationView
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(AppTheme.Spacing.md)

            // Title text
            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text(title)
                    .font(AppTheme.Fonts.title3)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)

                Spacer()
            }
            .padding(AppTheme.Spacing.md)
        }
        .frame(height: cardHeight)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }

    // MARK: - Illustration Views

    @ViewBuilder
    private var illustrationView: some View {
        switch iconType {
        case .alarmWithHearts:
            AlarmWithHeartsIllustration()
        case .womanWithLightning:
            LightningIllustration()
        case .circularArrow:
            CircularArrowIllustration()
        case .largeNumber:
            LargeNumberIllustration()
        }
    }

    private var cardHeight: CGFloat { AppTheme.ResponsiveLayout.scaled(160) }
}

// MARK: - Illustration Components

private struct AlarmWithHeartsIllustration: View {
    var body: some View {
        ZStack {
            Image(systemName: "alarm.fill")
                .font(.system(size: iconSize, weight: .light))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.3))

            Image(systemName: "heart.fill")
                .font(.system(size: smallIconSize))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.5))
                .offset(x: heartOffset, y: -heartOffset)

            Image(systemName: "heart.fill")
                .font(.system(size: tinyIconSize))
                .foregroundColor(AppTheme.Colors.coralAccent.opacity(0.4))
                .offset(x: -smallHeartOffset, y: -smallHeartOffset)
        }
    }

    private var iconSize: CGFloat { AppTheme.Spacing.xxxl }
    private var smallIconSize: CGFloat { AppTheme.Spacing.lg }
    private var tinyIconSize: CGFloat { AppTheme.Spacing.md }
    private var heartOffset: CGFloat { AppTheme.Spacing.lg }
    private var smallHeartOffset: CGFloat { AppTheme.Spacing.sm }
}

private struct LightningIllustration: View {
    var body: some View {
        ZStack {
            Image(systemName: "bolt.fill")
                .font(.system(size: iconSize, weight: .light))
                .foregroundColor(AppTheme.Colors.orangeAccent.opacity(0.3))

            Image(systemName: "figure.stand")
                .font(.system(size: figureSize, weight: .light))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.4))
                .offset(x: -figureOffset)
        }
    }

    private var iconSize: CGFloat { AppTheme.Spacing.xxxl }
    private var figureSize: CGFloat { AppTheme.Spacing.xxl }
    private var figureOffset: CGFloat { AppTheme.Spacing.md }
}

private struct CircularArrowIllustration: View {
    var body: some View {
        ZStack {
            Image(systemName: "arrow.triangle.2.circlepath")
                .font(.system(size: iconSize, weight: .light))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.3))

            Circle()
                .fill(AppTheme.Colors.primaryPink.opacity(0.15))
                .frame(width: circleSize, height: circleSize)
        }
    }

    private var iconSize: CGFloat { AppTheme.Spacing.xxxl }
    private var circleSize: CGFloat { AppTheme.Spacing.xl }
}

private struct LargeNumberIllustration: View {
    var body: some View {
        Text("14")
            .font(AppTheme.Fonts.displayLarge)
            .foregroundColor(AppTheme.Colors.blueAccent.opacity(0.2))
    }
}

#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: AppTheme.Spacing.md) {
            FeatureCard(
                title: "How my cycle impacts sex",
                backgroundColor: AppTheme.Colors.featureBlueGray,
                iconType: .alarmWithHearts
            )
            .frame(width: 200)

            FeatureCard(
                title: "What do my PMS symptoms mean",
                backgroundColor: AppTheme.Colors.featurePeach,
                iconType: .womanWithLightning
            )
            .frame(width: 200)

            FeatureCard(
                title: "Period could start today",
                backgroundColor: AppTheme.Colors.featurePink,
                iconType: .circularArrow
            )
            .frame(width: 200)

            FeatureCard(
                title: "Dive into my cycle day",
                backgroundColor: AppTheme.Colors.featureLightBlue,
                iconType: .largeNumber
            )
            .frame(width: 200)
        }
        .padding(AppTheme.Spacing.xl)
    }
}
