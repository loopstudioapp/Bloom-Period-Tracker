import SwiftUI

struct ProfileCard: View {
    let email: String
    let isPremium: Bool
    var onEditTap: () -> Void = {}

    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            // Avatar with edit badge
            avatarWithBadge

            // Email and edit link
            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text(email)
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.settingsProfileText)
                    .lineLimit(1)

                Button(action: onEditTap) {
                    Text("Edit info")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
                .buttonStyle(.plain)
            }

            Spacer()

            // Premium badge
            if isPremium {
                premiumBadge
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.settingsProfileCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }

    // MARK: - Avatar With Edit Badge

    private var avatarWithBadge: some View {
        ZStack(alignment: .bottomTrailing) {
            BearAvatarView(
                size: avatarSize,
                backgroundColor: AppTheme.Colors.bearAvatarBlue
            )

            ZStack {
                Circle()
                    .fill(AppTheme.Colors.settingsProfileCardBg)
                    .frame(width: editBadgeSize + badgeBorderWidth, height: editBadgeSize + badgeBorderWidth)

                Circle()
                    .fill(AppTheme.Colors.textSecondary)
                    .frame(width: editBadgeSize, height: editBadgeSize)

                Image(systemName: "pencil")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(AppTheme.Colors.textWhite)
            }
            .offset(x: AppTheme.Spacing.xxs, y: AppTheme.Spacing.xxs)
        }
    }

    // MARK: - Premium Badge

    private var premiumBadge: some View {
        Text("Bloom Premium")
            .font(AppTheme.Fonts.captionBold)
            .foregroundColor(AppTheme.Colors.textWhite)
            .padding(.horizontal, AppTheme.Spacing.sm)
            .padding(.vertical, AppTheme.Spacing.xs)
            .background(AppTheme.Colors.primaryPink)
            .clipShape(Capsule())
    }

    // MARK: - Sizes

    private var avatarSize: CGFloat { AppTheme.ResponsiveLayout.scaled(56) }
    private var editBadgeSize: CGFloat { AppTheme.Spacing.lg }
    private var badgeBorderWidth: CGFloat { AppTheme.Spacing.xs }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.md) {
        ProfileCard(
            email: "sarah@example.com",
            isPremium: true
        )

        ProfileCard(
            email: "user@bloom.app",
            isPremium: false
        )
    }
    .padding(AppTheme.Spacing.md)
    .background(AppTheme.Colors.backgroundLight)
}
