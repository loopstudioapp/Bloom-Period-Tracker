import SwiftUI

struct HealthDataIllustration: View {
    private let size: CGFloat = 260

    var body: some View {
        ZStack {
            // Concentric orbit rings
            orbitRings

            // Orbiting health icons
            orbitingIcons

            // Bloom app icon (center)
            bloomAppIcon
                .offset(x: -size * 0.06, y: size * 0.02)

            // Apple Health icon (top-right overlap)
            appleHealthIcon
                .offset(x: size * 0.12, y: -size * 0.1)

            // Dotted line connecting them
            dottedConnection
        }
        .frame(width: size, height: size)
    }

    // MARK: - Bloom App Icon

    private var bloomAppIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.06)
                .fill(AppTheme.Colors.primaryPink)
                .frame(width: size * 0.25, height: size * 0.25)

            // Feather/leaf shape using Path
            BloomLeafShape()
                .fill(AppTheme.Colors.textWhite)
                .frame(width: size * 0.12, height: size * 0.14)
        }
    }

    // MARK: - Apple Health Icon

    private var appleHealthIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.04)
                .fill(AppTheme.Colors.cardBackground)
                .frame(width: size * 0.18, height: size * 0.18)
                .subtleShadow()

            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.06))
                .foregroundColor(AppTheme.Colors.primaryPink)
        }
    }

    // MARK: - Orbit Rings

    private var orbitRings: some View {
        Group {
            Circle()
                .stroke(AppTheme.Colors.divider.opacity(0.5), lineWidth: 1)
                .frame(width: size * 0.6, height: size * 0.6)

            Circle()
                .stroke(AppTheme.Colors.divider.opacity(0.35), lineWidth: 1)
                .frame(width: size * 0.78, height: size * 0.78)

            Circle()
                .stroke(AppTheme.Colors.divider.opacity(0.2), lineWidth: 1)
                .frame(width: size * 0.95, height: size * 0.95)
        }
    }

    // MARK: - Orbiting Icons

    private var orbitingIcons: some View {
        let orbitRadius = size * 0.4
        let icons: [(String, Color, Double)] = [
            ("heart.fill", AppTheme.Colors.primaryPink, 0),
            ("moon.fill", AppTheme.Colors.articlePurple, 60),
            ("figure.run", AppTheme.Colors.tealAccent, 120),
            ("flame.fill", Color.orange, 180),
            ("figure.walk", Color.blue, 240),
            ("drop.fill", AppTheme.Colors.tealAccent, 300)
        ]

        return ZStack {
            ForEach(0..<icons.count, id: \.self) { index in
                let icon = icons[index]
                let angle = Angle.degrees(icon.2 - 90)
                let x = cos(angle.radians) * orbitRadius
                let y = sin(angle.radians) * orbitRadius

                ZStack {
                    Circle()
                        .fill(AppTheme.Colors.cardBackground)
                        .frame(width: size * 0.09, height: size * 0.09)
                        .subtleShadow()

                    Image(systemName: icon.0)
                        .font(.system(size: size * 0.035))
                        .foregroundColor(icon.1)
                }
                .offset(x: x, y: y)
            }
        }
    }

    // MARK: - Dotted Connection

    private var dottedConnection: some View {
        Path { path in
            path.move(to: CGPoint(x: size * 0.44, y: size * 0.46))
            path.addLine(to: CGPoint(x: size * 0.54, y: size * 0.42))
        }
        .stroke(
            AppTheme.Colors.textSecondary.opacity(0.4),
            style: StrokeStyle(lineWidth: 1.5, dash: [3, 3])
        )
    }
}

// MARK: - Bloom Leaf Shape

private struct BloomLeafShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        path.move(to: CGPoint(x: w * 0.5, y: 0))
        path.addCurve(
            to: CGPoint(x: w * 0.5, y: h),
            control1: CGPoint(x: w * 1.0, y: h * 0.15),
            control2: CGPoint(x: w * 0.9, y: h * 0.7)
        )
        path.addCurve(
            to: CGPoint(x: w * 0.5, y: 0),
            control1: CGPoint(x: w * 0.1, y: h * 0.7),
            control2: CGPoint(x: 0, y: h * 0.15)
        )

        return path
    }
}

#Preview {
    HealthDataIllustration()
        .padding(AppTheme.Spacing.xxl)
        .background(AppTheme.Colors.backgroundPink)
}
