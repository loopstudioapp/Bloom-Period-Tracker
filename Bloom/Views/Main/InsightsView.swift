import SwiftUI

struct InsightsView: View {
    private let articles = InsightArticleData.articles
    private let featured = InsightArticleData.featured
    private let gridColumns = [
        GridItem(.flexible(), spacing: AppTheme.Spacing.md),
        GridItem(.flexible(), spacing: AppTheme.Spacing.md)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
                    // Featured article
                    featuredCard

                    // Section header
                    Text("Popular Insights")
                        .font(AppTheme.Fonts.headline)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .padding(.horizontal, AppTheme.Spacing.lg)

                    // Article grid
                    LazyVGrid(columns: gridColumns, spacing: AppTheme.Spacing.md) {
                        ForEach(articles.dropFirst()) { article in
                            NavigationLink(destination: ArticleDetailView(article: article)) {
                                articleCard(article)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                }
                .padding(.top, AppTheme.Spacing.sm)
                .padding(.bottom, AppTheme.Spacing.xxxl)
                .constrainedWidth()
            }
            .background(AppTheme.Colors.background)
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Featured Card

    private var featuredCard: some View {
        NavigationLink(destination: ArticleDetailView(article: featured)) {
            VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                HStack {
                    // Icon
                    ZStack {
                        Circle()
                            .fill(featured.cardColor)
                            .frame(width: 56, height: 56)

                        Image(systemName: featured.iconName)
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(AppTheme.Colors.textPrimary.opacity(0.7))
                    }

                    Spacer()

                    // Category badge
                    Text(featured.category)
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .padding(.horizontal, AppTheme.Spacing.sm)
                        .padding(.vertical, AppTheme.Spacing.xxs)
                        .background(
                            Capsule()
                                .fill(featured.cardColor.opacity(0.5))
                        )
                }

                Text(featured.title)
                    .font(AppTheme.Fonts.title2)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .multilineTextAlignment(.leading)

                Text(featured.subtitle)
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .lineLimit(2)

                HStack {
                    Text(featured.readTime)
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    Spacer()

                    HStack(spacing: AppTheme.Spacing.xs) {
                        Text("Read")
                            .font(AppTheme.Fonts.subheadlineBold)
                            .foregroundColor(AppTheme.Colors.primaryPink)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(AppTheme.Colors.primaryPink)
                    }
                }
            }
            .padding(AppTheme.Spacing.lg)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large)
                    .fill(featured.cardColor.opacity(0.3))
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large)
                    .stroke(featured.cardColor, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    // MARK: - Article Card

    private func articleCard(_ article: InsightArticle) -> some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            // Icon
            ZStack {
                Circle()
                    .fill(article.cardColor)
                    .frame(width: 44, height: 44)

                Image(systemName: article.iconName)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(AppTheme.Colors.textPrimary.opacity(0.7))
            }

            Text(article.title)
                .font(AppTheme.Fonts.subheadlineBold)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Text(article.subtitle)
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Spacer(minLength: 0)

            Text(article.readTime)
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textSecondary.opacity(0.7))
        }
        .padding(AppTheme.Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 180, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large)
                .stroke(AppTheme.Colors.sectionDivider, lineWidth: 0.5)
        )
    }
}

#Preview {
    InsightsView()
}
