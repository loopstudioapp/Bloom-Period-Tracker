import SwiftUI

struct SymptomGrid: View {
    let symptoms: [TodaySymptom]
    let selectedSymptoms: Set<String>
    let onToggle: (String) -> Void
    let onApply: () -> Void

    private let columns = Array(repeating: GridItem(.flexible(), spacing: AppTheme.Spacing.md), count: 3)

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            // Symptom grid
            LazyVGrid(columns: columns, spacing: AppTheme.Spacing.lg) {
                ForEach(symptoms) { symptom in
                    symptomCell(symptom)
                        .onTapGesture {
                            onToggle(symptom.name)
                        }
                }
            }

            // Apply button
            PillButton(
                title: "Apply the symptoms",
                style: .primary,
                isEnabled: !selectedSymptoms.isEmpty,
                action: onApply
            )
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .cardShadow()
    }

    // MARK: - Symptom Cell

    @ViewBuilder
    private func symptomCell(_ symptom: TodaySymptom) -> some View {
        let isSelected = selectedSymptoms.contains(symptom.name)
        let isNone = symptom.name == "None of these"

        VStack(spacing: AppTheme.Spacing.sm) {
            ZStack(alignment: .bottomTrailing) {
                // Circle background
                Circle()
                    .fill(isNone ? AppTheme.Colors.optionBackground : AppTheme.Colors.featurePink)
                    .frame(width: iconCircleSize, height: iconCircleSize)
                    .overlay(
                        isSelected
                            ? Circle().stroke(AppTheme.Colors.selectionPurple, lineWidth: 2.5)
                            : nil
                    )

                // SF Symbol icon
                Image(systemName: symptom.iconName)
                    .font(.system(size: iconFontSize))
                    .foregroundColor(symptom.iconColor)
                    .frame(width: iconCircleSize, height: iconCircleSize)

                // Selected checkmark badge
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: badgeSize))
                        .foregroundColor(AppTheme.Colors.blueAccent)
                        .background(
                            Circle()
                                .fill(AppTheme.Colors.cardBackground)
                                .frame(width: badgeSize + AppTheme.Spacing.xxs, height: badgeSize + AppTheme.Spacing.xxs)
                        )
                        .offset(x: AppTheme.Spacing.xxs, y: AppTheme.Spacing.xxs)
                }
            }

            // Label
            Text(symptom.name)
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .animation(AppTheme.Animation.quick, value: isSelected)
    }

    // MARK: - Sizes

    private var iconCircleSize: CGFloat { AppTheme.Spacing.xxxl + AppTheme.Spacing.md }
    private var iconFontSize: CGFloat { AppTheme.Spacing.xl }
    private var badgeSize: CGFloat { AppTheme.Spacing.md }
}

#Preview {
    SymptomGrid(
        symptoms: OnboardingData.todaySymptoms,
        selectedSymptoms: ["Cramps", "Bloating"],
        onToggle: { _ in },
        onApply: {}
    )
    .padding(AppTheme.Spacing.xl)
    .background(AppTheme.Colors.backgroundLight)
}
