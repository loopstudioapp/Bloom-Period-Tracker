import SwiftUI

struct CycleSexIllustration: View {
    private let size: CGFloat = 280

    var body: some View {
        ZStack {
            // Cycle ring with 4 phase arcs
            cycleRing

            // Woman sitting cross-legged
            crossLeggedWoman
                .offset(y: size * 0.02)

            // Floating hearts
            floatingHearts

            // Sex drive card (top-right)
            sexDriveCard
                .offset(x: size * 0.35, y: -size * 0.3)

            // Cycle impact card (left)
            cycleImpactCard
                .offset(x: -size * 0.32, y: size * 0.05)
        }
        .frame(width: size, height: size)
    }

    // MARK: - Cycle Ring

    private var cycleRing: some View {
        ZStack {
            // Period phase (red)
            Circle()
                .trim(from: 0.0, to: 0.25)
                .stroke(AppTheme.Colors.periodPhase, style: StrokeStyle(lineWidth: ringWidth, lineCap: .butt))
                .frame(width: ringDiameter, height: ringDiameter)
                .rotationEffect(.degrees(-90))

            // Fertile phase (teal)
            Circle()
                .trim(from: 0.25, to: 0.5)
                .stroke(AppTheme.Colors.fertilePhase, style: StrokeStyle(lineWidth: ringWidth, lineCap: .butt))
                .frame(width: ringDiameter, height: ringDiameter)
                .rotationEffect(.degrees(-90))

            // Light pink phase
            Circle()
                .trim(from: 0.5, to: 0.75)
                .stroke(AppTheme.Colors.avatarPink, style: StrokeStyle(lineWidth: ringWidth, lineCap: .butt))
                .frame(width: ringDiameter, height: ringDiameter)
                .rotationEffect(.degrees(-90))

            // Follicular phase (gray)
            Circle()
                .trim(from: 0.75, to: 1.0)
                .stroke(AppTheme.Colors.follicularPhase, style: StrokeStyle(lineWidth: ringWidth, lineCap: .butt))
                .frame(width: ringDiameter, height: ringDiameter)
                .rotationEffect(.degrees(-90))
        }
    }

    // MARK: - Cross-Legged Woman

    private var crossLeggedWoman: some View {
        ZStack {
            // Hair (behind head)
            Ellipse()
                .fill(AppTheme.Colors.hairDark)
                .frame(width: size * 0.14, height: size * 0.12)
                .offset(y: -size * 0.17)

            // Head
            Circle()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.1, height: size * 0.1)
                .offset(y: -size * 0.14)

            // Hair on top
            Ellipse()
                .fill(AppTheme.Colors.hairDark)
                .frame(width: size * 0.12, height: size * 0.06)
                .offset(y: -size * 0.19)

            // Bralette
            Capsule()
                .fill(AppTheme.Colors.underwearRed)
                .frame(width: size * 0.1, height: size * 0.04)
                .offset(y: -size * 0.07)

            // Torso
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.09, height: size * 0.1)
                .offset(y: -size * 0.04)

            // Arms (capsules extending to sides)
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.14, height: size * 0.03)
                .rotationEffect(.degrees(-15))
                .offset(x: -size * 0.08, y: -size * 0.04)

            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.14, height: size * 0.03)
                .rotationEffect(.degrees(15))
                .offset(x: size * 0.08, y: -size * 0.04)

            // Cross-legged lower body (underwear)
            Capsule()
                .fill(AppTheme.Colors.underwearRed)
                .frame(width: size * 0.14, height: size * 0.04)
                .offset(y: size * 0.03)

            // Left leg (cross-legged)
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.14, height: size * 0.035)
                .rotationEffect(.degrees(25))
                .offset(x: -size * 0.04, y: size * 0.06)

            // Right leg (cross-legged)
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.14, height: size * 0.035)
                .rotationEffect(.degrees(-25))
                .offset(x: size * 0.04, y: size * 0.06)
        }
    }

    // MARK: - Floating Hearts

    private var floatingHearts: some View {
        Group {
            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.04))
                .foregroundColor(AppTheme.Colors.primaryPink)
                .offset(x: size * 0.15, y: -size * 0.35)

            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.03))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.7))
                .offset(x: -size * 0.2, y: -size * 0.32)

            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.035))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.5))
                .offset(x: size * 0.32, y: size * 0.1)

            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.025))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.6))
                .offset(x: -size * 0.35, y: size * 0.2)

            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.03))
                .foregroundColor(AppTheme.Colors.primaryPink)
                .offset(x: size * 0.05, y: size * 0.38)
        }
    }

    // MARK: - Sex Drive Card

    private var sexDriveCard: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
            HStack(spacing: AppTheme.Spacing.xs) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 10))
                    .foregroundColor(AppTheme.Colors.primaryPink)
                Text("Sex drive")
                    .font(AppTheme.Fonts.captionBold)
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }
            Text("High")
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .padding(AppTheme.Spacing.sm)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                .fill(AppTheme.Colors.cardBackground)
        )
        .subtleShadow()
    }

    // MARK: - Cycle Impact Card

    private var cycleImpactCard: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.xxs) {
            Text("How my cycle")
                .font(.system(size: 8, weight: .medium, design: .rounded))
                .foregroundColor(AppTheme.Colors.textPrimary)
            Text("impacts sex")
                .font(.system(size: 8, weight: .medium, design: .rounded))
                .foregroundColor(AppTheme.Colors.textPrimary)
        }
        .padding(AppTheme.Spacing.sm)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                .fill(AppTheme.Colors.backgroundWarm)
        )
        .subtleShadow()
    }

    // MARK: - Sizes

    private var ringDiameter: CGFloat { size * 0.75 }
    private var ringWidth: CGFloat { size * 0.035 }
}

#Preview {
    CycleSexIllustration()
        .padding(AppTheme.Spacing.xxl)
        .background(AppTheme.Colors.backgroundPink)
}
