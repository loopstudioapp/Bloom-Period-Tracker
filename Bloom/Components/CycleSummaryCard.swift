import SwiftUI

struct CycleSummaryCard: View {
    let metrics: [CycleMetric]
    var onLogPeriods: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("Cycle summary")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .padding(AppTheme.Spacing.md)

            Divider().background(AppTheme.Colors.sectionDivider)

            VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                Text("The more you share with us, the better Bloom works. ")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary) +
                Text("Log 2 or more periods")
                    .font(AppTheme.Fonts.subheadlineBold)
                    .foregroundColor(AppTheme.Colors.textPrimary) +
                Text(" to get personalized analysis of your most recent cycles.")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)

                VStack(spacing: AppTheme.Spacing.sm) {
                    ForEach(metrics) { metric in
                        HStack {
                            Text(metric.label)
                                .font(AppTheme.Fonts.subheadline)
                                .foregroundColor(AppTheme.Colors.textSecondary)
                            Spacer()
                            Text(metric.statusLabel)
                                .font(AppTheme.Fonts.captionBold)
                                .foregroundColor(AppTheme.Colors.textWhite)
                                .padding(.horizontal, AppTheme.Spacing.sm)
                                .padding(.vertical, AppTheme.Spacing.xxs)
                                .background(metric.status.color)
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(AppTheme.Spacing.md)
                .background(AppTheme.Colors.dayDetailSummaryBg)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
            }
            .padding(AppTheme.Spacing.md)

            Button(action: onLogPeriods) {
                Text("Log recent periods")
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.textWhite)
                    .frame(width: 200)
                    .frame(height: AppTheme.ButtonHeight.secondary)
                    .background(AppTheme.Colors.primaryPink)
                    .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, AppTheme.Spacing.md)
        }
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .cardShadow()
    }
}
