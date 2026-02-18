// /Users/infinity/Desktop/Period Tracker/Bloom/Components/ComparisonCard.swift
import SwiftUI

struct ComparisonCard: View {
    let item: ComparisonItem

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text(item.feature)
                .font(AppTheme.Fonts.subheadlineBold)
                .foregroundColor(AppTheme.Colors.textSecondary)

            HStack(spacing: AppTheme.Spacing.md) {
                // Without Bloom side
                VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                    HStack(spacing: AppTheme.Spacing.xs) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(AppTheme.Colors.sadBlueGray)
                            .font(.system(size: 14))
                        Text("Without Bloom")
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.sadBlueGray)
                    }
                    Text(item.withoutBloom)
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(AppTheme.Spacing.md)
                .background(AppTheme.Colors.sadGrayBackground)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))

                // With Bloom side
                VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                    HStack(spacing: AppTheme.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(AppTheme.Colors.bloomGreen)
                            .font(.system(size: 14))
                        Text("With Bloom")
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.bloomGreen)
                    }
                    Text(item.withBloom)
                        .font(AppTheme.Fonts.subheadlineBold)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(AppTheme.Spacing.md)
                .background(AppTheme.Colors.commitmentPinkLight)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
            }
        }
    }
}
