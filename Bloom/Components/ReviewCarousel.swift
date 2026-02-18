// /Users/infinity/Desktop/Period Tracker/Bloom/Components/ReviewCarousel.swift
import SwiftUI

struct ReviewCarousel: View {
    let reviews: [PaywallReview]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppTheme.Spacing.md) {
                ForEach(reviews) { review in
                    reviewCard(review)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
        }
    }

    private func reviewCard(_ review: PaywallReview) -> some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            // Stars
            HStack(spacing: AppTheme.Spacing.xxs) {
                ForEach(0..<review.rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.Colors.paywallGold)
                }
            }

            Text(review.text)
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textWhite.opacity(0.9))
                .lineLimit(4)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: AppTheme.Spacing.sm) {
                Circle()
                    .fill(review.avatarColor)
                    .frame(width: 28, height: 28)
                    .overlay(
                        Text(review.initial)
                            .font(AppTheme.Fonts.captionBold)
                            .foregroundColor(AppTheme.Colors.textWhite)
                    )

                Text(review.name)
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.paywallTextMuted)
            }
        }
        .padding(AppTheme.Spacing.md)
        .frame(width: 240)
        .background(AppTheme.Colors.paywallCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
    }
}
