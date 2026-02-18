import SwiftUI

// MARK: - Petal Shape

struct PetalShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width / 2, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: width / 2, y: height),
            control: CGPoint(x: width, y: height * 0.3)
        )
        path.addQuadCurve(
            to: CGPoint(x: width / 2, y: 0),
            control: CGPoint(x: 0, y: height * 0.3)
        )

        return path
    }
}

// MARK: - Leaf Shape

struct LeafShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: 0, y: height))
        path.addQuadCurve(
            to: CGPoint(x: width, y: 0),
            control: CGPoint(x: 0, y: 0)
        )
        path.addQuadCurve(
            to: CGPoint(x: 0, y: height),
            control: CGPoint(x: width, y: height)
        )

        return path
    }
}

// MARK: - Flower View

struct FlowerView: View {
    var petalColor: Color = AppTheme.Colors.primaryPink
    var centerColor: Color = AppTheme.Colors.avatarPink
    var size: CGFloat = 30
    var petalCount: Int = 6

    var body: some View {
        ZStack {
            // Petals arranged in a circle
            ForEach(0..<petalCount, id: \.self) { index in
                PetalShape()
                    .fill(petalColor.opacity(petalOpacity))
                    .frame(width: petalWidth, height: petalHeight)
                    .offset(y: -petalOffset)
                    .rotationEffect(.degrees(Double(index) * (360.0 / Double(petalCount))))
            }

            // Center dot
            Circle()
                .fill(centerColor)
                .frame(width: centerSize, height: centerSize)
        }
        .frame(width: size, height: size)
    }

    // MARK: - Private Helpers

    private var petalWidth: CGFloat { size * 0.3 }
    private var petalHeight: CGFloat { size * 0.4 }
    private var petalOffset: CGFloat { size * 0.15 }
    private var centerSize: CGFloat { size * 0.2 }
    private var petalOpacity: Double { 0.7 }
}

// MARK: - Dandelion View

struct DandelionView: View {
    var color: Color = AppTheme.Colors.tealAccent
    var size: CGFloat = 40
    var lineCount: Int = 8

    var body: some View {
        ZStack {
            // Stem
            Rectangle()
                .fill(color.opacity(stemOpacity))
                .frame(width: stemWidth, height: stemHeight)
                .offset(y: stemOffset)

            // Radiating lines
            ForEach(0..<lineCount, id: \.self) { index in
                Capsule()
                    .fill(color.opacity(lineOpacity))
                    .frame(width: lineWidth, height: lineHeight)
                    .offset(y: -lineOffsetY)
                    .rotationEffect(.degrees(Double(index) * (360.0 / Double(lineCount))))
            }

            // Center circle
            Circle()
                .fill(color.opacity(centerOpacity))
                .frame(width: centerDotSize, height: centerDotSize)

            // Tip dots
            ForEach(0..<lineCount, id: \.self) { index in
                Circle()
                    .fill(color.opacity(tipDotOpacity))
                    .frame(width: tipDotSize, height: tipDotSize)
                    .offset(y: -tipDotOffset)
                    .rotationEffect(.degrees(Double(index) * (360.0 / Double(lineCount))))
            }
        }
        .frame(width: size, height: size + stemHeight)
    }

    // MARK: - Private Helpers

    private var stemWidth: CGFloat { size * 0.04 }
    private var stemHeight: CGFloat { size * 0.5 }
    private var stemOffset: CGFloat { size * 0.35 }
    private var stemOpacity: Double { 0.5 }
    private var lineWidth: CGFloat { size * 0.02 }
    private var lineHeight: CGFloat { size * 0.35 }
    private var lineOffsetY: CGFloat { size * 0.15 }
    private var lineOpacity: Double { 0.6 }
    private var centerDotSize: CGFloat { size * 0.1 }
    private var centerOpacity: Double { 0.7 }
    private var tipDotSize: CGFloat { size * 0.06 }
    private var tipDotOffset: CGFloat { size * 0.32 }
    private var tipDotOpacity: Double { 0.8 }
}

// MARK: - Floral Corner Decoration

enum FloralDecorationStyle {
    case topRight
    case topLeft
    case bottomRight
    case scattered
}

struct FloralCornerDecoration: View {
    var style: FloralDecorationStyle = .topRight

    var body: some View {
        switch style {
        case .topRight:
            topRightDecoration
        case .topLeft:
            topLeftDecoration
        case .bottomRight:
            bottomRightDecoration
        case .scattered:
            scatteredDecoration
        }
    }

    // MARK: - Style Variants

    private var topRightDecoration: some View {
        ZStack {
            FlowerView(
                petalColor: AppTheme.Colors.primaryPink,
                centerColor: AppTheme.Colors.avatarPink,
                size: largeFlowerSize
            )
            .offset(x: AppTheme.Spacing.lg, y: -AppTheme.Spacing.md)

            LeafShape()
                .fill(AppTheme.Colors.tealAccent.opacity(leafOpacity))
                .frame(width: leafWidth, height: leafHeight)
                .rotationEffect(.degrees(-30))
                .offset(x: -AppTheme.Spacing.sm, y: AppTheme.Spacing.md)

            FlowerView(
                petalColor: AppTheme.Colors.avatarTeal,
                centerColor: AppTheme.Colors.tealAccent,
                size: smallFlowerSize,
                petalCount: 5
            )
            .offset(x: AppTheme.Spacing.xxxl, y: AppTheme.Spacing.lg)

            DandelionView(
                color: AppTheme.Colors.tealAccent,
                size: dandelionSize
            )
            .offset(x: -AppTheme.Spacing.md, y: -AppTheme.Spacing.xxl)
        }
        .frame(width: decorationFrameSize, height: decorationFrameSize)
    }

    private var topLeftDecoration: some View {
        ZStack {
            FlowerView(
                petalColor: AppTheme.Colors.avatarPink,
                centerColor: AppTheme.Colors.primaryPink,
                size: mediumFlowerSize
            )
            .offset(x: -AppTheme.Spacing.md, y: -AppTheme.Spacing.sm)

            LeafShape()
                .fill(AppTheme.Colors.tealAccent.opacity(leafOpacity))
                .frame(width: leafWidth, height: leafHeight)
                .rotationEffect(.degrees(45))
                .offset(x: AppTheme.Spacing.lg, y: AppTheme.Spacing.sm)

            FlowerView(
                petalColor: AppTheme.Colors.primaryPink,
                centerColor: AppTheme.Colors.avatarPink,
                size: tinyFlowerSize,
                petalCount: 5
            )
            .offset(x: -AppTheme.Spacing.xxl, y: AppTheme.Spacing.xl)
        }
        .frame(width: decorationFrameSize, height: decorationFrameSize)
    }

    private var bottomRightDecoration: some View {
        ZStack {
            LeafShape()
                .fill(AppTheme.Colors.tealAccent.opacity(leafOpacity))
                .frame(width: largeLeafWidth, height: largeLeafHeight)
                .rotationEffect(.degrees(-60))
                .offset(x: AppTheme.Spacing.md, y: AppTheme.Spacing.sm)

            FlowerView(
                petalColor: AppTheme.Colors.primaryPink,
                centerColor: AppTheme.Colors.avatarPink,
                size: smallFlowerSize
            )
            .offset(x: AppTheme.Spacing.xxl, y: -AppTheme.Spacing.sm)

            LeafShape()
                .fill(AppTheme.Colors.avatarTeal.opacity(leafOpacity))
                .frame(width: leafWidth, height: leafHeight)
                .rotationEffect(.degrees(120))
                .offset(x: -AppTheme.Spacing.sm, y: AppTheme.Spacing.lg)
        }
        .frame(width: decorationFrameSize, height: decorationFrameSize)
    }

    private var scatteredDecoration: some View {
        ZStack {
            FlowerView(
                petalColor: AppTheme.Colors.primaryPink,
                centerColor: AppTheme.Colors.avatarPink,
                size: smallFlowerSize,
                petalCount: 5
            )
            .offset(x: -AppTheme.Spacing.xxl, y: -AppTheme.Spacing.lg)

            FlowerView(
                petalColor: AppTheme.Colors.avatarTeal,
                centerColor: AppTheme.Colors.tealAccent,
                size: tinyFlowerSize,
                petalCount: 6
            )
            .offset(x: AppTheme.Spacing.xl, y: -AppTheme.Spacing.md)

            DandelionView(
                color: AppTheme.Colors.tealAccent,
                size: smallDandelionSize
            )
            .offset(x: AppTheme.Spacing.sm, y: AppTheme.Spacing.xl)

            LeafShape()
                .fill(AppTheme.Colors.tealAccent.opacity(leafOpacity))
                .frame(width: smallLeafWidth, height: smallLeafHeight)
                .rotationEffect(.degrees(-45))
                .offset(x: -AppTheme.Spacing.lg, y: AppTheme.Spacing.md)

            FlowerView(
                petalColor: AppTheme.Colors.avatarPink,
                centerColor: AppTheme.Colors.primaryPink,
                size: tinyFlowerSize
            )
            .offset(x: AppTheme.Spacing.xxxl, y: AppTheme.Spacing.lg)
        }
        .frame(width: scatteredFrameSize, height: scatteredFrameSize)
    }

    // MARK: - Constants

    private var largeFlowerSize: CGFloat { AppTheme.Spacing.xxl + AppTheme.Spacing.sm }
    private var mediumFlowerSize: CGFloat { AppTheme.Spacing.xxl }
    private var smallFlowerSize: CGFloat { AppTheme.Spacing.xl }
    private var tinyFlowerSize: CGFloat { AppTheme.Spacing.md }
    private var dandelionSize: CGFloat { AppTheme.Spacing.xl }
    private var smallDandelionSize: CGFloat { AppTheme.Spacing.lg }
    private var leafWidth: CGFloat { AppTheme.Spacing.lg }
    private var leafHeight: CGFloat { AppTheme.Spacing.xxl }
    private var largeLeafWidth: CGFloat { AppTheme.Spacing.xl }
    private var largeLeafHeight: CGFloat { AppTheme.Spacing.xxxl }
    private var smallLeafWidth: CGFloat { AppTheme.Spacing.md }
    private var smallLeafHeight: CGFloat { AppTheme.Spacing.xl }
    private var leafOpacity: Double { 0.5 }
    private var decorationFrameSize: CGFloat { 120 }
    private var scatteredFrameSize: CGFloat { 200 }
}

#Preview {
    ZStack {
        AppTheme.Colors.background

        VStack(spacing: AppTheme.Spacing.xxxl) {
            HStack {
                FloralCornerDecoration(style: .topLeft)
                Spacer()
                FloralCornerDecoration(style: .topRight)
            }

            HStack(spacing: AppTheme.Spacing.xl) {
                FlowerView(petalColor: AppTheme.Colors.primaryPink, size: 50)
                DandelionView(color: AppTheme.Colors.tealAccent, size: 50)
                FlowerView(petalColor: AppTheme.Colors.avatarTeal, centerColor: AppTheme.Colors.tealAccent, size: 40, petalCount: 5)
            }

            FloralCornerDecoration(style: .scattered)

            HStack {
                Spacer()
                FloralCornerDecoration(style: .bottomRight)
            }
        }
        .padding(AppTheme.Spacing.xl)
    }
}
