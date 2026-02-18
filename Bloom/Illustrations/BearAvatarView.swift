import SwiftUI

struct BearAvatarView: View {
    var size: CGFloat = 36
    var backgroundColor: Color = AppTheme.Colors.bearAvatarBlue
    var variant: BearVariant = .plain

    enum BearVariant {
        case plain
        case glasses
        case bow
        case hat
        case wink
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .frame(width: size, height: size)

            // Bear face
            bearFace
                .frame(width: size * 0.7, height: size * 0.7)
        }
        .accessibilityLabel("Bear avatar")
    }

    private var bearFace: some View {
        Canvas { context, canvasSize in
            let w = canvasSize.width
            let h = canvasSize.height

            // Ears
            let earSize = w * 0.28
            let leftEarCenter = CGPoint(x: w * 0.22, y: h * 0.18)
            let rightEarCenter = CGPoint(x: w * 0.78, y: h * 0.18)

            context.fill(
                Path(ellipseIn: CGRect(x: leftEarCenter.x - earSize / 2, y: leftEarCenter.y - earSize / 2, width: earSize, height: earSize)),
                with: .color(.white.opacity(0.9))
            )
            context.fill(
                Path(ellipseIn: CGRect(x: rightEarCenter.x - earSize / 2, y: rightEarCenter.y - earSize / 2, width: earSize, height: earSize)),
                with: .color(.white.opacity(0.9))
            )

            // Inner ears
            let innerEarSize = earSize * 0.55
            context.fill(
                Path(ellipseIn: CGRect(x: leftEarCenter.x - innerEarSize / 2, y: leftEarCenter.y - innerEarSize / 2, width: innerEarSize, height: innerEarSize)),
                with: .color(backgroundColor.opacity(0.5))
            )
            context.fill(
                Path(ellipseIn: CGRect(x: rightEarCenter.x - innerEarSize / 2, y: rightEarCenter.y - innerEarSize / 2, width: innerEarSize, height: innerEarSize)),
                with: .color(backgroundColor.opacity(0.5))
            )

            // Eyes
            let eyeSize = w * 0.08
            let eyeY = h * 0.48
            let leftEyeX = w * 0.36
            let rightEyeX = w * 0.64

            context.fill(
                Path(ellipseIn: CGRect(x: leftEyeX - eyeSize / 2, y: eyeY - eyeSize / 2, width: eyeSize, height: eyeSize)),
                with: .color(.white)
            )
            context.fill(
                Path(ellipseIn: CGRect(x: rightEyeX - eyeSize / 2, y: eyeY - eyeSize / 2, width: eyeSize, height: eyeSize)),
                with: .color(.white)
            )

            // Nose
            let noseSize = w * 0.08
            let noseCenter = CGPoint(x: w * 0.5, y: h * 0.58)
            context.fill(
                Path(ellipseIn: CGRect(x: noseCenter.x - noseSize / 2, y: noseCenter.y - noseSize * 0.35, width: noseSize, height: noseSize * 0.7)),
                with: .color(.white)
            )

            // Mouth
            var mouthPath = Path()
            mouthPath.move(to: CGPoint(x: w * 0.44, y: h * 0.64))
            mouthPath.addQuadCurve(to: CGPoint(x: w * 0.5, y: h * 0.68), control: CGPoint(x: w * 0.47, y: h * 0.68))
            mouthPath.addQuadCurve(to: CGPoint(x: w * 0.56, y: h * 0.64), control: CGPoint(x: w * 0.53, y: h * 0.68))
            context.stroke(mouthPath, with: .color(.white.opacity(0.8)), lineWidth: 1)
        }
    }
}

#Preview {
    HStack(spacing: 16) {
        BearAvatarView(size: 36, backgroundColor: AppTheme.Colors.bearAvatarBlue)
        BearAvatarView(size: 44, backgroundColor: AppTheme.Colors.avatarPurple)
        BearAvatarView(size: 44, backgroundColor: AppTheme.Colors.orangeAccent)
        BearAvatarView(size: 44, backgroundColor: AppTheme.Colors.avatarPink)
        BearAvatarView(size: 56, backgroundColor: AppTheme.Colors.bearAvatarBlue)
    }
    .padding()
}
