import SwiftUI

struct SymptomPatternCard: View {
    let pattern: SymptomPattern

    // Column count for the cycle grid
    private let columnCount = 12

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            // Header row
            headerRow

            // Description
            Text(pattern.description)
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)

            // Cycle visualization grid
            cycleGrid

            // Legend
            legendRow

            // Doctor's comment button
            doctorCommentButton
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .cardShadow()
    }

    // MARK: - Header

    private var headerRow: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            ZStack {
                Circle()
                    .fill(pattern.iconColor.opacity(0.2))
                    .frame(width: iconCircleSize, height: iconCircleSize)

                Image(systemName: pattern.icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(pattern.iconColor)
            }

            Text(pattern.symptomName)
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            Image(systemName: "info.circle")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }

    // MARK: - Cycle Grid

    private var cycleGrid: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
            // Column headers (1–12)
            HStack(spacing: .zero) {
                Color.clear
                    .frame(width: rowLabelWidth, height: 1)

                ForEach(1...columnCount, id: \.self) { number in
                    Text("\(number)")
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textTertiary)
                        .frame(maxWidth: .infinity)
                }
            }

            // Data rows
            ForEach(Array(pattern.cycleData.enumerated()), id: \.offset) { index, row in
                HStack(spacing: .zero) {
                    Text(rowLabel(for: index))
                        .font(.system(size: AppTheme.ResponsiveLayout.scaled(9), weight: .regular, design: .rounded))
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .frame(width: rowLabelWidth, alignment: .leading)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    ForEach(0..<columnCount, id: \.self) { col in
                        let state = col < row.count ? row[col] : .empty
                        cycleDot(for: state)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding(AppTheme.Spacing.sm)
        .background(AppTheme.Colors.dayDetailSummaryBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small))
    }

    // MARK: - Cycle Dot

    @ViewBuilder
    private func cycleDot(for state: CycleDotState) -> some View {
        switch state {
        case .period:
            Circle()
                .fill(AppTheme.Colors.dotPeriod)
                .frame(width: dotSize, height: dotSize)
        case .fertile:
            Circle()
                .fill(AppTheme.Colors.dotFertile)
                .frame(width: dotSize, height: dotSize)
        case .ovulation:
            Circle()
                .fill(AppTheme.Colors.dotOvulation)
                .frame(width: dotSize, height: dotSize)
        case .normal:
            Circle()
                .fill(AppTheme.Colors.dotNormal)
                .frame(width: dotSize, height: dotSize)
        case .symptom:
            ZStack {
                Circle()
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: dotSize, height: dotSize)

                Image(systemName: "battery.25")
                    .font(.system(size: 5))
                    .foregroundColor(AppTheme.Colors.textWhite)
            }
        case .empty:
            Circle()
                .fill(Color.clear)
                .frame(width: dotSize, height: dotSize)
        }
    }

    // MARK: - Legend

    private var legendRow: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            legendItem(color: AppTheme.Colors.dotPeriod, label: "Period")
            legendItem(color: AppTheme.Colors.dotFertile, label: "Fertile days")
            legendItem(color: AppTheme.Colors.dotOvulation, label: "Ovulation")
        }
        .frame(maxWidth: .infinity)
    }

    private func legendItem(color: Color, label: String) -> some View {
        HStack(spacing: AppTheme.Spacing.xs) {
            Circle()
                .fill(color)
                .frame(width: legendDotSize, height: legendDotSize)

            Text(label)
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }

    // MARK: - Doctor Comment Button

    private var doctorCommentButton: some View {
        HStack {
            Spacer()
            Button(action: {}) {
                Text("See doctor's comment")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.vertical, AppTheme.Spacing.sm)
                    .background(AppTheme.Colors.dayDetailSummaryBg)
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
            Spacer()
        }
    }

    // MARK: - Row Labels

    private func rowLabel(for index: Int) -> String {
        let labels = ["Jan 25 Current", "Dec 26 30 days", "Nov 26 28 days"]
        return index < labels.count ? labels[index] : "Cycle \(index + 1)"
    }

    // MARK: - Sizes

    private var iconCircleSize: CGFloat { AppTheme.Spacing.xxl + AppTheme.Spacing.sm }
    private var dotSize: CGFloat { AppTheme.ResponsiveLayout.scaled(10) }
    private var legendDotSize: CGFloat { AppTheme.Spacing.sm }
    private var rowLabelWidth: CGFloat { AppTheme.ResponsiveLayout.scaled(72) }
}

#Preview {
    SymptomPatternCard(
        pattern: SymptomPattern(
            symptomName: "Fatigue",
            icon: "battery.25",
            iconColor: AppTheme.Colors.orangeAccent,
            description: "You reported fatigue in 67% of your tracked cycles, mainly during the luteal phase.",
            percentage: 67,
            cycleData: [
                [.period, .period, .period, .period, .normal, .normal, .normal, .symptom, .symptom, .fertile, .ovulation, .normal],
                [.period, .period, .period, .normal, .normal, .symptom, .symptom, .normal, .fertile, .fertile, .ovulation, .normal],
                [.period, .period, .period, .period, .normal, .normal, .symptom, .symptom, .symptom, .fertile, .ovulation, .normal]
            ]
        )
    )
    .padding(AppTheme.Spacing.md)
    .background(AppTheme.Colors.backgroundLight)
}
