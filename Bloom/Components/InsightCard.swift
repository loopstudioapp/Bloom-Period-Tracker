import SwiftUI

struct InsightCard: View {
    let insight: DailyInsight
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                // Title at top
                Text(insight.title)
                    .font(AppTheme.Fonts.subheadlineBold)
                    .foregroundColor(
                        insight.type == .logSymptoms
                            ? AppTheme.Colors.textPrimary
                            : (insight.type == .symptomInfo ? AppTheme.Colors.insightCardTitle : AppTheme.Colors.textPrimary)
                    )
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                Spacer()

                // Icon or CTA at bottom
                if let iconName = insight.iconName {
                    HStack {
                        Spacer()
                        Image(systemName: iconName)
                            .font(.system(size: 36))
                            .foregroundColor(
                                insight.type == .logSymptoms
                                    ? AppTheme.Colors.addLogFAB
                                    : AppTheme.Colors.primaryPink.opacity(0.7)
                            )
                    }
                }

                if let ctaText = insight.ctaText {
                    Text(ctaText)
                        .font(AppTheme.Fonts.subheadlineBold)
                        .foregroundColor(AppTheme.Colors.primaryPink)
                }
            }
            .padding(AppTheme.Spacing.md)
            .frame(width: AppTheme.ResponsiveLayout.insightCardWidth, height: AppTheme.ResponsiveLayout.insightCardHeight)
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
