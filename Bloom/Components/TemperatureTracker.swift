import SwiftUI

struct TemperatureTracker: View {
    let temperature: Double?

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Image(systemName: "thermometer.medium")
                    .font(.system(size: 20))
                    .foregroundColor(AppTheme.Colors.tempIconColor)

                Text("Basal temperature")
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

            if let temp = temperature {
                HStack(alignment: .firstTextBaseline, spacing: AppTheme.Spacing.xs) {
                    Text(String(format: "%.1f", temp))
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Colors.textPrimary)
                    Text("°F")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            } else {
                Text("Log your temperature")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }
}
