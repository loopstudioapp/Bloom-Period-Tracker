import SwiftUI

struct CycleHistoryCard: View {
    let currentCycle: CycleEntry
    let previousCycles: [CycleEntry]
    var onSeeAll: () -> Void = {}
    var onLogPrevious: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack {
                Text("Cycle history")
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                Spacer()
                Button(action: onSeeAll) {
                    Text("See all ›")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            .padding(AppTheme.Spacing.md)

            Divider().background(AppTheme.Colors.sectionDivider)

            // Current cycle row
            Button(action: {}) {
                HStack {
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                        Text("Current cycle: \(currentCycle.periodLength) days")
                            .font(AppTheme.Fonts.bodyBold)
                            .foregroundColor(AppTheme.Colors.textPrimary)

                        HStack(spacing: AppTheme.Spacing.xs) {
                            Text("Started \(formattedDate(currentCycle.startDate))")
                                .font(AppTheme.Fonts.caption)
                                .foregroundColor(AppTheme.Colors.textSecondary)

                            HStack(spacing: 3) {
                                ForEach(0..<currentCycle.periodLength, id: \.self) { _ in
                                    Circle()
                                        .fill(AppTheme.Colors.dotPeriod)
                                        .frame(width: 8, height: 8)
                                }
                            }
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.Colors.textTertiary)
                }
                .padding(AppTheme.Spacing.md)
            }
            .buttonStyle(.plain)

            // Previous cycles
            ForEach(previousCycles) { cycle in
                Divider().background(AppTheme.Colors.sectionDivider)

                Button(action: {}) {
                    HStack {
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                            Text("\(cycle.cycleLength ?? 0) days")
                                .font(AppTheme.Fonts.bodyBold)
                                .foregroundColor(AppTheme.Colors.textPrimary)

                            HStack(spacing: AppTheme.Spacing.xs) {
                                Text("\(formattedDate(cycle.startDate)) – \(formattedDate(cycle.endDate ?? Date()))")
                                    .font(AppTheme.Fonts.caption)
                                    .foregroundColor(AppTheme.Colors.textSecondary)

                                CycleDotStrip(periodDays: cycle.periodLength, totalDays: cycle.cycleLength ?? 30)
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(AppTheme.Colors.textTertiary)
                    }
                    .padding(AppTheme.Spacing.md)
                }
                .buttonStyle(.plain)
            }

            Divider().background(AppTheme.Colors.sectionDivider)

            Button(action: onLogPrevious) {
                HStack(spacing: AppTheme.Spacing.sm) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(AppTheme.Colors.primaryPink)
                    Text("Log previous cycles")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.primaryPink)
                }
                .frame(maxWidth: .infinity)
                .padding(AppTheme.Spacing.md)
            }
        }
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .cardShadow()
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
}
