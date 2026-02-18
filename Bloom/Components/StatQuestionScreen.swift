import SwiftUI

struct StatQuestionScreen: View {
    let statText: String
    let questionTitle: String
    let options: [StatQuestionOption]
    let selectedValue: String?
    let onSelect: (String) -> Void
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
            // Stat text line
            Text(statText)
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
                    ForEach(options) { option in
                        SelectableOptionRow(
                            title: option.label,
                            description: option.expandedDescription,
                            isSelected: selectedValue == option.label,
                            action: { onSelect(option.label) }
                        )
                    }
                }
            }

            Spacer()

            // Next button
            PillButton(
                title: "Next",
                style: .primary,
                isEnabled: selectedValue != nil,
                action: onNext
            )
            .padding(.bottom, AppTheme.Spacing.md)
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
        .background(AppTheme.Colors.background)
    }
}

#Preview {
    StatQuestionScreen(
        statText: "80% of Bloom users log symptoms weekly",
        questionTitle: "Do you experience cramps during your period?",
        options: [
            StatQuestionOption(label: "Yes, every cycle", expandedDescription: "Cramps are very common and affect most people during their period."),
            StatQuestionOption(label: "Sometimes", expandedDescription: "Occasional cramps can vary in intensity from cycle to cycle."),
            StatQuestionOption(label: "Rarely or never", expandedDescription: "Some people are lucky enough to rarely experience cramps.")
        ],
        selectedValue: "Yes, every cycle",
        onSelect: { _ in },
        onNext: {}
    )
}
