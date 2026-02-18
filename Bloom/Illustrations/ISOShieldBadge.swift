import SwiftUI

struct ISOShieldBadge: View {
    private let width: CGFloat = 200
    private let height: CGFloat = 240

    var body: some View {
        ZStack {
            // Shield shape with gradient fill
            HeraldicShieldShape()
                .fill(
                    LinearGradient(
                        colors: [
                            AppTheme.Colors.shieldPinkLight,
                            AppTheme.Colors.shieldPinkMedium
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: shieldWidth, height: shieldHeight)

            // Shield stroke
            HeraldicShieldShape()
                .stroke(AppTheme.Colors.shieldPinkMedium.opacity(0.5), lineWidth: 1)
                .frame(width: shieldWidth, height: shieldHeight)

            // Content overlay
            VStack(spacing: AppTheme.Spacing.sm) {
                // Bloom text with leaf icon
                HStack(spacing: AppTheme.Spacing.xs) {
                    // Small leaf/petal
                    SmallLeafIcon()
                        .fill(AppTheme.Colors.textWhite)
                        .frame(width: 12, height: 14)

                    Text("Bloom")
                        .font(AppTheme.Fonts.captionBold)
                        .foregroundColor(AppTheme.Colors.textWhite)
                }
                .offset(y: -shieldHeight * 0.02)

                // ISO 27001 text
                Text("ISO 27001")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .offset(y: -shieldHeight * 0.01)

                Spacer()
                    .frame(height: AppTheme.Spacing.xs)
            }
            .offset(y: -shieldHeight * 0.06)

            // Gold ribbon with CERTIFIED text
            certifiedRibbon
                .offset(y: shieldHeight * 0.15)
        }
        .frame(width: width, height: height)
    }

    // MARK: - Certified Ribbon

    private var certifiedRibbon: some View {
        Text("CERTIFIED")
            .font(.system(size: 11, weight: .bold, design: .rounded))
            .foregroundColor(AppTheme.Colors.textWhite)
            .tracking(1.5)
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.vertical, AppTheme.Spacing.xs + 1)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                    .fill(AppTheme.Colors.goldRibbon)
            )
            .rotationEffect(.degrees(-3))
    }

    // MARK: - Sizes

    private var shieldWidth: CGFloat { width * 0.72 }
    private var shieldHeight: CGFloat { height * 0.82 }
}

// MARK: - Heraldic Shield Shape

private struct HeraldicShieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        // Top edge — slightly curved
        path.move(to: CGPoint(x: 0, y: h * 0.06))
        path.addQuadCurve(
            to: CGPoint(x: w, y: h * 0.06),
            control: CGPoint(x: w * 0.5, y: 0)
        )

        // Right side going down
        path.addLine(to: CGPoint(x: w, y: h * 0.55))

        // Right curve to bottom point
        path.addCurve(
            to: CGPoint(x: w * 0.5, y: h),
            control1: CGPoint(x: w, y: h * 0.75),
            control2: CGPoint(x: w * 0.75, y: h * 0.92)
        )

        // Left curve from bottom point
        path.addCurve(
            to: CGPoint(x: 0, y: h * 0.55),
            control1: CGPoint(x: w * 0.25, y: h * 0.92),
            control2: CGPoint(x: 0, y: h * 0.75)
        )

        // Left side going up
        path.addLine(to: CGPoint(x: 0, y: h * 0.06))

        path.closeSubpath()
        return path
    }
}

// MARK: - Small Leaf Icon

private struct SmallLeafIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        path.move(to: CGPoint(x: w * 0.5, y: 0))
        path.addCurve(
            to: CGPoint(x: w * 0.5, y: h),
            control1: CGPoint(x: w * 1.1, y: h * 0.2),
            control2: CGPoint(x: w * 0.9, y: h * 0.75)
        )
        path.addCurve(
            to: CGPoint(x: w * 0.5, y: 0),
            control1: CGPoint(x: w * 0.1, y: h * 0.75),
            control2: CGPoint(x: -w * 0.1, y: h * 0.2)
        )

        return path
    }
}

#Preview {
    ISOShieldBadge()
        .padding(AppTheme.Spacing.xxl)
        .background(AppTheme.Colors.backgroundPink)
}
