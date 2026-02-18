import SwiftUI

struct WeightTracker: View {
    let weight: Double

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Image(systemName: "scalemass")
                    .font(.system(size: 20))
                    .foregroundColor(AppTheme.Colors.weightIconColor)

                Text("Weight")
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "trash")
                        .font(.system(size: 16))
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                Button(action: {}) {
                    Image(systemName: "pencil")
                        .font(.system(size: 16))
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }

            HStack(alignment: .firstTextBaseline, spacing: AppTheme.Spacing.xs) {
                Text(String(format: "%.1f", weight))
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textPrimary)
                Text("lbs.")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            Button(action: {}) {
                HStack {
                    Text("View chart")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.Colors.textTertiary)
                }
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }
}
