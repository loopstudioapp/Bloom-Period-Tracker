import SwiftUI

struct AlertBanner: View {
    let message: String
    let actionTitle: String
    var onAction: () -> Void = {}

    var body: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            // Warning icon + message
            HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(AppTheme.Colors.settingsAlertText)

                Text(message)
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.settingsAlertText)
                    .fixedSize(horizontal: false, vertical: true)
            }

            // Action button
            Button(action: onAction) {
                Text(actionTitle)
                    .font(AppTheme.Fonts.subheadlineBold)
                    .foregroundColor(AppTheme.Colors.settingsAlertBg)
                    .padding(.horizontal, AppTheme.Spacing.xl)
                    .padding(.vertical, AppTheme.Spacing.sm)
                    .background(
                        Capsule()
                            .fill(AppTheme.Colors.settingsAlertText)
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(AppTheme.Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                .fill(AppTheme.Colors.settingsAlertBg)
        )
    }
}

#Preview {
    AlertBanner(
        message: "Your subscription has expired. Renew to continue accessing premium features.",
        actionTitle: "Renew Now"
    )
    .padding(AppTheme.Spacing.md)
}
