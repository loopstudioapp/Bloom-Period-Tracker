import SwiftUI

struct ArticleCardsCollage: View {
    private let width: CGFloat = 340
    private let height: CGFloat = 300

    var body: some View {
        ZStack {
            // Card 1: Blue — top-left
            articleCard(
                icon: "hand.raised.fill",
                title: "How to clean\nyour vagina",
                color: AppTheme.Colors.articleBlue,
                cardWidth: width * 0.3,
                cardHeight: height * 0.32
            )
            .rotationEffect(.degrees(-3))
            .offset(x: -width * 0.27, y: -height * 0.25)

            // Card 2: Pink — top-right
            articleCard(
                icon: "heart.circle.fill",
                title: "5 sex therapy\nsecrets",
                color: AppTheme.Colors.primaryPink,
                cardWidth: width * 0.28,
                cardHeight: height * 0.3
            )
            .rotationEffect(.degrees(2))
            .offset(x: width * 0.05, y: -height * 0.28)

            // Card 3: Large pink — right
            articleCard(
                icon: "exclamationmark.shield.fill",
                title: "What to do\nafter unprotected\nsex",
                color: AppTheme.Colors.primaryPinkDark,
                cardWidth: width * 0.32,
                cardHeight: height * 0.38
            )
            .rotationEffect(.degrees(4))
            .offset(x: width * 0.28, y: -height * 0.05)

            // Card 4: Purple — center-left
            articleCard(
                icon: "calendar.badge.clock",
                title: "What Counts\nas a Late\nPeriod?",
                color: AppTheme.Colors.articlePurple,
                cardWidth: width * 0.3,
                cardHeight: height * 0.35
            )
            .rotationEffect(.degrees(-2))
            .offset(x: -width * 0.28, y: height * 0.1)

            // Card 5: Peach — center
            articleCard(
                icon: "drop.fill",
                title: "Discharge:\nWhat to Look\nOut For",
                color: AppTheme.Colors.articlePeach,
                cardWidth: width * 0.28,
                cardHeight: height * 0.32
            )
            .rotationEffect(.degrees(1))
            .offset(x: width * 0.02, y: height * 0.12)

            // Card 6: Small pink — bottom-right
            articleCard(
                icon: "sparkles",
                title: "7 Non-\nPenetrative\nSex Ideas",
                color: AppTheme.Colors.avatarPink,
                cardWidth: width * 0.24,
                cardHeight: height * 0.28
            )
            .rotationEffect(.degrees(-3))
            .offset(x: width * 0.3, y: height * 0.3)
        }
        .frame(width: width, height: height)
    }

    // MARK: - Article Card

    private func articleCard(
        icon: String,
        title: String,
        color: Color,
        cardWidth: CGFloat,
        cardHeight: CGFloat
    ) -> some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                .fill(color)
                .frame(width: cardWidth, height: cardHeight)

            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Image(systemName: icon)
                    .font(.system(size: cardWidth * 0.15))
                    .foregroundColor(AppTheme.Colors.textWhite.opacity(0.9))

                Text(title)
                    .font(.system(size: 8, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textWhite)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
            }
            .padding(AppTheme.Spacing.sm)
        }
        .subtleShadow()
    }
}

#Preview {
    ArticleCardsCollage()
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.backgroundPink)
}
