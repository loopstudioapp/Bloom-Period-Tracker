import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(AppTheme.Colors.divider)
                    .frame(height: barHeight)

                Capsule()
                    .fill(AppTheme.Colors.primaryGradient)
                    .frame(
                        width: max(barHeight, geometry.size.width * clampedProgress),
                        height: barHeight
                    )
                    .animation(AppTheme.Animation.standard, value: progress)
            }
        }
        .frame(height: barHeight)
    }

    // MARK: - Private Helpers

    private var barHeight: CGFloat {
        AppTheme.Spacing.xs
    }

    private var clampedProgress: CGFloat {
        min(max(progress, 0.0), 1.0)
    }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.xl) {
        ProgressBar(progress: 0.0)
        ProgressBar(progress: 0.25)
        ProgressBar(progress: 0.5)
        ProgressBar(progress: 0.75)
        ProgressBar(progress: 1.0)
    }
    .padding(AppTheme.Spacing.xl)
}
