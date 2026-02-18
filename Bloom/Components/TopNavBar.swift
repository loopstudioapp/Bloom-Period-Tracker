import SwiftUI

struct TopNavBar: View {
    let month: String
    let notificationCount: Int
    var onAvatarTap: () -> Void = {}
    var onCalendarTap: () -> Void = {}
    var onNotificationTap: () -> Void = {}

    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            Button(action: onAvatarTap) {
                ZStack(alignment: .topTrailing) {
                    BearAvatarView(size: 36, backgroundColor: AppTheme.Colors.bearAvatarBlue)

                    Circle()
                        .fill(AppTheme.Colors.tabBarBadgeBg)
                        .frame(width: 10, height: 10)
                        .offset(x: 2, y: -2)
                }
            }

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

            Button(action: onNotificationTap) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bell")
                        .font(.system(size: 18))
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    if notificationCount > 0 {
                        Text("\(notificationCount)")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(AppTheme.Colors.textWhite)
                            .frame(width: 16, height: 16)
                            .background(AppTheme.Colors.settingsAlertBg)
                            .clipShape(Circle())
                            .offset(x: 6, y: -6)
                    }
                }
            }
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
        .padding(.vertical, AppTheme.Spacing.sm)
    }
}
