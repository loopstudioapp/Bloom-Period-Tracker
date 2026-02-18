import SwiftUI

struct SymptomChip: View {
    let icon: String
    let title: String
    let isSelected: Bool
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: AppTheme.Spacing.sm) {
                Text(icon)
                    .font(.system(size: 16))
                Text(title)
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(AppTheme.Colors.primaryPink)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)
            .padding(.vertical, AppTheme.Spacing.sm)
            .background(isSelected ? AppTheme.Colors.selectedChipBg : AppTheme.Colors.unselectedChipBg)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? AppTheme.Colors.selectedChipBorder : Color.clear, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }
}
