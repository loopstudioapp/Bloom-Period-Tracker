import SwiftUI

struct OptionCard: View {
    let title: String
    let iconName: String
    var isSelected: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: AppTheme.Spacing.sm) {
                Image(systemName: iconName)
                    .font(.system(size: iconSize, weight: .medium))
                    .foregroundColor(
                        isSelected
                            ? AppTheme.Colors.primaryPink
                            : AppTheme.Colors.textSecondary
                    )
                    .frame(height: iconContainerHeight)

                Text(title)
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .minimumScaleFactor(0.9)
            }
            .padding(AppTheme.Spacing.md)
            .frame(maxWidth: .infinity)
            .frame(minHeight: cardMinHeight)
            .background(
                isSelected
                    ? AppTheme.Colors.selectedOptionBackground
                    : AppTheme.Colors.optionBackground
            )
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large)
                    .stroke(
                        isSelected ? AppTheme.Colors.primaryPink : Color.clear,
                        lineWidth: selectedBorderWidth
                    )
            )
            .animation(AppTheme.Animation.quick, value: isSelected)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Private Helpers

    private var iconSize: CGFloat { AppTheme.Spacing.xl }
    private var iconContainerHeight: CGFloat { AppTheme.Spacing.xxl }
    private var cardMinHeight: CGFloat { 120 }
    private var selectedBorderWidth: CGFloat { AppTheme.Spacing.xxs }
}

#Preview {
    let columns = [
        GridItem(.flexible(), spacing: AppTheme.Spacing.sm),
        GridItem(.flexible(), spacing: AppTheme.Spacing.sm)
    ]

    LazyVGrid(columns: columns, spacing: AppTheme.Spacing.sm) {
        OptionCard(title: "Sync my sex life with my cycle", iconName: "heart.fill", isSelected: true) {}
        OptionCard(title: "Spot signs of PCOS", iconName: "waveform.path.ecg", isSelected: false) {}
        OptionCard(title: "Manage symptoms", iconName: "flame.fill", isSelected: false) {}
        OptionCard(title: "Decode my discharge", iconName: "drop.fill", isSelected: true) {}
    }
    .padding(AppTheme.Spacing.xl)
}
