import SwiftUI

struct TopNavBar: View {
    let month: String
    var onCalendarTap: () -> Void = {}

    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            Spacer()

            HStack(spacing: AppTheme.Spacing.sm) {
                Text(month)
                    .font(AppTheme.Fonts.headline)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Button(action: onCalendarTap) {
                    Image(systemName: "calendar")
                        .font(.system(size: 18))
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
            }

            Spacer()
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
        .padding(.vertical, AppTheme.Spacing.sm)
    }
}
