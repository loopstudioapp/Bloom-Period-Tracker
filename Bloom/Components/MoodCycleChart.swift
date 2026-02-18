import SwiftUI

struct MoodCycleChart: View {
    var moodPoints: [MoodPoint] = OnboardingData.moodPoints
    var cyclePhases: [CyclePhase] = OnboardingData.cyclePhases

    var body: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            // Mood curve with emoji badges
            moodCurveSection
                .frame(height: chartHeight)

            // Phase color bar
            phaseBar
                .frame(height: phaseBarHeight)
                .clipShape(Capsule())

            // Phase labels
            phaseLabels
        }
    }

    // MARK: - Mood Curve

    private var moodCurveSection: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let insetHeight = height - badgeVerticalInset

            ZStack {
                // Smooth curve through mood points
                Path { path in
                    guard moodPoints.count >= 2 else { return }

                    let points = moodPoints.map { point in
                        CGPoint(
                            x: point.position * width,
                            y: insetHeight - (point.value * insetHeight) + badgeTopPadding
                        )
                    }

                    path.move(to: points[0])

                    for i in 1..<points.count {
                        let previous = points[i - 1]
                        let current = points[i]
                        let midX = (previous.x + current.x) / 2

                        path.addCurve(
                            to: current,
                            control1: CGPoint(x: midX, y: previous.y),
                            control2: CGPoint(x: midX, y: current.y)
                        )
                    }
                }
                .stroke(
                    AppTheme.Colors.primaryGradient,
                    style: StrokeStyle(lineWidth: curveLineWidth, lineCap: .round, lineJoin: .round)
                )

                // Emoji badges at each mood point
                ForEach(moodPoints) { point in
                    let x = point.position * width
                    let y = insetHeight - (point.value * insetHeight) + badgeTopPadding

                    VStack(spacing: AppTheme.Spacing.xxs) {
                        Text(point.emoji)
                            .font(.system(size: emojiSize))

                        Text(point.label)
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }
                    .position(x: x, y: y - badgeLabelOffset)
                }
            }
        }
    }

    // MARK: - Phase Bar

    private var phaseBar: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(cyclePhases) { phase in
                    Rectangle()
                        .fill(phase.color)
                        .frame(width: geometry.size.width * phase.widthFraction)
                }
            }
        }
    }

    // MARK: - Phase Labels

    private var phaseLabels: some View {
        HStack(spacing: 0) {
            ForEach(cyclePhases) { phase in
                Text(phase.name)
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
    }

    // MARK: - Constants

    private var chartHeight: CGFloat { 140 }
    private var phaseBarHeight: CGFloat { AppTheme.Spacing.sm }
    private var curveLineWidth: CGFloat { AppTheme.Spacing.xxs + 1 }
    private var emojiSize: CGFloat { AppTheme.Spacing.lg }
    private var badgeVerticalInset: CGFloat { AppTheme.Spacing.xxl }
    private var badgeTopPadding: CGFloat { AppTheme.Spacing.md }
    private var badgeLabelOffset: CGFloat { AppTheme.Spacing.xl }
}

#Preview {
    MoodCycleChart()
        .padding(AppTheme.Spacing.xl)
        .background(AppTheme.Colors.background)
}
