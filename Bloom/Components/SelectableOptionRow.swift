import SwiftUI

struct SelectableOptionRow: View {
    let title: String
    var description: String? = nil
    var emoji: String? = nil
    var isSelected: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: AppTheme.Spacing.md) {
                // Emoji or checkmark indicator
                leadingIndicator
                    .frame(width: indicatorSize, height: indicatorSize)

                // Title and expandable description
                VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                    Text(title)
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .multilineTextAlignment(.leading)

                    if isSelected, let description = description, !description.isEmpty {
                        Text(description)
                            .font(AppTheme.Fonts.subheadline)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }

                Spacer()

                // Checkmark
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: checkmarkSize))
                        .foregroundColor(AppTheme.Colors.checkmark)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(AppTheme.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                isSelected
                    ? AppTheme.Colors.selectedOptionBackground
                    : AppTheme.Colors.optionBackground
            )
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
            .animation(AppTheme.Animation.spring, value: isSelected)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Private Helpers

    @ViewBuilder
    private var leadingIndicator: some View {
        if let emoji = emoji {
            Text(emoji)
                .font(.system(size: emojiSize))
        } else {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .font(.system(size: radioSize))
                .foregroundColor(
                    isSelected
                        ? AppTheme.Colors.checkmark
                        : AppTheme.Colors.textTertiary
                )
        }
    }

    private var indicatorSize: CGFloat { AppTheme.Spacing.xl }
    private var checkmarkSize: CGFloat { AppTheme.Spacing.xl }
    private var emojiSize: CGFloat { AppTheme.Spacing.lg }
    private var radioSize: CGFloat { AppTheme.Spacing.lg }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.sm) {
        SelectableOptionRow(
            title: "To know when my period is coming",
            description: "Get accurate predictions so you're never caught off guard.",
            isSelected: true
        ) {}

        SelectableOptionRow(
            title: "To improve my sex life",
            description: "Learn how your cycle affects desire and energy.",
            isSelected: false
        ) {}

        SelectableOptionRow(
            title: "It's a love-hate relationship",
            description: "Some days it feels like a superpower, other days it's the worst.",
            emoji: "🙄",
            isSelected: true
        ) {}

        SelectableOptionRow(
            title: "Embarrassed",
            emoji: "🫣",
            isSelected: false
        ) {}
    }
    .padding(AppTheme.Spacing.xl)
}
