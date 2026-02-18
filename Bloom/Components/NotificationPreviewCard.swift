import SwiftUI

struct NotificationPreviewCard: View {
    var body: some View {
        VStack(spacing: AppTheme.Spacing.xl) {
            // Pink gradient circle with bell icon
            bellIcon

            // Notification banners with depth effect
            ZStack {
                // Background depth card (offset + lower opacity)
                notificationBanner
                    .opacity(0.4)
                    .offset(y: AppTheme.Spacing.sm)
                    .scaleEffect(0.96)

                // Foreground notification card
                notificationBanner
            }
        }
    }

    // MARK: - Bell Icon

    private var bellIcon: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [AppTheme.Colors.primaryPink, AppTheme.Colors.primaryPinkDark],
                        center: .center,
                        startRadius: .zero,
                        endRadius: bellCircleSize / 2
                    )
                )
                .frame(width: bellCircleSize, height: bellCircleSize)

            Image(systemName: "bell.fill")
                .font(.system(size: bellIconSize))
                .foregroundColor(AppTheme.Colors.textWhite)
        }
    }

    // MARK: - Notification Banner

    private var notificationBanner: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            // App icon row
            HStack(spacing: AppTheme.Spacing.sm) {
                // Mini app icon
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: miniIconSize, height: miniIconSize)

                Text("BLOOM")
                    .font(AppTheme.Fonts.captionBold)
                    .foregroundColor(AppTheme.Colors.textSecondary)

                Spacer()

                Text("now")
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            // Bold title
            Text("Your period might start today \u{1F4C5}")
                .font(AppTheme.Fonts.subheadlineBold)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            // Body text
            Text("Log your symptoms for expert tips on how to feel better \u{1F449}")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .subtleShadow()
    }

    // MARK: - Sizes

    private var bellCircleSize: CGFloat { AppTheme.Spacing.xxxl + AppTheme.Spacing.xl }
    private var bellIconSize: CGFloat { AppTheme.Spacing.xxl }
    private var miniIconSize: CGFloat { AppTheme.Spacing.lg }
}

#Preview {
    NotificationPreviewCard()
        .padding(AppTheme.Spacing.xxl)
        .background(AppTheme.Colors.backgroundPink)
}
