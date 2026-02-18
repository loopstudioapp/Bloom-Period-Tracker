import SwiftUI

struct DayDetailPanel: View {
    let dateText: String
    let cycleDay: Int
    let dayLog: DayLog?
    let insights: [DailyInsight]
    var onClose: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            // Header with pink left border
            headerSection

            // Symptoms and activities
            VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                Text("Symptoms and activities")
                    .font(AppTheme.Fonts.subheadlineBold)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                loggedDataStrip
            }

            // Daily insights
            if !insights.isEmpty {
                insightsSection
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.dayDetailBg)
    }

    // MARK: - Header

    private var headerSection: some View {
        HStack(alignment: .top) {
            HStack(spacing: AppTheme.Spacing.sm) {
                // Pink left vertical border
                RoundedRectangle(cornerRadius: AppTheme.Spacing.xxs)
                    .fill(AppTheme.Colors.reportBorderLeft)
                    .frame(width: borderWidth)

                VStack(alignment: .leading, spacing: AppTheme.Spacing.xxs) {
                    Text(dateText)
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    Text("Cycle day \(cycleDay)")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }

            Spacer()

            Button(action: onClose) {
                ZStack {
                    Circle()
                        .fill(AppTheme.Colors.dayDetailSummaryBg)
                        .frame(width: closeButtonSize, height: closeButtonSize)

                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: - Logged Data Strip

    private var loggedDataStrip: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppTheme.Spacing.sm) {
                // Flow
                if let flow = dayLog?.menstrualFlow {
                    loggedDataIcon(emoji: flow.icon, label: flow.rawValue)
                }

                // Weight
                if let weight = dayLog?.weightLbs {
                    loggedDataIcon(systemIcon: "scalemass.fill", label: "\(Int(weight)) lbs", color: AppTheme.Colors.weightIconColor)
                }

                // Steps
                if let steps = dayLog?.steps {
                    loggedDataIcon(systemIcon: "figure.walk", label: "\(steps)", color: AppTheme.Colors.tealAccent)
                }

                // Water
                if (dayLog?.waterOz ?? 0) > 0 {
                    loggedDataIcon(systemIcon: "drop.fill", label: "\(dayLog?.waterOz ?? 0) oz", color: AppTheme.Colors.waterIconColor)
                }

                // Sex
                if let sexActivities = dayLog?.sexActivity, !sexActivities.isEmpty {
                    loggedDataIcon(systemIcon: "heart.fill", label: "Sex", color: AppTheme.Colors.primaryPink)
                }

                // Add log FAB
                addLogButton
            }
            .padding(AppTheme.Spacing.sm)
            .background(AppTheme.Colors.dayDetailSummaryBg)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
        }
    }

    private func loggedDataIcon(emoji: String? = nil, systemIcon: String? = nil, label: String, color: Color = AppTheme.Colors.textSecondary) -> some View {
        VStack(spacing: AppTheme.Spacing.xs) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: dataIconSize, height: dataIconSize)

                if let emoji = emoji {
                    Text(emoji)
                        .font(.system(size: 16))
                } else if let systemIcon = systemIcon {
                    Image(systemName: systemIcon)
                        .font(.system(size: 14))
                        .foregroundColor(color)
                }
            }

            Text(label)
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .lineLimit(1)
        }
        .frame(width: dataItemWidth)
    }

    private var addLogButton: some View {
        Button(action: {}) {
            ZStack {
                Circle()
                    .fill(AppTheme.Colors.addLogFAB)
                    .frame(width: fabSize, height: fabSize)

                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppTheme.Colors.textWhite)
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Insights Section

    private var insightsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("My daily insights")
                .font(AppTheme.Fonts.subheadlineBold)
                .foregroundColor(AppTheme.Colors.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.sm) {
                    ForEach(insights) { insight in
                        InsightCard(insight: insight)
                    }
                }
            }
        }
    }

    // MARK: - Sizes

    private var borderWidth: CGFloat { AppTheme.Spacing.xs }
    private var closeButtonSize: CGFloat { AppTheme.Spacing.xxl }
    private var dataIconSize: CGFloat { 40 }
    private var dataItemWidth: CGFloat { 56 }
    private var fabSize: CGFloat { 44 }
}

#Preview {
    DayDetailPanel(
        dateText: "February 14",
        cycleDay: 8,
        dayLog: DayLog(
            date: Date(),
            symptoms: ["Cramps", "Fatigue"],
            menstrualFlow: .medium,
            sexActivity: ["Protected sex"],
            waterOz: 64,
            weightLbs: 135,
            steps: 8500,
            basalTemp: nil,
            mood: "Calm"
        ),
        insights: MainInsightData.todayInsights
    )
    .background(AppTheme.Colors.backgroundLight)
}
