import SwiftUI

struct FeaturePreviewScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let columns = [
        GridItem(.flexible(), spacing: AppTheme.Spacing.md),
        GridItem(.flexible(), spacing: AppTheme.Spacing.md)
    ]

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    featureGrid

                    subtitleSection

                    Spacer()
                        .frame(height: AppTheme.Spacing.xxl)
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
            }

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Feature Grid

    private var featureGrid: some View {
        LazyVGrid(columns: columns, spacing: AppTheme.Spacing.md) {
            ForEach(OnboardingData.featureItems) { item in
                FeatureCard(
                    title: item.title,
                    backgroundColor: item.backgroundColor,
                    iconType: item.iconType
                )
            }
        }
    }

    // MARK: - Subtitle Section

    private var subtitleSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Text("You're in the right place!")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Text("Bloom has tracked over 2.2 billion cycles")
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    FeaturePreviewScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
