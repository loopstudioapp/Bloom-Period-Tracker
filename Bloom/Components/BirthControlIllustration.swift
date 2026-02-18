import SwiftUI

struct BirthControlIllustration: View {
    private let illustrationSize: CGFloat = 200

    var body: some View {
        ZStack {
            // Pill pack (back-left)
            pillPack
                .offset(x: -pillPackOffset, y: -pillPackOffset / 2)

            // Contraceptive ring (back-right)
            contraceptiveRing
                .offset(x: ringOffsetX, y: -ringOffsetY)

            // Contraceptive patch (front-left)
            contraceptivePatch
                .offset(x: -patchOffsetX, y: patchOffsetY)

            // Applicator (front-right)
            applicator
                .offset(x: applicatorOffsetX, y: applicatorOffsetY)
        }
        .frame(width: illustrationSize, height: illustrationSize)
    }

    // MARK: - Pill Pack

    private var pillPack: some View {
        ZStack {
            // Pack body
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                .fill(AppTheme.Colors.lightBlueIllustration)
                .frame(width: pillPackWidth, height: pillPackHeight)

            // Pill dots grid (4 rows x 7 columns)
            VStack(spacing: pillDotSpacing) {
                ForEach(0..<4, id: \.self) { row in
                    HStack(spacing: pillDotSpacing) {
                        ForEach(0..<7, id: \.self) { col in
                            Circle()
                                .fill(
                                    (row == 3 && col == 5)
                                        ? AppTheme.Colors.primaryPink.opacity(0.4)
                                        : AppTheme.Colors.cardBackground
                                )
                                .frame(width: pillDotSize, height: pillDotSize)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Contraceptive Patch

    private var contraceptivePatch: some View {
        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
            .strokeBorder(
                AppTheme.Colors.lightBlueIllustration,
                style: StrokeStyle(lineWidth: 2, dash: [4, 3])
            )
            .frame(width: patchSize, height: patchSize)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                    .fill(AppTheme.Colors.lightBlueIllustration.opacity(0.15))
            )
    }

    // MARK: - Contraceptive Ring

    private var contraceptiveRing: some View {
        Circle()
            .stroke(AppTheme.Colors.navyDark, lineWidth: ringStrokeWidth)
            .frame(width: ringDiameter, height: ringDiameter)
    }

    // MARK: - Applicator

    private var applicator: some View {
        Capsule()
            .fill(AppTheme.Colors.primaryPink)
            .frame(width: applicatorWidth, height: applicatorHeight)
            .rotationEffect(.degrees(-30))
    }

    // MARK: - Sizes

    private var pillPackWidth: CGFloat { illustrationSize * 0.5 }
    private var pillPackHeight: CGFloat { illustrationSize * 0.35 }
    private var pillDotSize: CGFloat { AppTheme.Spacing.xs }
    private var pillDotSpacing: CGFloat { AppTheme.Spacing.xxs + 1 }
    private var patchSize: CGFloat { illustrationSize * 0.22 }
    private var ringDiameter: CGFloat { illustrationSize * 0.28 }
    private var ringStrokeWidth: CGFloat { AppTheme.Spacing.xs }
    private var applicatorWidth: CGFloat { illustrationSize * 0.12 }
    private var applicatorHeight: CGFloat { illustrationSize * 0.35 }

    // Offsets derived from spacing
    private var pillPackOffset: CGFloat { AppTheme.Spacing.lg }
    private var ringOffsetX: CGFloat { AppTheme.Spacing.xxl + AppTheme.Spacing.sm }
    private var ringOffsetY: CGFloat { AppTheme.Spacing.md }
    private var patchOffsetX: CGFloat { AppTheme.Spacing.xl }
    private var patchOffsetY: CGFloat { AppTheme.Spacing.xxl }
    private var applicatorOffsetX: CGFloat { AppTheme.Spacing.xxl }
    private var applicatorOffsetY: CGFloat { AppTheme.Spacing.lg }
}

#Preview {
    BirthControlIllustration()
        .padding(AppTheme.Spacing.xxxl)
        .background(AppTheme.Colors.backgroundPink)
}
