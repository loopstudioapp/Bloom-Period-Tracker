import SwiftUI

struct DiscoverPatternsIllustration: View {
    private let size: CGFloat = 280

    var body: some View {
        ZStack {
            // Flowing pink wave
            flowingWave
                .offset(y: size * 0.05)

            // Woman figure
            womanFigure
                .offset(x: -size * 0.1, y: size * 0.02)

            // Glowing heart at wave peak
            glowingHeart
                .offset(x: size * 0.15, y: -size * 0.12)

            // Scattered small hearts
            scatteredHearts
        }
        .frame(width: size, height: size)
    }

    // MARK: - Flowing Wave

    private var flowingWave: some View {
        Path { path in
            let w = size
            let startY = size * 0.5
            let amplitude: CGFloat = size * 0.12

            path.move(to: CGPoint(x: -w * 0.1, y: startY))

            path.addCurve(
                to: CGPoint(x: w * 0.25, y: startY - amplitude),
                control1: CGPoint(x: w * 0.05, y: startY),
                control2: CGPoint(x: w * 0.15, y: startY - amplitude)
            )

            path.addCurve(
                to: CGPoint(x: w * 0.55, y: startY),
                control1: CGPoint(x: w * 0.35, y: startY - amplitude),
                control2: CGPoint(x: w * 0.45, y: startY)
            )

            path.addCurve(
                to: CGPoint(x: w * 0.85, y: startY + amplitude * 0.6),
                control1: CGPoint(x: w * 0.65, y: startY),
                control2: CGPoint(x: w * 0.75, y: startY + amplitude * 0.6)
            )

            path.addCurve(
                to: CGPoint(x: w * 1.1, y: startY),
                control1: CGPoint(x: w * 0.95, y: startY + amplitude * 0.6),
                control2: CGPoint(x: w * 1.05, y: startY)
            )
        }
        .stroke(
            LinearGradient(
                colors: [
                    AppTheme.Colors.primaryPink.opacity(0.3),
                    AppTheme.Colors.primaryPink.opacity(0.7),
                    AppTheme.Colors.primaryPink.opacity(0.3)
                ],
                startPoint: .leading,
                endPoint: .trailing
            ),
            style: StrokeStyle(lineWidth: size * 0.015, lineCap: .round)
        )
    }

    // MARK: - Woman Figure

    private var womanFigure: some View {
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

            // Arms
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.14, height: size * 0.03)
                .rotationEffect(.degrees(-10))
                .offset(x: -size * 0.08, y: -size * 0.04)

            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.14, height: size * 0.03)
                .rotationEffect(.degrees(10))
                .offset(x: size * 0.08, y: -size * 0.04)

            // Underwear
            Capsule()
                .fill(AppTheme.Colors.underwearRed)
                .frame(width: size * 0.12, height: size * 0.04)
                .offset(y: size * 0.03)

            // Legs
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.035, height: size * 0.14)
                .rotationEffect(.degrees(-5))
                .offset(x: -size * 0.03, y: size * 0.11)

            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: size * 0.035, height: size * 0.14)
                .rotationEffect(.degrees(5))
                .offset(x: size * 0.03, y: size * 0.11)
        }
    }

    // MARK: - Glowing Heart

    private var glowingHeart: some View {
        ZStack {
            // Outer glow rings
            Circle()
                .fill(AppTheme.Colors.primaryPink.opacity(0.05))
                .frame(width: size * 0.2, height: size * 0.2)

            Circle()
                .fill(AppTheme.Colors.primaryPink.opacity(0.1))
                .frame(width: size * 0.14, height: size * 0.14)

            Circle()
                .fill(AppTheme.Colors.primaryPink.opacity(0.15))
                .frame(width: size * 0.09, height: size * 0.09)

            // Heart
            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.06))
                .foregroundColor(AppTheme.Colors.primaryPink)
        }
    }

    // MARK: - Scattered Hearts

    private var scatteredHearts: some View {
        Group {
            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.025))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.4))
                .offset(x: size * 0.3, y: -size * 0.3)

            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.02))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.3))
                .offset(x: -size * 0.3, y: -size * 0.25)

            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.03))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.35))
                .offset(x: size * 0.35, y: size * 0.2)

            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.02))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.25))
                .offset(x: -size * 0.35, y: size * 0.15)

            Image(systemName: "heart")
                .font(.system(size: size * 0.025))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.3))
                .offset(x: size * 0.1, y: size * 0.35)
        }
    }
}

#Preview {
    DiscoverPatternsIllustration()
        .padding(AppTheme.Spacing.xxl)
        .background(AppTheme.Colors.backgroundPink)
}
