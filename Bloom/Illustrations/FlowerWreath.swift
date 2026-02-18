import SwiftUI
import Foundation

struct FlowerWreath: View {
    var size: CGFloat = 300

    var body: some View {
        Canvas { context, canvasSize in
            let centerX: CGFloat = canvasSize.width / 2
            let centerY: CGFloat = canvasSize.height / 2
            let radius: CGFloat = min(canvasSize.width, canvasSize.height) * 0.42

            drawFlowers(context: context, centerX: centerX, centerY: centerY, radius: radius)
            drawStars(context: context, centerX: centerX, centerY: centerY, radius: radius)
        }
        .frame(width: size, height: size)
    }

    private func drawFlowers(context: GraphicsContext, centerX: CGFloat, centerY: CGFloat, radius: CGFloat) {
        for i in 0..<7 {
            let angle: Double = (Double(i) / 7.0) * Double.pi * 2.0 - Double.pi / 2.0
            let fx: CGFloat = centerX + CGFloat(Darwin.cos(angle)) * radius
            let fy: CGFloat = centerY + CGFloat(Darwin.sin(angle)) * radius
            drawFlower(context: context, cx: fx, cy: fy, petalSize: size * 0.06)
        }
    }

    private func drawStars(context: GraphicsContext, centerX: CGFloat, centerY: CGFloat, radius: CGFloat) {
        for i in 0..<7 {
            let angle: Double = (Double(i) / 7.0) * Double.pi * 2.0 - Double.pi / 2.0 + (Double.pi / 7.0)
            let sr: CGFloat = radius * 0.85
            let sx: CGFloat = centerX + CGFloat(Darwin.cos(angle)) * sr
            let sy: CGFloat = centerY + CGFloat(Darwin.sin(angle)) * sr
            drawStar(context: context, cx: sx, cy: sy, s: size * 0.02)
        }
    }

    private func drawFlower(context: GraphicsContext, cx: CGFloat, cy: CGFloat, petalSize: CGFloat) {
        let flowerColor = AppTheme.Colors.flowerPeach

        for i in 0..<6 {
            let angle: Double = (Double(i) / 6.0) * Double.pi * 2.0
            let offset: CGFloat = petalSize * 0.6
            let px: CGFloat = cx + CGFloat(Darwin.cos(angle)) * offset
            let py: CGFloat = cy + CGFloat(Darwin.sin(angle)) * offset
            let halfW: CGFloat = petalSize / 2
            let halfH: CGFloat = petalSize * 0.35

            let rect = CGRect(x: px - halfW, y: py - halfH, width: petalSize, height: petalSize * 0.7)
            context.fill(Path(ellipseIn: rect), with: .color(flowerColor))
        }

        let cs: CGFloat = petalSize * 0.4
        let centerRect = CGRect(x: cx - cs / 2, y: cy - cs / 2, width: cs, height: cs)
        context.fill(Path(ellipseIn: centerRect), with: .color(flowerColor.opacity(0.8)))
    }

    private func drawStar(context: GraphicsContext, cx: CGFloat, cy: CGFloat, s: CGFloat) {
        var path = Path()
        let s3: CGFloat = s * 0.3
        path.move(to: CGPoint(x: cx, y: cy - s))
        path.addLine(to: CGPoint(x: cx + s3, y: cy - s3))
        path.addLine(to: CGPoint(x: cx + s, y: cy))
        path.addLine(to: CGPoint(x: cx + s3, y: cy + s3))
        path.addLine(to: CGPoint(x: cx, y: cy + s))
        path.addLine(to: CGPoint(x: cx - s3, y: cy + s3))
        path.addLine(to: CGPoint(x: cx - s, y: cy))
        path.addLine(to: CGPoint(x: cx - s3, y: cy - s3))
        path.closeSubpath()

        context.fill(path, with: .color(AppTheme.Colors.flowerPeach.opacity(0.6)))
    }
}

#Preview {
    FlowerWreath(size: 300)
}
