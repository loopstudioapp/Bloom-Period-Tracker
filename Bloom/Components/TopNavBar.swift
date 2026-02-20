import SwiftUI

struct TopNavBar: View {
    let month: String
    var onCalendarTap: () -> Void = {}

    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            // App logo
            ZStack {
                Circle()
                    .fill(AppTheme.Colors.tealAccent)
                    .frame(width: 36, height: 36)
                Text("🐻")
                    .font(.system(size: 18))
                    .offset(y: -1)
                Circle()
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: 10, height: 10)
                    .offset(x: 12, y: -12)
            }

            Spacer()

            Text(month)
                .font(AppTheme.Fonts.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            Button(action: onCalendarTap) {
                Image(systemName: "calendar")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
        .padding(.vertical, AppTheme.Spacing.sm)
    }
}
