import SwiftUI

struct PartnerIllustration: View {
    private let size: CGFloat = 300
    private let height: CGFloat = 280

    var body: some View {
        ZStack {
            // Dashed curved lines connecting phones
            dashedConnection

            // Woman (left)
            womanFigure
                .offset(x: -size * 0.18, y: size * 0.02)

            // Man (right)
            manFigure
                .offset(x: size * 0.18, y: -size * 0.01)

            // Speech bubble from man
            speechBubble
                .offset(x: size * 0.12, y: -size * 0.32)
        }
        .frame(width: size, height: height)
    }

    // MARK: - Woman Figure

    private var womanFigure: some View {
        ZStack {
            // Afro hair (wider circle behind head)
            Circle()
                .fill(AppTheme.Colors.hairDark)
                .frame(width: size * 0.14, height: size * 0.14)
                .offset(y: -height * 0.28)

            // Head
            Circle()
                .fill(AppTheme.Colors.skinToneDark)
                .frame(width: size * 0.1, height: size * 0.1)
                .offset(y: -height * 0.27)

            // Afro top
            Ellipse()
                .fill(AppTheme.Colors.hairDark)
                .frame(width: size * 0.14, height: size * 0.08)
                .offset(y: -height * 0.33)

            // Neck
            Capsule()
                .fill(AppTheme.Colors.skinToneDark)
                .frame(width: size * 0.03, height: height * 0.04)
                .offset(y: -height * 0.21)

            // White top
            RoundedRectangle(cornerRadius: size * 0.02)
                .fill(AppTheme.Colors.cardBackground)
                .frame(width: size * 0.12, height: height * 0.14)
                .offset(y: -height * 0.12)

            // Arms
            Capsule()
                .fill(AppTheme.Colors.skinToneDark)
                .frame(width: size * 0.04, height: height * 0.12)
                .rotationEffect(.degrees(10))
                .offset(x: -size * 0.08, y: -height * 0.1)

            // Right arm (holding phone)
            Capsule()
                .fill(AppTheme.Colors.skinToneDark)
                .frame(width: size * 0.04, height: height * 0.12)
                .rotationEffect(.degrees(-5))
                .offset(x: size * 0.08, y: -height * 0.08)

            // Phone in right hand
            RoundedRectangle(cornerRadius: size * 0.01)
                .fill(AppTheme.Colors.articlePurple)
                .frame(width: size * 0.04, height: size * 0.07)
                .offset(x: size * 0.09, y: -height * 0.01)

            // Lime green pants
            RoundedRectangle(cornerRadius: size * 0.02)
                .fill(AppTheme.Colors.limeGreen)
                .frame(width: size * 0.12, height: height * 0.16)
                .offset(y: -height * 0.0)

            // Left leg
            Capsule()
                .fill(AppTheme.Colors.limeGreen)
                .frame(width: size * 0.05, height: height * 0.16)
                .offset(x: -size * 0.02, y: height * 0.12)

            // Right leg
            Capsule()
                .fill(AppTheme.Colors.limeGreen)
                .frame(width: size * 0.05, height: height * 0.16)
                .offset(x: size * 0.02, y: height * 0.12)
        }
    }

    // MARK: - Man Figure

    private var manFigure: some View {
        ZStack {
            // Hair
            Ellipse()
                .fill(AppTheme.Colors.hairDark)
                .frame(width: size * 0.11, height: size * 0.07)
                .offset(y: -height * 0.32)

            // Head
            Circle()
                .fill(AppTheme.Colors.skinToneLight)
                .frame(width: size * 0.1, height: size * 0.1)
                .offset(y: -height * 0.27)

            // Beard
            Ellipse()
                .fill(AppTheme.Colors.hairDark.opacity(0.6))
                .frame(width: size * 0.07, height: size * 0.04)
                .offset(y: -height * 0.23)

            // Neck
            Capsule()
                .fill(AppTheme.Colors.skinToneLight)
                .frame(width: size * 0.03, height: height * 0.04)
                .offset(y: -height * 0.21)

            // Teal shirt
            RoundedRectangle(cornerRadius: size * 0.02)
                .fill(AppTheme.Colors.tealShirt)
                .frame(width: size * 0.14, height: height * 0.15)
                .offset(y: -height * 0.12)

            // Arms
            Capsule()
                .fill(AppTheme.Colors.tealShirt)
                .frame(width: size * 0.04, height: height * 0.12)
                .rotationEffect(.degrees(-10))
                .offset(x: size * 0.09, y: -height * 0.1)

            // Left arm (holding phone)
            Capsule()
                .fill(AppTheme.Colors.tealShirt)
                .frame(width: size * 0.04, height: height * 0.12)
                .rotationEffect(.degrees(5))
                .offset(x: -size * 0.09, y: -height * 0.08)

            // Phone in left hand with pink icon
            ZStack {
                RoundedRectangle(cornerRadius: size * 0.01)
                    .fill(AppTheme.Colors.textPrimary)
                    .frame(width: size * 0.04, height: size * 0.07)

                Circle()
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: size * 0.015, height: size * 0.015)
            }
            .offset(x: -size * 0.1, y: -height * 0.01)

            // Dark pants
            RoundedRectangle(cornerRadius: size * 0.02)
                .fill(AppTheme.Colors.textPrimary)
                .frame(width: size * 0.13, height: height * 0.16)
                .offset(y: height * 0.0)

            // Left leg
            Capsule()
                .fill(AppTheme.Colors.textPrimary)
                .frame(width: size * 0.05, height: height * 0.16)
                .offset(x: -size * 0.02, y: height * 0.12)

            // Right leg
            Capsule()
                .fill(AppTheme.Colors.textPrimary)
                .frame(width: size * 0.05, height: height * 0.16)
                .offset(x: size * 0.02, y: height * 0.12)
        }
    }

    // MARK: - Speech Bubble

    private var speechBubble: some View {
        ZStack {
            // Bubble body
            VStack(spacing: 0) {
                Text("How can I support")
                    .font(.system(size: 8, weight: .medium, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textPrimary)
                Text("her better?")
                    .font(.system(size: 8, weight: .medium, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }
            .padding(.horizontal, AppTheme.Spacing.sm)
            .padding(.vertical, AppTheme.Spacing.xs)
            .background(
                SpeechBubbleShape()
                    .fill(AppTheme.Colors.cardBackground)
                    .subtleShadow()
            )
        }
    }

    // MARK: - Dashed Connection

    private var dashedConnection: some View {
        Path { path in
            path.move(to: CGPoint(x: size * 0.38, y: height * 0.48))
            path.addCurve(
                to: CGPoint(x: size * 0.55, y: height * 0.48),
                control1: CGPoint(x: size * 0.43, y: height * 0.55),
                control2: CGPoint(x: size * 0.5, y: height * 0.55)
            )
        }
        .stroke(
            AppTheme.Colors.primaryPink.opacity(0.4),
            style: StrokeStyle(lineWidth: 1.5, dash: [4, 3])
        )
    }
}

// MARK: - Speech Bubble Shape

private struct SpeechBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius: CGFloat = 8
        let tailSize: CGFloat = 6

        // Main rounded rectangle
        path.addRoundedRect(
            in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height - tailSize),
            cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
        )

        // Tail pointing down
        let tailCenter = rect.width * 0.3
        path.move(to: CGPoint(x: tailCenter - tailSize, y: rect.height - tailSize))
        path.addLine(to: CGPoint(x: tailCenter, y: rect.height))
        path.addLine(to: CGPoint(x: tailCenter + tailSize, y: rect.height - tailSize))

        return path
    }
}

#Preview {
    PartnerIllustration()
        .padding(AppTheme.Spacing.xxl)
        .background(AppTheme.Colors.backgroundPink)
}
