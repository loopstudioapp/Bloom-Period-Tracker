import SwiftUI

struct OnboardingSingleSelect: View {
    let socialProofText: String
    let questionTitle: String
    let options: [StatQuestionOption]
    var selectedValue: String? = nil
    var showExpandedText: Bool = true
    var autoAdvance: Bool = false
    let onSelect: (String) -> Void
    var onNext: (() -> Void)? = nil

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
                    ForEach(options) { option in
                        SelectableOptionRow(
                            title: option.label,
                            description: showExpandedText ? option.expandedDescription : nil,
                            isSelected: selectedValue == option.label,
                            action: { onSelect(option.label) }
                        )
                    }
                }
            }

            Spacer()

            // Next button (only if not auto-advancing)
            if !autoAdvance, let onNext = onNext {
                PillButton(
                    title: "Next",
                    style: .primary,
                    isEnabled: selectedValue != nil,
                    action: onNext
                )
                .padding(.bottom, AppTheme.Spacing.md)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
        .background(AppTheme.Colors.background)
    }
}

#Preview {
    OnboardingSingleSelect(
        socialProofText: "80% of Bloom users track their cycle weekly",
        questionTitle: "Does your diet change during your cycle?",
        options: [
            StatQuestionOption(label: "Yes", expandedDescription: "Ever wondered why you're more hungry before your period? Check out our articles."),
            StatQuestionOption(label: "No", expandedDescription: ""),
            StatQuestionOption(label: "I'm not sure", expandedDescription: "")
        ],
        selectedValue: "Yes",
        onSelect: { _ in },
        onNext: {}
    )
}
