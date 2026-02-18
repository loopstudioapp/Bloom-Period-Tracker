import SwiftUI

struct PartnerInviteScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let features = [
        "Share your cycle phase predictions so they're empowered to support you.",
        "Tune them into your sex drive.",
        "Boost your connection and communication."
    ]

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.lg) {
                    PartnerIllustration()
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height * 0.35)

                    titleSection

                    featuresList
                }
                .padding(.top, AppTheme.Spacing.md)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            buttonsSection
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Title

    private var titleSection: some View {
        VStack(spacing: AppTheme.Spacing.xs) {
            Text("Supercharge your sex lives with")
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("Bloom for Partners")
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.primaryPink)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
    }

    // MARK: - Features List

    private var featuresList: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            ForEach(features, id: \.self) { feature in
                HStack(alignment: .top, spacing: AppTheme.Spacing.md) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(AppTheme.Colors.checkmark)

                    Text(feature)
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
    }

    // MARK: - Buttons

    private var buttonsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            PillButton(title: "Invite my partner", style: .primary) {
                viewModel.wantsPartnerInvite = true
                coordinator.advance()
            }

            Button {
                coordinator.advance()
            } label: {
                Text("I'm not interested")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppTheme.Spacing.sm)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
        .padding(.bottom, AppTheme.Spacing.xl)
    }
}

#Preview {
    PartnerInviteScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
