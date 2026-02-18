import SwiftUI

// MARK: - Bloom Logo View
struct BloomLogoView: View {
    var size: CGFloat = 120
    var petalColor: Color = AppTheme.Colors.textWhite

    var body: some View {
        ZStack {
            // Overlapping petals arranged in a flower pattern
            ForEach(0..<5, id: \.self) { index in
                petalShape
                    .rotationEffect(.degrees(Double(index) * 72))
            }

            // Center circle
            Circle()
                .fill(petalColor.opacity(0.9))
                .frame(width: size * 0.25, height: size * 0.25)
        }
        .frame(width: size, height: size)
    }

    private var petalShape: some View {
        Ellipse()
            .fill(
                LinearGradient(
                    colors: [
                        petalColor.opacity(0.8),
                        petalColor.opacity(0.5)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: size * 0.35, height: size * 0.55)
            .offset(y: -size * 0.15)
    }
}

// MARK: - Shield Illustration
struct ShieldIllustration: View {
    var size: CGFloat = 160

    var body: some View {
        ZStack {
            // Small gear/cog icons around the shield
            ForEach(0..<4, id: \.self) { index in
                gearIcon
                    .offset(
                        x: cos(CGFloat(index) * .pi / 2 + .pi / 4) * size * 0.55,
                        y: sin(CGFloat(index) * .pi / 2 + .pi / 4) * size * 0.55
                    )
            }

            // Shield shape
            ShieldShape()
                .fill(
                    LinearGradient(
                        colors: [
                            AppTheme.Colors.primaryPink.opacity(0.15),
                            AppTheme.Colors.primaryPink.opacity(0.05)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: size * 0.7, height: size * 0.85)

            ShieldShape()
                .stroke(AppTheme.Colors.primaryPink, lineWidth: 2)
                .frame(width: size * 0.7, height: size * 0.85)

            // Bloom flower inside shield
            BloomLogoView(size: size * 0.3, petalColor: AppTheme.Colors.primaryPink)
                .offset(y: -size * 0.05)
        }
        .frame(width: size, height: size)
    }

    private var gearIcon: some View {
        Image(systemName: "gearshape.fill")
            .font(.system(size: size * 0.1))
            .foregroundColor(AppTheme.Colors.orangeAccent.opacity(0.6))
    }
}

// MARK: - Shield Shape
struct ShieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        path.move(to: CGPoint(x: w * 0.5, y: 0))
        path.addLine(to: CGPoint(x: w, y: h * 0.15))
        path.addLine(to: CGPoint(x: w, y: h * 0.55))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.5, y: h),
            control: CGPoint(x: w * 0.85, y: h * 0.85)
        )
        path.addQuadCurve(
            to: CGPoint(x: 0, y: h * 0.55),
            control: CGPoint(x: w * 0.15, y: h * 0.85)
        )
        path.addLine(to: CGPoint(x: 0, y: h * 0.15))
        path.closeSubpath()

        return path
    }
}

// MARK: - Woman Holding Phone Illustration
struct WomanHoldingPhoneIllustration: View {
    var size: CGFloat = 180

    var body: some View {
        ZStack {
            // Circular arrow around the figure
            Circle()
                .trim(from: 0.05, to: 0.85)
                .stroke(
                    AppTheme.Colors.primaryPink.opacity(0.3),
                    style: StrokeStyle(lineWidth: size * 0.02, lineCap: .round)
                )
                .frame(width: size * 0.9, height: size * 0.9)
                .rotationEffect(.degrees(-90))

            // Arrow tip on the circular path
            Image(systemName: "arrowtriangle.right.fill")
                .font(.system(size: size * 0.06))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.4))
                .offset(x: size * 0.42, y: -size * 0.12)

            VStack(spacing: 0) {
                // Head
                Circle()
                    .fill(AppTheme.Colors.primaryPink.opacity(0.6))
                    .frame(width: size * 0.2, height: size * 0.2)

                // Body
                RoundedRectangle(cornerRadius: size * 0.08)
                    .fill(AppTheme.Colors.primaryPink.opacity(0.4))
                    .frame(width: size * 0.25, height: size * 0.35)
                    .offset(y: -size * 0.01)

                // Phone in hands
                RoundedRectangle(cornerRadius: size * 0.02)
                    .fill(AppTheme.Colors.textPrimary.opacity(0.7))
                    .frame(width: size * 0.1, height: size * 0.15)
                    .offset(x: size * 0.1, y: -size * 0.2)
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Alarm With Hearts Icon
struct AlarmWithHeartsIcon: View {
    var size: CGFloat = 48

    var body: some View {
        ZStack {
            // Alarm clock body
            ZStack {
                // Clock face
                Circle()
                    .fill(AppTheme.Colors.textWhite)
                    .frame(width: size * 0.6, height: size * 0.6)

                Circle()
                    .stroke(AppTheme.Colors.textPrimary.opacity(0.7), lineWidth: size * 0.04)
                    .frame(width: size * 0.6, height: size * 0.6)

                // Clock hands
                Rectangle()
                    .fill(AppTheme.Colors.textPrimary.opacity(0.7))
                    .frame(width: size * 0.03, height: size * 0.18)
                    .offset(y: -size * 0.07)

                Rectangle()
                    .fill(AppTheme.Colors.textPrimary.opacity(0.7))
                    .frame(width: size * 0.03, height: size * 0.12)
                    .rotationEffect(.degrees(90))
                    .offset(x: size * 0.04)

                // Alarm bells (top arcs)
                Circle()
                    .trim(from: 0.55, to: 0.75)
                    .stroke(AppTheme.Colors.textPrimary.opacity(0.7), lineWidth: size * 0.04)
                    .frame(width: size * 0.35, height: size * 0.35)
                    .offset(x: -size * 0.2, y: -size * 0.28)

                Circle()
                    .trim(from: 0.25, to: 0.45)
                    .stroke(AppTheme.Colors.textPrimary.opacity(0.7), lineWidth: size * 0.04)
                    .frame(width: size * 0.35, height: size * 0.35)
                    .offset(x: size * 0.2, y: -size * 0.28)
            }

            // Floating hearts
            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.15))
                .foregroundColor(AppTheme.Colors.primaryPink)
                .offset(x: size * 0.35, y: -size * 0.25)

            Image(systemName: "heart.fill")
                .font(.system(size: size * 0.1))
                .foregroundColor(AppTheme.Colors.primaryPink.opacity(0.6))
                .offset(x: size * 0.25, y: -size * 0.38)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Woman With Lightning Icon
struct WomanWithLightningIcon: View {
    var size: CGFloat = 48

    var body: some View {
        ZStack {
            // Simplified figure
            VStack(spacing: size * 0.02) {
                // Head
                Circle()
                    .fill(AppTheme.Colors.primaryPink.opacity(0.6))
                    .frame(width: size * 0.22, height: size * 0.22)

                // Body
                RoundedRectangle(cornerRadius: size * 0.06)
                    .fill(AppTheme.Colors.primaryPink.opacity(0.4))
                    .frame(width: size * 0.2, height: size * 0.35)
            }

            // Lightning bolts
            Image(systemName: "bolt.fill")
                .font(.system(size: size * 0.18))
                .foregroundColor(AppTheme.Colors.orangeAccent)
                .offset(x: size * 0.28, y: -size * 0.15)

            Image(systemName: "bolt.fill")
                .font(.system(size: size * 0.12))
                .foregroundColor(AppTheme.Colors.orangeAccent.opacity(0.6))
                .offset(x: -size * 0.28, y: size * 0.05)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Circular Arrow Icon
struct CircularArrowIcon: View {
    var size: CGFloat = 48

    var body: some View {
        ZStack {
            // Circular arrow
            Circle()
                .trim(from: 0.05, to: 0.85)
                .stroke(
                    AppTheme.Colors.primaryPink,
                    style: StrokeStyle(lineWidth: size * 0.06, lineCap: .round)
                )
                .frame(width: size * 0.7, height: size * 0.7)
                .rotationEffect(.degrees(-90))

            // Arrow tip
            Image(systemName: "arrowtriangle.right.fill")
                .font(.system(size: size * 0.1))
                .foregroundColor(AppTheme.Colors.primaryPink)
                .offset(x: size * 0.32, y: -size * 0.1)

            // "Period" label
            Text("Period")
                .font(.system(size: size * 0.14, weight: .semibold, design: .rounded))
                .foregroundColor(AppTheme.Colors.primaryPink)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Large Number Icon
struct LargeNumberIcon: View {
    var size: CGFloat = 48

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .fill(AppTheme.Colors.primaryPink.opacity(0.1))
                .frame(width: size * 0.8, height: size * 0.8)

            // Bold "12" number
            Text("12")
                .font(.system(size: size * 0.4, weight: .bold, design: .rounded))
                .foregroundColor(AppTheme.Colors.primaryPink)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Previews
#Preview("Bloom Logo") {
    ZStack {
        AppTheme.Colors.primaryPink
            .ignoresSafeArea()
        BloomLogoView()
    }
}

#Preview("Shield") {
    ShieldIllustration()
        .padding(AppTheme.Spacing.xxl)
}

#Preview("Woman Holding Phone") {
    WomanHoldingPhoneIllustration()
        .padding(AppTheme.Spacing.xxl)
}

#Preview("Feature Icons") {
    HStack(spacing: AppTheme.Spacing.xl) {
        AlarmWithHeartsIcon()
        WomanWithLightningIcon()
        CircularArrowIcon()
        LargeNumberIcon()
    }
    .padding(AppTheme.Spacing.xxl)
}
