import SwiftUI

struct OnboardingMultiSelect: View {
    let socialProofText: String
    let questionTitle: String
    let options: [(label: String, expandedDescription: String)]
    let selectedValues: Set<String>
    let onToggle: (String) -> Void
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
            // Social proof text
            Text(socialProofText)
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .padding(.top, AppTheme.Spacing.md)

            // Question title
            Text(questionTitle)
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            // Options list
            ScrollView {
                VStack(spacing: AppTheme.Spacing.sm) {
                    ForEach(Array(options.enumerated()), id: \.offset) { _, option in
                        ExpandableOptionCard(
                            title: option.label,
                            expandedText: option.expandedDescription,
                            isSelected: selectedValues.contains(option.label),
                            showCheckbox: true,
                            action: { onToggle(option.label) }
                        )
                    }
                }
            }

            Spacer()

            // Next button
            PillButton(
                title: "Next",
                style: .primary,
                isEnabled: !selectedValues.isEmpty,
                action: onNext
            )
            .padding(.bottom, AppTheme.Spacing.md)
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
        .background(AppTheme.Colors.background)
    }
}

#Preview {
    OnboardingMultiSelect(
        socialProofText: "72% of Bloom users track their mental health",
        questionTitle: "Do you experience any of these?",
        options: [
            (label: "Mood swings", expandedDescription: "Mood swings are one of the most common PMS symptoms."),
            (label: "Anxiety", expandedDescription: "Women are more likely to experience anxiety than men."),
            (label: "Fatigue", expandedDescription: "Feeling drained at certain points in your cycle is normal."),
            (label: "Irritability", expandedDescription: "Fluctuating hormones affect how tolerant we are.")
        ],
        selectedValues: ["Mood swings", "Fatigue"],
        onToggle: { _ in },
        onNext: {}
    )
}
