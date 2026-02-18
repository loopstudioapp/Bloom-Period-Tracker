import SwiftUI

struct CommunityPreviewScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let posts = OnboardingData.communityPosts

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    postsSection

                    ctaSection
                }
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

    // MARK: - Posts Section

    private var postsSection: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            ForEach(Array(posts.enumerated()), id: \.element.id) { index, post in
                CommunityPostCard(post: post)
                    .padding(
                        .leading,
                        index == 1 ? AppTheme.Spacing.lg : .zero
                    )
                    .padding(
                        .trailing,
                        index == 2 ? AppTheme.Spacing.lg : .zero
                    )
                    .padding(
                        .horizontal,
                        index == 0 ? AppTheme.Spacing.lg : .zero
                    )
            }
        }
    }

    // MARK: - CTA Section

    private var ctaSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Text("Join the discussion")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("Connect with millions of people in the Bloom community. Share experiences, ask questions, and support each other.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }
}

#Preview {
    CommunityPreviewScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
