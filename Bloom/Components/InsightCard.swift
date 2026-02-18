import SwiftUI

struct InsightCard: View {
    let insight: DailyInsight
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                if insight.type == .symptomInfo {
                    Text(insight.title)
                        .font(AppTheme.Fonts.captionBold)
                        .foregroundColor(AppTheme.Colors.insightCardTitle)
                        .textCase(.uppercase)
                }

                if let iconName = insight.iconName {
                    Spacer()
                    Image(systemName: iconName)
                        .font(.system(size: 32))
                        .foregroundColor(insight.type == .logSymptoms ? AppTheme.Colors.addLogFAB : AppTheme.Colors.primaryPink)
                    Spacer()
                }

                if insight.type != .symptomInfo {
                    Text(insight.title)
                        .font(AppTheme.Fonts.subheadlineBold)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .lineLimit(3)
                }

                if let subtitle = insight.subtitle {
                    Text(subtitle)
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .lineLimit(2)
                }
            }
            .padding(AppTheme.Spacing.md)
            .frame(width: 140, height: 180)
            .background(insight.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large)
                    .stroke(insight.borderColor ?? Color.clear, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }
}
