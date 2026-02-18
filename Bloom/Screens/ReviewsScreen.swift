import SwiftUI

struct ReviewsScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let reviews = OnboardingData.reviewItems

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.md) {
                    // First two review cards
                    reviewCard(reviews[0])
                    reviewCard(reviews[1])

                    // Center rating highlight
                    ratingHighlight

                    // Last two review cards
                    reviewCard(reviews[2])
                    reviewCard(reviews[3])
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Review Card with Alignment

    private func reviewCard(_ review: ReviewItem) -> some View {
        HStack {
            if review.alignment == .trailing {
                Spacer()
                    .frame(width: AppTheme.Spacing.xxl)
            }

            SocialProofCard(
                initial: review.initial,
                username: review.username,
                text: review.text,
                avatarColor: review.avatarColor,
                alignment: review.alignment
            )

            if review.alignment == .leading {
                Spacer()
                    .frame(width: AppTheme.Spacing.xxl)
            }
        }
    }

    // MARK: - Rating Highlight

    private var ratingHighlight: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Text("3.5M+")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.primaryPink)

            HStack(spacing: AppTheme.Spacing.xs) {
                ForEach(0..<5, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(AppTheme.Colors.orangeAccent)
                        .font(AppTheme.Fonts.body)
                }
            }

            HStack(spacing: AppTheme.Spacing.sm) {
                Image(systemName: "leaf.fill")
                    .foregroundColor(AppTheme.Colors.textTertiary)
                    .font(AppTheme.Fonts.caption)

                Text("5 star ratings")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)

                Image(systemName: "leaf.fill")
                    .foregroundColor(AppTheme.Colors.textTertiary)
                    .font(AppTheme.Fonts.caption)
                    .scaleEffect(x: -1, y: 1)
            }
        }
        .padding(.vertical, AppTheme.Spacing.lg)
    }
}

#Preview {
    ReviewsScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
