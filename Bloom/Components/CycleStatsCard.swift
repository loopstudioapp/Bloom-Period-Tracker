import SwiftUI

struct CycleStatsCard: View {
    let rows: [CycleStatsRow]

    var body: some View {
        VStack(spacing: .zero) {
            ForEach(Array(rows.enumerated()), id: \.element.id) { index, row in
                statsRow(row)

                if index < rows.count - 1 {
                    Divider()
                        .background(AppTheme.Colors.divider)
                        .padding(.horizontal, AppTheme.Spacing.md)
                }
            }
        }
        .background(AppTheme.Colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .cardShadow()
    }

    // MARK: - Stats Row

    @ViewBuilder
    private func statsRow(_ row: CycleStatsRow) -> some View {
        HStack(alignment: .center) {
            // Left side: label and value
            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text(row.label)
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)

                Text(row.value)
                    .font(AppTheme.Fonts.title3)
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }

            Spacer()

            // Right side: info icon and status badge
            HStack(spacing: AppTheme.Spacing.sm) {
                if row.showInfoIcon {
                    Image(systemName: "info.circle.fill")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textTertiary)
                }

                statusBadge(for: row)
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(
            row.statusType == .irregular
                ? AppTheme.Colors.irregularYellow
                : Color.clear
        )
        .overlay(alignment: .leading) {
            if row.statusType == .irregular {
                Rectangle()
                    .fill(AppTheme.Colors.irregularOrange.opacity(0.3))
                    .frame(width: AppTheme.Spacing.xs)
            }
        }
    }

    // MARK: - Status Badge

    @ViewBuilder
    private func statusBadge(for row: CycleStatsRow) -> some View {
        HStack(spacing: AppTheme.Spacing.xs) {
            switch row.statusType {
            case .normal:
                Image(systemName: "checkmark.circle.fill")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.normalGreen)
                Text(row.statusLabel)
                    .font(AppTheme.Fonts.captionBold)
                    .foregroundColor(AppTheme.Colors.normalGreen)

            case .irregular:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.irregularOrange)
                Text(row.statusLabel)
                    .font(AppTheme.Fonts.captionBold)
                    .foregroundColor(AppTheme.Colors.irregularOrange)
            }
        }
    }
}

#Preview {
    CycleStatsCard(rows: OnboardingData.cycleStatsRows)
        .padding(AppTheme.Spacing.xl)
        .background(AppTheme.Colors.backgroundLight)
}
