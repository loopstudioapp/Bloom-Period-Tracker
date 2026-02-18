import SwiftUI

struct OptionRow: View {
    let title: String
    var subtitle: String? = nil
    var isSelected: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppTheme.Spacing.sm) {
                if isSelected {
                    Rectangle()
                        .fill(AppTheme.Colors.primaryPink)
                        .frame(width: selectedAccentWidth)
                        .clipShape(Capsule())
                }

                VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                    Text(title)
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(AppTheme.Fonts.subheadline)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }
                }

                Spacer()
            }
            .padding(AppTheme.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                isSelected
                    ? AppTheme.Colors.selectedOptionBackground
                    : AppTheme.Colors.optionBackground
            )
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
            .animation(AppTheme.Animation.quick, value: isSelected)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Private Helpers

    private var selectedAccentWidth: CGFloat {
        AppTheme.Spacing.xs
    }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.sm) {
        OptionRow(title: "App Store", isSelected: false) {}
        OptionRow(title: "Friends or Family", subtitle: "Recommended by someone you know", isSelected: true) {}
        OptionRow(title: "TikTok", isSelected: false) {}
    }
    .padding(AppTheme.Spacing.xl)
}
