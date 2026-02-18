import SwiftUI

struct PeriodCircleView: View {
    let periodDay: Int
    var onLearnMoreTap: () -> Void = {}
    var onEditDatesTap: () -> Void = {}
    @State private var breatheScale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Circle()
                .fill(AppTheme.Colors.periodCircleBg)
                .frame(width: 280, height: 280)
                .scaleEffect(breatheScale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        breatheScale = 1.01
                    }
                }

            VStack(spacing: AppTheme.Spacing.sm) {
                Text("Period:")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.periodCircleText.opacity(0.7))

                Text("Day \(periodDay)")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.periodCircleText)

                Button(action: onLearnMoreTap) {
                    HStack(spacing: AppTheme.Spacing.xs) {
                        Text("What's important today? Learn more")
                            .font(AppTheme.Fonts.subheadline)
                            .foregroundColor(AppTheme.Colors.periodCircleText.opacity(0.7))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.Colors.periodCircleText.opacity(0.7))
                    }
                }

                Button(action: onEditDatesTap) {
                    Text("Edit period dates")
                        .font(AppTheme.Fonts.subheadlineBold)
                        .foregroundColor(AppTheme.Colors.periodCircleBg)
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        .padding(.vertical, AppTheme.Spacing.sm)
                        .background(AppTheme.Colors.textWhite)
                        .clipShape(Capsule())
                }
                .padding(.top, AppTheme.Spacing.xs)
            }
        }
    }
}
