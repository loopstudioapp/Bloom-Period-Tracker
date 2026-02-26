import SwiftUI

struct ArticleDetailView: View {
    let article: InsightArticle
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // Hero header
                heroHeader

                // Content
                VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
                    // Subtitle
                    Text(article.subtitle)
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    // Key points
                    ForEach(article.keyPoints) { point in
                        keyPointSection(point)
                    }

                    // Sources note
                    sourcesFooter
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.lg)
                .padding(.bottom, AppTheme.Spacing.xxxl)
            }
        }
        .background(AppTheme.Colors.background)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Hero Header

    private var heroHeader: some View {
        ZStack {
            article.cardColor
                .frame(height: 200)

            VStack(spacing: AppTheme.Spacing.md) {
                Image(systemName: article.iconName)
                    .font(.system(size: 48, weight: .light))
                    .foregroundColor(AppTheme.Colors.textPrimary.opacity(0.6))

                Text(article.title)
                    .font(AppTheme.Fonts.title2)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .multilineTextAlignment(.center)

                HStack(spacing: AppTheme.Spacing.sm) {
                    Text(article.category)
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .padding(.horizontal, AppTheme.Spacing.sm)
                        .padding(.vertical, AppTheme.Spacing.xxs)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.6))
                        )

                    Text(article.readTime)
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
        }
    }

    // MARK: - Key Point Section

    private func keyPointSection(_ point: ArticleKeyPoint) -> some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            // Heading with accent bar
            HStack(spacing: AppTheme.Spacing.sm) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: 3, height: 20)

                Text(point.heading)
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }

            Text(point.body)
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(AppTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                .fill(article.cardColor.opacity(0.2))
        )
    }

    // MARK: - Sources Footer

    private var sourcesFooter: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Divider()
                .padding(.vertical, AppTheme.Spacing.sm)

            HStack(spacing: AppTheme.Spacing.sm) {
                Image(systemName: "checkmark.shield.fill")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.Colors.tealAccent)

                Text("Medically reviewed content")
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            Text("Information sourced from Mayo Clinic, Cleveland Clinic, ACOG, and NHS guidelines. This content is for educational purposes and is not a substitute for professional medical advice.")
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textSecondary.opacity(0.7))
                .lineSpacing(3)
        }
    }
}

#Preview {
    NavigationStack {
        ArticleDetailView(article: InsightArticleData.featured)
    }
}
