import SwiftUI

struct SocialProofCard: View {
    let initial: String
    let username: String
    let text: String
    var avatarColor: Color = AppTheme.Colors.avatarPink
    var alignment: HorizontalAlignment = .leading

    var body: some View {
        VStack(alignment: alignment, spacing: AppTheme.Spacing.md) {
            // Avatar and username
            VStack(spacing: AppTheme.Spacing.xs) {
                Circle()
                    .fill(avatarColor)
                    .frame(width: avatarSize, height: avatarSize)
                    .overlay(
                        Text(initial)
                            .font(AppTheme.Fonts.bodyBold)
                            .foregroundColor(AppTheme.Colors.textWhite)
                    )

                Text(username)
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            // Quoted text
            Text("\"\(text)\"")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(textAlignment)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(AppTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: frameAlignment)
        .background(AppTheme.Colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .cardShadow()
    }

    // MARK: - Private Helpers

    private var avatarSize: CGFloat { 40 }

    private var textAlignment: TextAlignment {
        switch alignment {
        case .leading: return .leading
        case .trailing: return .trailing
        default: return .center
        }
    }

    private var frameAlignment: Alignment {
        switch alignment {
        case .leading: return .leading
        case .trailing: return .trailing
        default: return .center
        }
    }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.md) {
        SocialProofCard(
            initial: "S",
            username: "sarah_k",
            text: "I've tried so many apps but Bloom actually predicted my period correctly.",
            avatarColor: AppTheme.Colors.avatarPink,
            alignment: .leading
        )

        SocialProofCard(
            initial: "M",
            username: "maya_j",
            text: "The insights about how my cycle affects my mood have been life-changing.",
            avatarColor: AppTheme.Colors.avatarTeal,
            alignment: .trailing
        )
    }
    .padding(AppTheme.Spacing.xl)
    .background(AppTheme.Colors.backgroundLight)
}
