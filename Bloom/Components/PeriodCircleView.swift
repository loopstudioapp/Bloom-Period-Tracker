import SwiftUI

struct PeriodCircleView: View {
    let periodDay: Int
    var fertileDaysAway: Int = 6
    var onLearnMoreTap: () -> Void = {}
    var onEditDatesTap: () -> Void = {}
    var onTemperatureTap: () -> Void = {}

    var body: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            // Fertility countdown
            Text("Best chances of conceiving are in")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.heroSubtitleText)

            Text("\(fertileDaysAway) days")
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .foregroundColor(AppTheme.Colors.heroDaysText)

            // Temperature readings button
            Button(action: onTemperatureTap) {
                HStack(spacing: AppTheme.Spacing.sm) {
                    Image(systemName: "thermometer.medium")
                        .font(.system(size: 16))
                        .foregroundColor(AppTheme.Colors.heroSubtitleText)
                    Text("Get body temperature readings")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.heroSubtitleText)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(AppTheme.Colors.heroSubtitleText)
                }
            }

            // Period day info
            HStack(spacing: AppTheme.Spacing.xs) {
                if periodDay > 0 {
                    Text("Period: Day \(periodDay)")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.heroSubtitleText.opacity(0.8))
                } else {
                    Text("Not on your period")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.heroSubtitleText.opacity(0.8))
                }
                Button(action: onLearnMoreTap) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.Colors.heroSubtitleText.opacity(0.6))
                }
            }
            .padding(.top, AppTheme.Spacing.xs)

            // Edit period dates button
            Button(action: onEditDatesTap) {
                Text("Edit period dates")
                    .font(AppTheme.Fonts.subheadlineBold)
                    .foregroundColor(AppTheme.Colors.primaryPink)
                    .padding(.horizontal, AppTheme.Spacing.xl)
                    .padding(.vertical, AppTheme.Spacing.sm + 2)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
            .padding(.top, AppTheme.Spacing.xs)
        }
        .padding(.vertical, AppTheme.Spacing.xl)
    }
}
