import SwiftUI

struct FriendAvatar: Identifiable {
    let id = UUID()
    let emoji: String
    let color: Color
}

struct FriendAvatarRow: View {
    let avatars: [FriendAvatar]

    var body: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            ForEach(avatars) { avatar in
                ZStack {
                    Circle()
                        .fill(avatar.color)
                        .frame(width: avatarSize, height: avatarSize)

                    Text(avatar.emoji)
                        .font(.system(size: emojiSize))
                }
            }
        }
    }

    // MARK: - Sizes

    private var avatarSize: CGFloat { 44 }
    private var emojiSize: CGFloat { AppTheme.Spacing.lg }
}

#Preview {
    FriendAvatarRow(
        avatars: [
            FriendAvatar(emoji: "🐻", color: AppTheme.Colors.avatarPink),
            FriendAvatar(emoji: "🦊", color: AppTheme.Colors.avatarTeal),
            FriendAvatar(emoji: "🐰", color: AppTheme.Colors.avatarPurple),
            FriendAvatar(emoji: "🐱", color: AppTheme.Colors.orangeAccent),
            FriendAvatar(emoji: "🦉", color: AppTheme.Colors.avatarCoral)
        ]
    )
    .padding(AppTheme.Spacing.md)
}
