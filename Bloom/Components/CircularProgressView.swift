import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    var lineWidth: CGFloat = 8
    var size: CGFloat = 120

    var body: some View {
        ZStack {
            // Background track circle
            Circle()
                .stroke(
                    AppTheme.Colors.progressTrack,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )

            // Foreground progress arc
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(
                    AppTheme.Colors.primaryPink,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)

            // Center percentage text
            VStack(spacing: 0) {
                HStack(alignment: .firstTextBaseline, spacing: AppTheme.Spacing.xxs) {
                    Text("\(Int(progress * 100))")
                        .font(AppTheme.Fonts.title1)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    Text("%")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.xxl) {
        CircularProgressView(progress: 0.25)

        CircularProgressView(progress: 0.65, lineWidth: 10, size: 150)

        CircularProgressView(progress: 1.0, lineWidth: 6, size: 80)
    }
    .padding(AppTheme.Spacing.xl)
}
