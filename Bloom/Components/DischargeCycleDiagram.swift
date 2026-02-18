import SwiftUI

struct DischargeCycleDiagram: View {
    private let ringWidth: CGFloat = AppTheme.Spacing.xl
    private let ringSize: CGFloat = 260

    // Segment angles (in degrees, starting from 12 o'clock = -90 degrees)
    // Period: ~50°, Sticky post-period: ~55°, Creamy: ~40°,
    // Egg white/Fertile: ~60°, Creamy: ~40°, Sticky pre-period: ~55°, remaining gap: ~60°
    private let segments: [(label: String, startAngle: Double, endAngle: Double, color: SegmentColor)] = [
        ("Period", -90, -30, .period),
        ("Sticky", -30, 20, .light),
        ("Creamy", 20, 55, .light),
        ("Egg white", 55, 120, .fertile),
        ("Creamy", 120, 155, .light),
        ("Sticky", 155, 210, .light),
        ("Dry", 210, 270, .light)
    ]

    private enum SegmentColor {
        case period
        case fertile
        case light
    }

    var body: some View {
        ZStack {
            // Draw ring segments
            ForEach(segments.indices, id: \.self) { index in
                let segment = segments[index]
                arcSegment(
                    startAngle: segment.startAngle,
                    endAngle: segment.endAngle,
                    color: segmentColor(segment.color)
                )
            }

            // White dots at segment boundaries
            ForEach(segments.indices, id: \.self) { index in
                let angle = segments[index].startAngle
                dotMarker(at: angle)
            }

            // Labels
            segmentLabels
        }
        .frame(width: ringSize + labelPadding, height: ringSize + labelPadding)
    }

    // MARK: - Arc Segment

    private func arcSegment(startAngle: Double, endAngle: Double, color: Color) -> some View {
        Path { path in
            path.addArc(
                center: ringCenter,
                radius: ringRadius,
                startAngle: .degrees(startAngle),
                endAngle: .degrees(endAngle),
                clockwise: false
            )
        }
        .stroke(color, style: StrokeStyle(lineWidth: ringWidth, lineCap: .butt))
    }

    // MARK: - Dot Marker

    private func dotMarker(at angleDegrees: Double) -> some View {
        let point = pointOnRing(angle: angleDegrees)
        return Circle()
            .fill(AppTheme.Colors.cardBackground)
            .frame(width: dotSize, height: dotSize)
            .position(point)
    }

    // MARK: - Segment Labels

    private var segmentLabels: some View {
        ZStack {
            // Period label (top)
            segmentLabel("Period", angle: -60, color: AppTheme.Colors.periodRed, isBold: true, offset: labelOffset)

            // Fertile days label (bottom-right area)
            segmentLabel("Fertile days", angle: 87, color: AppTheme.Colors.tealAccent, isBold: true, offset: labelOffset)

            // Egg white badge
            badgeLabel("Egg white", angle: 87, color: AppTheme.Colors.dischargePurple, offset: innerBadgeOffset)

            // Sticky (post-period)
            badgeLabel("Sticky", angle: -5, color: AppTheme.Colors.dischargePurple, offset: innerBadgeOffset)

            // Creamy (pre-fertile)
            badgeLabel("Creamy", angle: 37, color: AppTheme.Colors.dischargePurple, offset: innerBadgeOffset)

            // Creamy (post-fertile)
            badgeLabel("Creamy", angle: 137, color: AppTheme.Colors.dischargePurple, offset: innerBadgeOffset)

            // Sticky (pre-period)
            badgeLabel("Sticky", angle: 182, color: AppTheme.Colors.dischargePurple, offset: innerBadgeOffset)
        }
    }

    // MARK: - Label Views

    private func segmentLabel(_ text: String, angle: Double, color: Color, isBold: Bool, offset: CGFloat) -> some View {
        let point = pointOnRing(angle: angle, radius: ringRadius + offset)
        return Text(text)
            .font(isBold ? AppTheme.Fonts.captionBold : AppTheme.Fonts.caption)
            .foregroundColor(color)
            .position(point)
    }

    private func badgeLabel(_ text: String, angle: Double, color: Color, offset: CGFloat) -> some View {
        let point = pointOnRing(angle: angle, radius: ringRadius - offset)
        return Text(text)
            .font(AppTheme.Fonts.caption)
            .foregroundColor(AppTheme.Colors.textWhite)
            .padding(.horizontal, AppTheme.Spacing.sm)
            .padding(.vertical, AppTheme.Spacing.xxs)
            .background(
                Capsule()
                    .fill(color)
            )
            .position(point)
    }

    // MARK: - Color Mapping

    private func segmentColor(_ type: SegmentColor) -> Color {
        switch type {
        case .period:
            return AppTheme.Colors.periodRed
        case .fertile:
            return AppTheme.Colors.tealAccent
        case .light:
            return AppTheme.Colors.divider
        }
    }

    // MARK: - Geometry Helpers

    private var ringCenter: CGPoint {
        CGPoint(x: (ringSize + labelPadding) / 2, y: (ringSize + labelPadding) / 2)
    }

    private var ringRadius: CGFloat {
        ringSize / 2
    }

    private func pointOnRing(angle: Double, radius: CGFloat? = nil) -> CGPoint {
        let r = radius ?? ringRadius
        let rad = angle * .pi / 180
        return CGPoint(
            x: ringCenter.x + r * cos(CGFloat(rad)),
            y: ringCenter.y + r * sin(CGFloat(rad))
        )
    }

    // MARK: - Sizes

    private var dotSize: CGFloat { AppTheme.Spacing.sm }
    private var labelPadding: CGFloat { AppTheme.Spacing.xxxl * 2 }
    private var labelOffset: CGFloat { AppTheme.Spacing.xxl }
    private var innerBadgeOffset: CGFloat { AppTheme.Spacing.xxl + AppTheme.Spacing.sm }
}

#Preview {
    DischargeCycleDiagram()
        .padding(AppTheme.Spacing.xl)
        .background(AppTheme.Colors.backgroundPink)
}
