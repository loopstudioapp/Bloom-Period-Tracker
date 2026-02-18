import SwiftUI

struct CommunityPostCard: View {
    let post: CommunityPost

    var body: some View {
        HStack(alignment: .top, spacing: AppTheme.Spacing.md) {
            // Thumbnail color block
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                .fill(post.thumbnailColor)
                .frame(width: thumbnailSize, height: thumbnailSize)

            // Content
            VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                Text(post.question)
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                HStack(spacing: AppTheme.Spacing.md) {
                    // Likes
                    HStack(spacing: AppTheme.Spacing.xs) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: iconSize))
                            .foregroundColor(AppTheme.Colors.primaryPink)

                        Text(post.likes)
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }

                    // Comments
                    HStack(spacing: AppTheme.Spacing.xs) {
                        Image(systemName: "bubble.right.fill")
                            .font(.system(size: iconSize))
                            .foregroundColor(AppTheme.Colors.textTertiary)

                        Text(post.comments)
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }
                }
            }

            Spacer()
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
        .cardShadow()
    }

    // MARK: - Private Helpers

    private var thumbnailSize: CGFloat { 60 }
    private var iconSize: CGFloat { AppTheme.Spacing.md - AppTheme.Spacing.xs }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.md) {
        ForEach(OnboardingData.communityPosts) { post in
            CommunityPostCard(post: post)
        }
    }
    .padding(AppTheme.Spacing.xl)
    .background(AppTheme.Colors.backgroundLight)
}
