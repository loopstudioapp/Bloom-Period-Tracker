import SwiftUI

struct ExpandableOptionCard: View {
    let title: String
    var expandedText: String? = nil
    var isSelected: Bool = false
    var showCheckbox: Bool = true
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: AppTheme.Spacing.md) {
                // Title and expanded description
                VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                    Text(title)
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .multilineTextAlignment(.leading)

                    if isSelected, let expandedText = expandedText, !expandedText.isEmpty {
                        Text(expandedText)
                            .font(AppTheme.Fonts.subheadline)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }

                Spacer()

                // Checkbox circle on the right
                if showCheckbox {
                    checkboxIndicator
                        .frame(width: checkboxSize, height: checkboxSize)
                }
            }
            .padding(AppTheme.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                isSelected
                    ? AppTheme.Colors.selectedOptionBackground
                    : AppTheme.Colors.optionBackground
            )
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
            .animation(AppTheme.Animation.spring, value: isSelected)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Private Helpers

    @ViewBuilder
    private var checkboxIndicator: some View {
        if isSelected {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: checkboxSize))
                .foregroundColor(AppTheme.Colors.checkmark)
                .transition(.scale.combined(with: .opacity))
        } else {
            Circle()
                .stroke(AppTheme.Colors.textTertiary, lineWidth: circleStrokeWidth)
                .frame(width: checkboxSize, height: checkboxSize)
        }
    }

    private var checkboxSize: CGFloat { AppTheme.Spacing.xl }
    private var circleStrokeWidth: CGFloat { AppTheme.Spacing.xxs }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.sm) {
        ExpandableOptionCard(
            title: "Mood swings",
            expandedText: "Mood swings are one of the most common PMS symptoms. Bloom can help you track and predict when they might occur.",
            isSelected: true
        ) {}

        ExpandableOptionCard(
            title: "Anxiety",
            expandedText: "Thanks to brain chemistry and hormone fluctuations, women are more likely to experience anxiety than men.",
            isSelected: false
        ) {}

        ExpandableOptionCard(
            title: "Single select without checkbox",
            isSelected: true,
            showCheckbox: false
        ) {}
    }
    .padding(AppTheme.Spacing.xl)
}
