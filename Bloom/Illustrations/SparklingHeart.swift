import SwiftUI

struct SparklingHeart: View {
    private let size: CGFloat = 200

    var body: some View {
        ZStack {
            // Large pink heart
            Image(systemName: "heart.fill")
                .font(.system(size: 160))
                .foregroundColor(AppTheme.Colors.primaryPink)
                .subtleShadow()

            // Gold sparkle stars at various positions and sizes
            FourPointStar()
                .fill(AppTheme.Colors.goldStar)
                .frame(width: 16, height: 16)
                .offset(x: -size * 0.42, y: -size * 0.3)

            FourPointStar()
                .fill(AppTheme.Colors.goldStar)
                .frame(width: 12, height: 12)
                .offset(x: size * 0.45, y: -size * 0.25)

            FourPointStar()
                .fill(AppTheme.Colors.goldStar)
                .frame(width: 10, height: 10)
                .offset(x: size * 0.35, y: size * 0.15)

            FourPointStar()
                .fill(AppTheme.Colors.goldStar)
                .frame(width: 14, height: 14)
                .offset(x: -size * 0.38, y: size * 0.2)

            FourPointStar()
                .fill(AppTheme.Colors.goldStar)
                .frame(width: 8, height: 8)
                .offset(x: size * 0.1, y: -size * 0.42)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Four Point Star Shape

private struct FourPointStar: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let w = rect.width
        let h = rect.height
        let innerRatio: CGFloat = 0.3

        // Top point
        path.move(to: CGPoint(x: center.x, y: 0))
        // To right point
        path.addQuadCurve(
            to: CGPoint(x: w, y: center.y),
            control: CGPoint(x: center.x + w * innerRatio * 0.5, y: center.y - h * innerRatio * 0.5)
        )
        // To bottom point
        path.addQuadCurve(
            to: CGPoint(x: center.x, y: h),
            control: CGPoint(x: center.x + w * innerRatio * 0.5, y: center.y + h * innerRatio * 0.5)
        )
        // To left point
        path.addQuadCurve(
            to: CGPoint(x: 0, y: center.y),
            control: CGPoint(x: center.x - w * innerRatio * 0.5, y: center.y + h * innerRatio * 0.5)
        )
        // Back to top
        path.addQuadCurve(
            to: CGPoint(x: center.x, y: 0),
            control: CGPoint(x: center.x - w * innerRatio * 0.5, y: center.y - h * innerRatio * 0.5)
        )

        path.closeSubpath()
        return path
    }
}

#Preview {
    SparklingHeart()
        .padding(AppTheme.Spacing.xxl)
        .background(AppTheme.Colors.backgroundPink)
}
